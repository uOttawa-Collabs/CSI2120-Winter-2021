#lang Racket

(define (range i k)
  (cond
    [(eq? i k) (cons k empty)]
    [else (cons i (range (+ i 1) k))]))
