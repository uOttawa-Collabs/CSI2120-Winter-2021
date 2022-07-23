package main

import "strconv"

type Hourly struct {
    Employee
    hoursWorked int
}

func NewHourly(name string, address string, phone string, socialSecurityNumber string, payRate float64) *Hourly {
    hourly := new(Hourly)

    hourly.name = name
    hourly.address = address
    hourly.phone = phone
    hourly.socialSecurityNumber = socialSecurityNumber
    hourly.payRate = payRate

    hourly.hoursWorked = 0

    return hourly
}

func (this *Hourly) addHours(moreHours int) {
    this.hoursWorked += moreHours
}

func (this *Hourly) pay() float64 {
    payment := this.Employee.pay() * float64(this.hoursWorked)
    this.hoursWorked = 0
    return payment
}

func (this *Hourly) toString() string {
    return this.Employee.toString() + "\nCurrent hours: " + strconv.Itoa(this.hoursWorked)
}
