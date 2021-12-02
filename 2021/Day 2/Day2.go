package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func loadFile(filename string) *os.File {
	file, error := os.Open(filename)
	if error != nil {
		panic(error)
	}
	return file
}

func part1(file *os.File, name string) {
	file.Seek(0, 0)
	scanner := bufio.NewScanner(file)
	horizontal := 0
	depth := 0
	for scanner.Scan() {
		line := scanner.Text()
		command := string(line[0])
		value, _ := strconv.Atoi(string(line[len(line)-1]))
		switch command {
		case "f":
			horizontal += value
		case "u":
			depth -= value
		case "d":
			depth += value
		}
	}
	fmt.Printf("Final Horizontal: %d \n", horizontal)
	fmt.Printf("Final Depth: %d \n", depth)
	fmt.Printf("Part 1 %s Result: %d \n", name, horizontal*depth)

}

func part2(file *os.File, name string) {
	file.Seek(0, 0)
	scanner := bufio.NewScanner(file)
	horizontal := 0
	aim := 0
	depth := 0
	for scanner.Scan() {
		line := scanner.Text()
		command := string(line[0])
		value, _ := strconv.Atoi(string(line[len(line)-1]))
		switch command {
		case "f":
			horizontal += value
			depth += aim * value
		case "u":
			aim -= value
		case "d":
			aim += value
		}
	}
	fmt.Printf("Final Horizontal: %d \n", horizontal)
	fmt.Printf("Final Depth: %d \n", depth)
	fmt.Printf("Part 2 %s Result: %d \n", name, horizontal*depth)

}

func main() {
	example := loadFile("./example")
	input := loadFile("./input")
	defer input.Close()
	defer example.Close()
	part1(example, "Example")
	part1(input, "Proper")
	part2(example, "Example")
	part2(input, "Proper")

}
