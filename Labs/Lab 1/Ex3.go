package main
import (
    "os"
    "fmt"
    "bufio"
)

type Person struct {
    lastName  string
    firstName string
    iD        int
}

func main() {
    nextId := 101
    for {
        var (
            p   Person
            err error
        )
        nextId, err = inPerson(&p, nextId)
        if err != nil {
            fmt.Println("Invalid entry ... exiting")
            fmt.Println(err.Error())
            break
        }
        printPerson(p)
    }
}

func inPerson(person *Person, nextId int) (newNextId int, e error) {
    scanner := bufio.NewScanner(os.Stdin)
    
    fmt.Print("Please input the last name: ")
    if scanner.Scan() {
        person.lastName = scanner.Text()
    } else {
        e = scanner.Err()
    }
    
    fmt.Print("Please input the first name: ")
    if scanner.Scan() {
        person.firstName = scanner.Text()
    } else {
        e = scanner.Err()
    }
    
    person.iD = nextId
    newNextId = nextId + 1
    
    return
}

func printPerson(person Person) {
    fmt.Printf("%d: %s %s\n", person.iD, person.firstName, person.lastName)
}
