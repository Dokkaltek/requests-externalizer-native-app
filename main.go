package main

import (
	"bufio"
	"bytes"
	"encoding/binary"
	"encoding/json"
	"errors"
	"io"
	"log"
	"os"
	"path"
	"regexp"
	"strings"
	"unsafe"
)

// Constants for Logger
var (
	// Trace logs general information messages.
	Trace *log.Logger
	// Error logs error messages.
	Error *log.Logger
)

// nativeEndian used to detect native byte order
var nativeEndian binary.ByteOrder

// bufferSize used to set size of IO buffer - adjust to accommodate message payloads
var bufferSize = 8196

// IncomingMessage represents a message sent to the native host.
type IncomingMessage struct {
	Value string `json:"value"`
}

// InitLogs initializes logger and determines native byte order.
func InitLogs(traceHandle io.Writer, errorHandle io.Writer) {
	Trace = log.New(traceHandle, "TRACE: ", log.Ldate|log.Ltime)
	Error = log.New(errorHandle, "ERROR: ", log.Ldate|log.Ltime)

	// determine native byte order so that we can read message size correctly
	var one int16 = 1
	b := (*byte)(unsafe.Pointer(&one))
	if *b == 0 {
		nativeEndian = binary.BigEndian
	} else {
		nativeEndian = binary.LittleEndian
	}
}

func Init(ioCalls OSCalls) {
	cacheDir, err := os.UserCacheDir()
	cacheDir = path.Join(cacheDir, "Requests-externalizer")

	if err != nil {
		log.Fatal("Couldn't find user cache folder.", err)
	}

	err = ioCalls.MkdirAll(cacheDir, 0750)

	if err != nil {
		log.Print("Couldn't create log holder folder.", err)
	}

	logPath := path.Join(cacheDir, "requests-externalizer-native-host-log.log")

	// Make sure that the log doesn't increase too much in size
	clearLogFileIfNeeded(logPath, ioCalls)

	file, err := ioCalls.OpenFile(logPath, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		InitLogs(os.Stdout, os.Stderr)
		Error.Printf("Unable to create and/or open log file. Will log to Stdout and Stderr. Error: %v", err)
	} else {
		InitLogs(file, file)
		// Ensure we close the log file when we're done
		defer closeFile(file)
	}

	read(ioCalls)
	Trace.Print("Native messaging host exited.")
}

// main starts the application
func main() {
	Init(IOCalls{})
}

// read creates a new buffered I/O reader and reads messages from Stdin.
func read(ioCalls OSCalls) {
	s := bufio.NewReaderSize(os.Stdin, bufferSize)
	Trace.Printf("READING...")

	lengthBytes := make([]byte, 4)
	lengthNum := 0

	// We're going to indefinitely read the first 4 bytes in buffer, which gives us the message length.
	// if stdIn is closed we'll exit the loop and shut down host
	for b, err := s.Read(lengthBytes); b > 0 && err == nil; b, err = s.Read(lengthBytes) {
		lengthNum = readMessageLength(lengthBytes)
		Trace.Printf("Message size in bytes: %v", lengthNum)

		// If message length exceeds size of buffer, the message will be truncated.
		// This will likely cause an error when we attempt to unmarshal message to JSON.
		if lengthNum > bufferSize {
			Error.Printf("Message size of %d exceeds buffer size of %d. "+
				"Message will be truncated and is unlikely to unmarshal to JSON.", lengthNum, bufferSize)
		}

		// read the content of the message from buffer
		content := make([]byte, lengthNum)
		_, err = s.Read(content)
		if err != nil && err != io.EOF {
			Error.Fatal(err)
		}

		// message has been read, now parse and process
		iMsg := decodeMessage(content)
		Trace.Printf("Message received: %s", content)

		executeCommand(iMsg.Value, ioCalls)
	}

	Trace.Print("Stdin closed.")
}

// readMessageLength reads and returns the message length value in native byte order.
func readMessageLength(msg []byte) int {
	var length uint32
	buf := bytes.NewBuffer(msg)
	err := binary.Read(buf, nativeEndian, &length)
	if err != nil {
		Error.Printf("Unable to read bytes representing message length: %v", err)
	}
	return int(length)
}

// decodeMessage unmarshalls incoming json request and returns query value.
func decodeMessage(msg []byte) IncomingMessage {
	var iMsg IncomingMessage
	err := json.Unmarshal(msg, &iMsg)
	if err != nil {
		Error.Printf("Unable to unmarshal json to struct: %v", err)
	}
	return iMsg
}

// executeCommand executes the received command in the terminal.
func executeCommand(command string, ioCalls OSCalls) {
	if len(strings.Trim(command, " ")) == 0 {
		Trace.Printf("Command was empty, considering it as a health check.")
		return
	}

	Trace.Printf("Command received was '%s'", command)

	// Split by quotation marks or spaces and remove them from the app call
	re := regexp.MustCompile(`(?m)["'].*?["']|\S.\S*`)
	commandArgs := re.FindAllString(command, -1)

	commandArgs[0] = strings.ReplaceAll(commandArgs[0], "\"", "'")
	commandArgs[0] = strings.ReplaceAll(commandArgs[0], "'", "")

	Trace.Printf("Executing command '%s' with args: %s", commandArgs[0], commandArgs[1:])

	// Execute all commands from cmd on windows for better support of batch files
	err := ioCalls.RunCommand(commandArgs)

	if err != nil {
		Error.Printf("There was an error while executing the command: %v", err)
	}
}

// closeFile closes a file
func closeFile(file OSFile) {
	err := file.Close()
	if err != nil {
		panic(err)
	}
}

// clearLogFileIfNeeded removes the log file if it becomes too big, so that it doesn't take too much space
func clearLogFileIfNeeded(logPath string, ioCalls OSCalls) {
	fileInfo, err := ioCalls.Stat(logPath)

	// Checks for the error
	if err != nil {
		if !errors.Is(err, os.ErrNotExist) {
			log.Println("Couldn't open the log file.")
		}
		return
	}

	// Remove the file if its size is over 5mb so that the log doesn't become too big
	if fileInfo.Size() > (1024 * 1024 * 5) {
		err := os.Remove(logPath)
		if err != nil {
			log.Println("Couldn't remove the log file.")
			return
		}
	}
}
