package main

import (
    "fmt"
    "math"
)

type NegError struct {
    message string
    num float64 // negative number
}

func (this NegError) Error() string {
    s := fmt.Sprintf("Negative number %f", this.num);
    if this.message != "" {
        return fmt.Sprintf("%s: %s", this.message, s)
    } else {
        return s
    }
}

type Div0Error struct {
    message string
}

func (this Div0Error) Error() string {
    s := "Division by 0"
    if this.message != "" {
        return fmt.Sprintf("%s: %s", this.message, s)
    } else {
        return s
    }
}


func rootDivN(num float64, n int) (res float64, err error) {
    if num < 0.0 {
        res = 0
        err = NegError { "Main NegError", num }
        return
    }
    if n == 0 {
        res = 0
        err = Div0Error { "Main Div0Error" }
        return
    }
    res = math.Sqrt(num) / float64(n)
    return
}

func main() {
    divs := []int { 2, 10, 3, 0 }
    nums := []float64 { 511.8, 0.65, -3.0, 2.123 }
    for i, num := range nums {
        fmt.Printf("%d) sqrt(%f)/%d = ", i, num, divs[i])
        res, err := rootDivN(num, divs[i])
        if err == nil {
            fmt.Printf("%f\n", res)
        } else {
            fmt.Println(err)
        }
    }
}
