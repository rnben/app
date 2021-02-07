package main

import (
	"fmt"
	"strings"

	"github.com/rnben/app/build"
)

var (
	Version   = "development"
	goversion = ""
)

func main() {
	arrs := strings.Split(goversion, " ")

	fmt.Printf("%-13s: %s\n", "App.Version", Version)
	fmt.Printf("%-13s: %s\n", "Go.Version", fmt.Sprintf("%s %s", arrs[2], arrs[3]))
	fmt.Printf("%-13s: %s\n", "Build.Time", build.Time)
	fmt.Printf("%-13s: %s\n", "Build.Commit", build.Commit)
}
