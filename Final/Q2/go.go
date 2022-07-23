package main

import (
    "fmt"
    "math"
)

func main() {
    // the list of items
    var items = [6]int{200, 300, 1200, 100, 550, 300}

    var weight1stSack, weight2ndSack, totalWeight int

    // compute the weight of all items
    totalWeight = func(itemWeightList []int) int {
        result := 0
        for _, weight := range items {
            result += weight
        }
        return result
    }(items[:])

    // the channel to communicate
    result := make(chan int)

    // compute the total number of leaves in the solution tree 2^len(items)
    numberOfSolutions := (int)(math.Exp2((float64)(len(items))))

    // call to brute force recursive solution
    go solve2knapsack(items[:], 0, result)

    // read all messages from go functions
    // and find the best solution
    // hint: we know that the number of solutions
    //       to be received is given by numberOfSolutions

    weight1stSack = <- result
    weight2ndSack = totalWeight - weight1stSack
    minimumDifference := int(math.Abs(float64(weight2ndSack - weight1stSack)))

    for i := 1; i < numberOfSolutions; i++ {
        firstKnapsack := <- result
        secondKnapsack := totalWeight - firstKnapsack
        difference := int(math.Abs(float64(secondKnapsack - firstKnapsack)))

        if difference < minimumDifference {
            weight1stSack = firstKnapsack
            weight2ndSack = secondKnapsack
            minimumDifference = difference
        }
    }

    fmt.Println(weight1stSack, "g and", weight2ndSack, "g")
}

func solve2knapsack(items []int, currentWeight1stSack int, result chan int) {
    if len(items) == 0 {
        result <- currentWeight1stSack
    } else {
        // recursive calls
        // put the current item in second sack
        go solve2knapsack(items[1:], currentWeight1stSack, result)
        // put the current item in first sack
        go solve2knapsack(items[1:], currentWeight1stSack + items[0], result)
    }
}
