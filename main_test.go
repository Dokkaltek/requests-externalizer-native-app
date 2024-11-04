package main

import (
	"github.com/golang/mock/gomock"
	"log"
	"os"
	"testing"
)

type MockFile struct {
	data []byte
	readIndex int64
	expectedErr  error
}

type MockFileSize struct {
	size int64
}

// Read allows subtests to mock reading
func (mrc MockFile) Read(p []byte) (n int, err error) {
	return len(p), mrc.expectedErr
}

// Write allow subtests to mock writing
func (mrc MockFile) Write(p []byte) (n int, err error) {
	return len(p), mrc.expectedErr
}

// do nothing on close
func (mrc MockFile) Close() error { return nil }

// return a mock filesize
func (mfs MockFileSize) Size() int64 { return mfs.size }

// TestMainHealthCheck tests the health check command send
func TestMainHealthCheck(t *testing.T) {
	mockCtrl := gomock.NewController(t)
	m := NewMockOSCalls(mockCtrl)

	testInputCmd := "    {\"value\": \"\"}"

	mockStdin, oldStdin := mockStdin(testInputCmd)
	defer cleanStdinMock(mockStdin, oldStdin)

	// Mock OpenFile
	m.EXPECT().OpenFile(gomock.Any(), gomock.Eq(os.O_APPEND|os.O_CREATE|os.O_WRONLY),
		gomock.Any()).Return(MockFile{}, nil)

	// Mock Stat
	m.EXPECT().Stat(gomock.Any()).Return(MockFileSize{50}, nil)

	// Make sure that RunCommands isn't called
	m.EXPECT().RunCommand(gomock.Any()).Times(0)

	// Call main function
	Init(m)
}

// TestMainHealthCheck tests the health check command send
func TestMainCommandRun(t *testing.T) {
	mockCtrl := gomock.NewController(t)
	m := NewMockOSCalls(mockCtrl)

	testInputCmd := "{\"value\": \"echo 'Hello world'\"}"

	mockStdin, oldStdin := mockStdin(testInputCmd)
	defer cleanStdinMock(mockStdin, oldStdin)

	// Mock OpenFile
	m.EXPECT().OpenFile(gomock.Any(), gomock.Eq(os.O_APPEND|os.O_CREATE|os.O_WRONLY),
		gomock.Any()).Return(MockFile{}, nil)

	// Mock Stat
	m.EXPECT().Stat(gomock.Any()).Return(MockFileSize{50}, nil)

	// Make sure that RunCommands isn't called
	m.EXPECT().RunCommand(gomock.Any()).Return(nil)

	// Call main function
	Init(m)
}

// mockStdin mocks stdin and returns its old value
func mockStdin(text string) (*os.File, *os.File) {
	// Add length on the first 4 bytes like stdin and then append text
	content := []byte{byte(len(text)), 0, 0, 0}
	content = append(content, []byte(text)...)

	// Create temporary file to mock stdin
	tmpFile, err := os.CreateTemp("", "test")
	if err != nil {
		log.Fatal(err)
	}

	if _, err := tmpFile.Write(content); err != nil {
		log.Fatal(err)
	}

	if _, err := tmpFile.Seek(0, 0); err != nil {
		log.Fatal(err)
	}

	oldStdin := os.Stdin

	os.Stdin = tmpFile

	// Restore stdin and delete temporary files

	return tmpFile, oldStdin
}

// cleanStdinMock cleans the remains of stdin and restores it to its old value
func cleanStdinMock(mockStdin *os.File, oldStdin *os.File) {
	os.Stdin = oldStdin

	closeErr := mockStdin.Close()
	err := os.Remove(mockStdin.Name())
	if err != nil || closeErr != nil {
		log.Fatal(err)
	}
}