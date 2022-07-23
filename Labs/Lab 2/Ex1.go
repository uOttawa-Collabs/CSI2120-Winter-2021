package main
// import "fmt"

type dog struct {
    name string
    race string
    female bool
}

func (this *dog) rename(name string) {
    this.name = name;
}

func main() {
    fido := dog { "Fido", "Poodle", false }
    fido.rename("Cocotte")
    
    // fmt.Print(fido)
}
