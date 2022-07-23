#lang racket

; Question 1
(define myFavorite 42)
myFavorite ; verify: 42

; Question 2
(let ((x 1) (y 2)) (+ x y))
;(* x y) ; verification: unbound identifier

; Question 3
(let ((alpha (/ pi 4)) (beta (/ pi 3)))
  (+ (* (sin alpha) (cos beta)) (* (cos alpha) (sin beta))))
