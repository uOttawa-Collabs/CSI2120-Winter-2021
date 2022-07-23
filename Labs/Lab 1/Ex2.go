package main

import "fmt"

func main() {
    lineWidth := 5
    symb := "x"
    lineSymb := symb
    formatStr := fmt.Sprintf("%%%ds\n", lineWidth)
    fmt.Printf(formatStr, lineSymb)
    
    for i := 1; i < lineWidth; i++ {
        lineSymb += symb;
        fmt.Printf(formatStr, lineSymb)
    }
    
    for i := 4; i >= 1; i-- {
        lineSymb = lineSymb[:i]
        fmt.Printf(formatStr, lineSymb)
    }
}
