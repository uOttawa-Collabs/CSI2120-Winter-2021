package main

import (
    "fmt"
    "sync"
    "time"
)

func process(v int) int {
    time.Sleep(1500 * time.Millisecond) // simulate compute time
    return 2 * v
}

func main() {
    var wg sync.WaitGroup
    for _, value := range []int{9, 35, 27, 56, 88, 80} {
        wg.Add(1)
        value := value
        go func() {
            defer wg.Done()
            fmt.Println(process(value))
        }()
    }
    wg.Wait()
}
