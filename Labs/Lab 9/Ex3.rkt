#lang racket

; Question 1
((lambda (alpha beta) (+ (* (sin alpha) (cos beta)) (* (cos alpha) (sin beta)))) (/ pi 4) (/ pi 3))

; Question 2
(define foo (lambda (x y) (+ x y)))
(foo 1 2)

; Question 3
(define sinplus (lambda (alpha beta) (+ (* (sin alpha) (cos beta)) (* (cos alpha) (sin beta)))))
