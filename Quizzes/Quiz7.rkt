#lang Racket

(define (removeNegative L)
  (cond
    ((null? L) '())
    ((< (car L) 0) (removeNegative (cdr L)))
    (else (cons (car L)
                  (removeNegative (cdr L))))
    ))
