/**
 * CSI2120 - 2021W
 *
 * Comprehensive Assignment Part 2
 * knapsackRec.go
 *
 * @author Xiaoxuan Wang 300133594
 */

package main

import (
    "bufio"
    "fmt"
    "math"
    "os"
    "regexp"
    "runtime"
    "strconv"
    "strings"
    "time"
)

// Global variables
var maxForkDepth int = 0

// Datatype definition for an Item
type Item struct {
    name   string
    value  int
    weight int
}

// Datatype definition for a Knapsack
type Knapsack struct {
    weightCapacity int
    itemCapacity   int

    items      []*Item
    itemCount  int
    weightFree int
    totalValue int
}

// Knapsack struct MUST be created by this function, in order to initialize the internal slice
func CreateKnapsack(itemCapacity int, weightCapacity int) (knapsack *Knapsack) {
    knapsack = new(Knapsack)

    knapsack.weightCapacity = weightCapacity
    knapsack.itemCapacity = itemCapacity

    knapsack.items = make([]*Item, itemCapacity)
    knapsack.itemCount = 0
    knapsack.weightFree = weightCapacity
    knapsack.totalValue = 0

    return
}

// Receivers for Knapsack datatype
func (this *Knapsack) isFit(item *Item) bool {
    if item == nil {
        return false
    }
    if this.itemCount >= this.itemCapacity {
        return false
    }
    if item.weight > this.weightFree {
        return false
    }
    return true
}

func (this *Knapsack) put(item *Item) bool {
    if this.isFit(item) {
        this.items[this.itemCount] = item
        this.itemCount++
        this.weightFree -= item.weight
        this.totalValue += item.value
        return true
    } else {
        return false
    }
}

func (this *Knapsack) pop() (item *Item) {
    if this.itemCount > 0 {
        this.itemCount--
        item = this.items[this.itemCount]

        this.weightFree += item.weight
        this.totalValue -= item.value

        return
    } else {
        return nil
    }
}

func (this *Knapsack) set(knapsack *Knapsack) {
    if knapsack == nil {
        return
    }

    *this = *knapsack
    this.items = make([]*Item, cap(knapsack.items))
    copy(this.items, knapsack.items)
}

// Concurrent version
func solveConcurrent(knapsack *Knapsack, bestKnapsack *Knapsack, items []Item, prevChannel chan *Knapsack) {
    if len(items) > 0 && knapsack.weightCapacity > 0 {
        last := len(items) - 1
        // Threshold of using single-threaded method
        if last < cap(items) - maxForkDepth {
            // println("Not forking")
            solveSingle(knapsack, bestKnapsack, items)
            prevChannel <- bestKnapsack
        } else {
            // println("fork!")
            nextChannel := make(chan *Knapsack)

            if knapsack.isFit(&items[last]) {
                // We have left and right branch available
                // Duplicate knapsacks to avoid concurrent conflicts
                knapsackRight := knapsack
                knapsackLeft := CreateKnapsack(knapsack.itemCapacity, knapsack.weightCapacity)
                knapsackLeft.set(knapsack)
                knapsackLeft.put(&items[last])
                
                bestKnapsackRight := bestKnapsack
                bestKnapsackLeft := CreateKnapsack(bestKnapsack.itemCapacity, bestKnapsack.weightCapacity)
                bestKnapsackLeft.set(bestKnapsack)

                go solveConcurrent(knapsackLeft, bestKnapsackLeft, items[:last], nextChannel)
                go solveConcurrent(knapsackRight, bestKnapsackRight, items[:last], nextChannel)

                // Receiving two results, with receiving order undetermined
                bestKnapsack1 := <-nextChannel
                bestKnapsack2 := <-nextChannel
                close(nextChannel)

                // Compare which bestKnapsack is the best, and return it through prevChannel
                if bestKnapsack1.totalValue > bestKnapsack2.totalValue {
                    prevChannel <- bestKnapsack1
                } else {
                    prevChannel <- bestKnapsack2
                }
            } else {
                // We have no choice but go to the right branch
                go solveConcurrent(knapsack, bestKnapsack, items[:last], nextChannel)
                prevChannel <- <-nextChannel
                close(nextChannel)
            }
        }
    } else {
        prevChannel <- bestKnapsack
    }
    return
}

// Single-threaded version
func solveSingle(knapsack *Knapsack, bestKnapsack *Knapsack, items []Item) {
    if len(items) > 0 && knapsack.weightCapacity > 0 {
        last := len(items) - 1
        success := knapsack.put(&items[last])
        /*
         * For this recursion:
         *
         * If success == true, then we are going in the left branch of the binary tree
         *     i.e. we put the item into the current knapsack
         *
         * If success == false, then we are directly going in the right branch of the binary tree, skipping the left branch
         *     i.e. we skipped the item
         */
        solveSingle(knapsack, bestKnapsack, items[:last])

        if success {
            /*
             * success == true indicated we went through the left branch without skipping it.
             *
             * Therefore, we have to pop out the last item that was added into the current knapsack.
             * After that, we are ready to enter the right branch to ensure the whole binary tree is explored.
             */
            knapsack.pop()
            solveSingle(knapsack, bestKnapsack, items[:last])
        }
    } else if knapsack.totalValue > bestKnapsack.totalValue {
        bestKnapsack.set(knapsack)
    }

    return
}

func parseInput(fileName string) (items []Item, knapsackWeightCapacity int) {
    file, e := os.Open(fileName)
    if e != nil {
        _, _ = fmt.Fprintf(os.Stderr, "Cannot open file\n")
        panic(e)
    }
    defer file.Close()
    scanner := bufio.NewScanner(file)

    var itemCount int
    if !scanner.Scan() {
        if scanner.Err() != nil {
            panic(scanner.Err())
        } else {
            panic("Unexpected EOF of the input file")
        }
    }
    itemCount, e = strconv.Atoi(strings.TrimSpace(scanner.Text()))
    if e != nil {
        _, _ = fmt.Fprintf(os.Stderr, "Cannot parse total number of items\n")
        panic(e)
    }

    items = make([]Item, itemCount)
    for i := 0; i < itemCount; i++ {
        if !scanner.Scan() {
            if scanner.Err() != nil {
                panic(scanner.Err())
            } else {
                panic("Unexpected EOF of the input file")
            }
        }
        tokens := strings.Fields(strings.TrimSpace(scanner.Text()))
        items[i].name = tokens[0]
        items[i].value, e = strconv.Atoi(tokens[1])
        if e != nil {
            _, _ = fmt.Fprintf(os.Stderr, "Cannot parse value of item %d\n", i)
            panic(e)
        }
        items[i].weight, e = strconv.Atoi(tokens[2])
        if e != nil {
            _, _ = fmt.Fprintf(os.Stderr, "Cannot parse weight of item %d\n", i)
            panic(e)
        }
    }

    if !scanner.Scan() {
        if scanner.Err() != nil {
            panic(scanner.Err())
        } else {
            panic("Unexpected EOF of the input file")
        }
    }
    knapsackWeightCapacity, e = strconv.Atoi(strings.TrimSpace(scanner.Text()))
    if e != nil {
        _, _ = fmt.Fprintf(os.Stderr, "Cannot parse size of the knapsack\n")
        panic(e)
    }

    return
}

func printResult(file *os.File, bestKnapsack *Knapsack) {
    _, _ = fmt.Fprintln(file, bestKnapsack.totalValue)
    if len(bestKnapsack.items) > 0 {
        _, _ = fmt.Fprint(file, bestKnapsack.items[0].name)
        for i := 1; i < bestKnapsack.itemCount; i++ {
            _, _ = fmt.Fprint(file, "  " + bestKnapsack.items[i].name)
        }
        _, _ = fmt.Fprint(file, "\n")
    }
}

// Driver code 
func main() {
    // Read input the file specified by command line arguments
    if len(os.Args) < 2 {
        _, _ = fmt.Fprintf(os.Stderr, "Usage: %s <inputFilePath> [maxForkDepth]\n", os.Args[0])
    } else {
        fmt.Println("Number of cores: ", runtime.NumCPU())

        // Compile regular expression
        r := regexp.MustCompile("(.+)\\..+")

        // Determine output file name
        var e error
        var file *os.File
        result := r.FindSubmatch([]byte(os.Args[1]))

        if len(result) > 1 {
            file, e = os.Create(string(result[1]) + ".sol")
        } else {
            file, e = os.Create(os.Args[1] + ".sol")
        }
        if e != nil {
            _, _ = fmt.Fprintf(os.Stderr, "Cannot create output file\n")
            file = nil
        } else if file != nil {
            defer file.Close()
        }

        // Parsing input file
        items, knapsackWeightCapacity := parseInput(os.Args[1])
        knapsack := CreateKnapsack(len(items), knapsackWeightCapacity)
        bestKnapsack := CreateKnapsack(len(items), knapsackWeightCapacity)

        // Detect whether maxForkDepth was overridden by the command line argument
        // maxForkDepth = int(math.Ceil(math.Log2(float64(cap(items)))))
        maxForkDepth = int(math.Ceil(math.Log2(float64(runtime.NumCPU()))))
        if len(os.Args) > 2 {
            d, e := strconv.Atoi(os.Args[2])
            if e != nil {
                _, _ = fmt.Fprintln(os.Stderr, "Unexpected command line argument", e)
            } else {
                if d >= cap(items) {
                    panic("Number of goroutines must be less than the total number of items")
                } else {
                    maxForkDepth = d
                }
            }
        }
        fmt.Println("Maximum fork depth: ", maxForkDepth)

        channel := make(chan *Knapsack)

        // Start algorithm
        start := time.Now()
        go solveConcurrent(knapsack, bestKnapsack, items, channel)
        bestKnapsack = <-channel
        elapsed := time.Since(start)

        close(channel)

        // Print results and runtime
        if file != nil {
            printResult(file, bestKnapsack)
        }
        printResult(os.Stdout, bestKnapsack)
        fmt.Printf("Total runtime: %s\n", elapsed)
    }
}
