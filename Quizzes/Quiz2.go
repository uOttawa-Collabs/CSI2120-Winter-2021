package main

import (
    "fmt"
)

type Tree struct {
    Left  *Tree
    Value int
    Right *Tree
}

func NewTree(v int) *Tree {

    return &Tree{nil, v, nil}
}

func (t *Tree) Insert(v int) *Tree {

    if v < t.Value {
        if t.Left == nil {
            t.Left = NewTree(v)
            return t.Left
        } else {
            return t.Left.Insert(v)
        }
    } else {
        if t.Right == nil {
            t.Right = NewTree(v)
            return t.Right
        } else {
            return t.Right.Insert(v)
        }

    }
}

func (this *Tree) GetMax() (max int) {
    
    for this.Right != nil {
        this = this.Right
    }
    max = this.Value
    
    return max;
}

func main() {

    t := NewTree(5)

    t.Insert(7)
    t.Insert(9)
    t.Insert(2)
    t.Insert(8)
    t.Insert(5)

    fmt.Println(t.GetMax())
}
