#lang racket

(define (mergelists L M)
  (cond ((null? L) M)
        ((null? M) L)
        ((< (car L) (car M)) (cons (car L) (mergelists (cdr L) M)))
        (else (cons (car M) (mergelists L (cdr M))))))
