package main

import "fmt"
import "sync"

func main() {
    x := []int{3, 1, 4, 1, 5, 9, 2, 6}
    var y [8]int
    
    var waitGroup sync.WaitGroup
    
    // boucle parallele
    for i, v := range x {
        waitGroup.Add(1)
        go func(i int, v int) {
            defer waitGroup.Done()
            y[i] = calcul(v)
        }(i, v) // appel a la goroutine
    }

    // ajouter synchronisation
    waitGroup.Wait()
    fmt.Println(y)
}

func calcul(v int) int {
    return 2 * v * v * v + v * v
}
