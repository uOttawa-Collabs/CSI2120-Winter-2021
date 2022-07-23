package main

type Volunteer struct {
    AbstractStaffMember
}

func NewVolunteer(name string, address string, phone string) *Volunteer {
    volunteer := new(Volunteer)

    volunteer.name = name
    volunteer.address = address
    volunteer.phone = phone

    return volunteer
}

func (this *Volunteer) pay() float64 {
    return 0.0
}

func (this *Volunteer) toString() string {
    return this.AbstractStaffMember.toString()
}
