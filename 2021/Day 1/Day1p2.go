package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"time"
)

func main() {
	start := time.Now()
	var lines []int
	file, _ := os.Open("./input")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line, _ := strconv.Atoi(scanner.Text())
		lines = append(lines, line)
	}
	counter := 0
	for i := 0; i < len(lines)-3; i++ {
		lowerWindowSum := lines[i] + lines[i+1] + lines[i+2]
		higherWindowSum := lines[i+1] + lines[i+2] + lines[i+3]
		if higherWindowSum > lowerWindowSum {
			counter++
		}

	}
	fmt.Println(counter)
	elapsed := time.Since(start)
	fmt.Printf("Duration: %s", elapsed)

}
