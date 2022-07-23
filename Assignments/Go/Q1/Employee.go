package main

type Employee struct {
    AbstractStaffMember
    socialSecurityNumber string
    payRate              float64
}

func NewEmployee(name string, address string, phone string, socialSecurityNumber string, payRate float64) *Employee {
    employee := new(Employee)

    employee.name = name
    employee.address = address
    employee.phone = phone
    employee.socialSecurityNumber = socialSecurityNumber
    employee.payRate = payRate

    return employee
}

func (this *Employee) pay() float64 {
    return this.payRate
}

func (this *Employee) toString() string {
    return this.AbstractStaffMember.toString() + "\nSocial Security Number: " + this.socialSecurityNumber
}
