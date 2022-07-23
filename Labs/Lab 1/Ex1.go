package main

import (
    "fmt"
    "math"
)

func main() {
    var num float64;
    fmt.Scanf("%f", &num)
    fmt.Println(math.Floor(num))
    fmt.Println(math.Ceil(num))
}
