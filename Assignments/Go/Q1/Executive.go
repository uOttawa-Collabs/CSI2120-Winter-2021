package main

type Executive struct {
    Employee
    bonus float64
}

func NewExecutive(name string, address string, phone string, socialSecurityNumber string, payRate float64) *Executive {
    executive := new(Executive)

    executive.name = name
    executive.address = address
    executive.phone = phone
    executive.socialSecurityNumber = socialSecurityNumber
    executive.payRate = payRate

    executive.bonus = 0

    return executive
}

func (this *Executive) awardBonus(bonus float64) {
    this.bonus = bonus
}

func (this *Executive) pay() float64 {
    payment := this.Employee.pay() + this.bonus
    this.bonus = 0
    return payment
}

func (this *Executive) toString() string {
    return this.Employee.toString()
}
