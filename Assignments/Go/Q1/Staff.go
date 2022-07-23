package main

import "fmt"

func main() {
    staffList := make([]StaffMember, 6)
    staffList[0] = NewExecutive("Sam", "123 Main Line",
        "555-0469", "123-45-6789", 2423.07)
    staffList[1] = NewEmployee("Carla", "456 Off Line",
        "555-0101", "987-65-4321", 1246.15)
    staffList[2] = NewEmployee("Woody", "789 Off Rocker",
        "555-0000", "010-20-3040", 1169.23)
    staffList[3] = NewHourly("Diane", "678 Fifth Ave.",
        "555-0690", "958-47-3625", 10.55)
    staffList[4] = NewVolunteer("Norm", "987 Suds Blvd.",
        "555-8374")
    staffList[5] = NewVolunteer("Cliff", "321 Duds Lane",
        "555-7282")

    var executive *Executive
    var hourly *Hourly
    var noError bool

    executive, noError = staffList[0].(*Executive)
    if noError {
        executive.awardBonus(500.00)
    }

    hourly, noError = staffList[3].(*Hourly)
    if noError {
        hourly.addHours(40)
    }

    amount := 0.0
    for count := 0; count < len(staffList); count++ {
        fmt.Println(staffList[count].toString())
        amount = staffList[count].pay()
        if amount == 0.0 {
            fmt.Println("Thanks!")
        } else {
            fmt.Printf("Paid: %g\n", amount)
        }
        fmt.Println("-----------------------------------")
    }
}
