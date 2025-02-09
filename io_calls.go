package main

import (
	"os"
	"os/exec"
	"runtime"
	"strings"
	"syscall"
)

// OSCalls is an interface used to do IO operations at the OS level
type OSCalls interface {
	OpenFile(name string, flag int, perm os.FileMode) (OSFile, error)
	Stat(name string) (OSFileSize, error)
	Remove(name string) error
	MkdirAll(path string, perm os.FileMode) error
	RunCommand(cmd []string) error
}

// OSFile is an interface that allows us to read, write and close a file
type OSFile interface {
	Read(b []byte) (int, error)
	Write(b []byte) (int, error)
	Close() error
}

// OSFileSize is an interface to get the size of a file
type OSFileSize interface {
	Size() int64
}

// FileSize implements OSFileSize
type FileSize struct {
	size int64
}

// IOCalls implements OSCalls
type IOCalls struct {
}

// File is an interface used to be able to mock IO operations on tests
type File struct {
	file *os.File
}

// Read implementation of OSFile Read method
func (f File) Read(b []byte) (int, error) {
	return f.file.Read(b)
}

// Write implementation of OSFile Write method
func (f File) Write(b []byte) (int, error) {
	return f.file.Write(b)
}

// Close implementation of OSFile Close method
func (f File) Close() error {
	return f.file.Close()
}

// Size implementation of OSFileSize Size method
func (f FileSize) Size() int64 {
	return f.size
}

// OpenFile implementation of OSCalls OpenFile method
func (i IOCalls) OpenFile(name string, flag int, perm os.FileMode) (OSFile, error) {
	file, err := os.OpenFile(name, flag, perm)

	return File{file}, err
}

// Stat implementation of OSCalls Stat method
func (i IOCalls) Stat(name string) (OSFileSize, error) {
	fileInfo, err := os.Stat(name)

	if fileInfo != nil {
		return FileSize{fileInfo.Size()}, err
	}
	return FileSize{0}, err
}

// Remove implementation of OSCalls Remove method
func (i IOCalls) Remove(name string) error {
	return os.Remove(name)
}

// MkdirAll implementation of OSCalls MkdirAll method
func (i IOCalls) MkdirAll(path string, perm os.FileMode) error {
	return os.MkdirAll(path, perm)
}

// RunCommand implementation of OSCalls RunCommand method
func (i IOCalls) RunCommand(commandArgs []string) error {
	var cmd *exec.Cmd

	if runtime.GOOS == "windows" && len(commandArgs) > 2 {
		cmd = exec.Command(commandArgs[0])
		cmd.SysProcAttr = &syscall.SysProcAttr{
			CreationFlags: syscall.CREATE_NEW_PROCESS_GROUP,
			CmdLine:       strings.Join(commandArgs[1:], " "),
		}
	} else {
		cmd = exec.Command(commandArgs[0], commandArgs[1:]...)
	}

	return cmd.Run()
}
