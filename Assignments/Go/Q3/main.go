package main

import (
    "fmt"
    "math"
    "math/rand"
    "time"
)

// returns true if number is prime
func isPrime(v int64) bool {
    sq := int64(math.Sqrt(float64(v))) + 1
    var i int64
    for i = 2; i < sq; i++ {
        if v % i == 0 {
            return false
        }
    }
    return true
}

// get a random prime number between 1 and maxP
func getPrime(maxPrime int64, times int64, channel *chan int64) {
    var i int64
    for i = 0; i < times; {
        n := rand.Int63n(maxPrime) + 1
        if isPrime(n) {
            *channel <- n
            i++
        }
    }
}

func main() {
    var primes []int64              // slice of prime numbers
    const maxPrime int64 = 10000000 // max value for primes
    const primeCount int64 = 10000
    const threadCount = 5

    channel := make(chan int64)

    start := time.Now()
    go func() {
        q := primeCount / threadCount
        r := primeCount % threadCount
        for i := 0; i < threadCount; i++ {
            if i < threadCount - 1 {
                go getPrime(maxPrime, q, &channel)
            } else {
                go getPrime(maxPrime, q + r, &channel)
            }
        }
    }()

    var i int64
    for i = 0; i < primeCount; i++ {
        primes = append(primes, <-channel)
    }
    end := time.Now()

    fmt.Println("End of program.", end.Sub(start))
}
