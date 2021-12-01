package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	previousValue := 65535
	count := 0
	file, _ := os.Open("./input")
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		lineint, _ := strconv.Atoi(line)
		if lineint > previousValue {
			count++
		}
		previousValue = lineint
	}
	fmt.Println(count)
}
