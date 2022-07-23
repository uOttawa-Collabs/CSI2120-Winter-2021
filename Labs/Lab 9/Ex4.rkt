#lang racket

(define (foo x y) (list (+ x y) (- x y)))
(define (qequ a b c) (foo (/ (- b) (* 2 a)) (/ (sqrt (- (* b b) (* 4 a c))) (* 2 a))))
