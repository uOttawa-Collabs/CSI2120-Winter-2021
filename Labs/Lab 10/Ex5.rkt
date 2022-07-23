#lang Racket

(define (drop L n)
  (letrec
      ((recursion (lambda (L n d)
                    (cond
                      [(null? L) '()]
                      [(eq? d 1) (recursion (cdr L) n n)]
                      [else (cons (car L) (recursion (cdr L) n (- d 1)))]))))
    (recursion L n n)))
