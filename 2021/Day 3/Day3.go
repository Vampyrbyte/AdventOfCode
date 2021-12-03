package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func loadFile(filename string) []string {
	file, error := os.Open(filename)
	defer file.Close()
	if error != nil {
		panic(error)
	}
	scanner := bufio.NewScanner(file)
	var lines []string
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return lines
}

func part1(input []string, name string) {
	var values []int
	var gamma []int
	var epsilon []int
	var count int
	var gammaint int64
	var gammastr string
	var epsilonstr string
	var epsilonint int64
	for range input[0] {
		values = append(values, 0)
	}
	for _, line := range input {
		count++
		for index, char := range line {
			num := 0
			num, _ = strconv.Atoi(string(char))
			values[index] += num
		}
	}
	for _, gammabit := range values {
		gamma = append(gamma, (gammabit / (count / 2)))
		epsilon = append(epsilon, (count/gammabit)-1)
	}
	gammastr = strings.Trim(strings.Replace(fmt.Sprint(gamma), " ", "", -1), "[]")
	epsilonstr = strings.Trim(strings.Replace(fmt.Sprint(epsilon), " ", "", -1), "[]")
	gammaint, _ = strconv.ParseInt(gammastr, 2, 0)
	epsilonint, _ = strconv.ParseInt(epsilonstr, 2, 0)
	fmt.Printf("Part 1 %s Gamma: %d\n", name, gammaint)
	fmt.Printf("Part 1 %s Epsilon: %d\n", name, epsilonint)
	fmt.Printf("Part 1 %s Power: %d\n", name, epsilonint*gammaint)

}

func part2(input []string, name string) {
	var kept, prevkept []string
	var onescount int
	var o2int, co2int int64
	var o2str, co2str string
	numbits := len(input[0])
	kept = append([]string(nil), input...)
	for i := 0; i < numbits; i++ {
		onescount = 0
		for _, line := range kept {
			num := 0
			num, _ = strconv.Atoi(string(line[i]))
			onescount += num
		}
		prevkept = nil
		prevkept = append([]string(nil), kept...)
		kept = nil
		if onescount >= len(prevkept)-onescount {
			for _, line := range prevkept {
				if string(line[i]) == "1" {
					kept = append(kept, line)
				}
			}
		} else {
			for _, line := range prevkept {
				if string(line[i]) == "0" {
					kept = append(kept, line)
				}
			}
		}
	}
	o2str = strings.Trim(strings.Replace(fmt.Sprint(kept), " ", "", -1), "[]")
	kept = append([]string(nil), input...)
	for i := 0; i < numbits; i++ {
		onescount = 0
		for _, line := range kept {
			num := 0
			num, _ = strconv.Atoi(string(line[i]))
			onescount += num
		}
		prevkept = nil
		prevkept = append([]string(nil), kept...)
		kept = nil
		if onescount >= len(prevkept)-onescount {
			for _, line := range prevkept {
				if string(line[i]) == "0" {
					kept = append(kept, line)
				}
			}
		} else {
			for _, line := range prevkept {
				if string(line[i]) == "1" {
					kept = append(kept, line)
				}
			}
		}
		if len(kept) == 1 {
			break
		}
	}
	co2str = strings.Trim(strings.Replace(fmt.Sprint(kept), " ", "", -1), "[]")
	o2int, _ = strconv.ParseInt(o2str, 2, 0)
	co2int, _ = strconv.ParseInt(co2str, 2, 0)
	fmt.Printf("Part 2 %s O2: %d\n", name, o2int)
	fmt.Printf("Part 2 %s CO2: %d\n", name, co2int)
	fmt.Printf("Part 2 %s Life Support Rating: %d\n", name, o2int*co2int)
}

func main() {
	example := loadFile("./example")
	input := loadFile("./input")
	//part1(example, "Example")
	//part1(input, "Input")
	part2(example, "Example")
	part2(input, "Input")
}
