package main

type StaffMember interface {
    pay() float64
    toString() string
}

type AbstractStaffMember struct {
    name    string
    address string
    phone   string
}

func (this *AbstractStaffMember) toString() string {
    return "Name: " + this.name + "\n" + "Address: " + this.address + "\n" + "Phone: " + this.phone
}
