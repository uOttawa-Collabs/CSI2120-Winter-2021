#lang Racket

(define (sosd n)
  (cond
    [(eq? n 0) 0]
    [else
     (let ((square (lambda (x) (* x x))))
     (+ (square (remainder n 10)) (sosd (quotient n 10))))]))
