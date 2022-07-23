package main

import (
    "fmt"
    "strconv"
    "time"
)

var i int

func makeCakeAndSend(cs chan string) {
    i = i + 1
    cakeName := "Strawberry Cake " + strconv.Itoa(i)
    fmt.Println("Making a cake and sending ...", cakeName)
    cs <- cakeName // send a strawberry cake
}

func receiveCakeAndPack(cs chan string) {
    s := <-cs // get whatever cake is on the channel
    fmt.Println("Packing received cake: ", s)
}

/*
    Making a cake and sending ... Strawberry Cake 1
    Packing received cake:  Strawberry Cake 1
    Making a cake and sending ... Strawberry Cake 2
    Packing received cake:  Strawberry Cake 2
    Making a cake and sending ... Strawberry Cake 3
    Packing received cake:  Strawberry Cake 3
*/
func main() {
    cs := make(chan string)
    for i := 0; i < 3; i++ {
        go makeCakeAndSend(cs)
        go receiveCakeAndPack(cs)
        // sleep for a while so that the program doesn't exit
        // immediately and output is clear for illustration
        time.Sleep(1 * 1e9)
    }
}
