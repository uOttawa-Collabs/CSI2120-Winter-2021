#lang racket

(define (min-list x)
  (if (null? x)
      x
      (letrec ([recursion
        (lambda (e l)
          (cond
            [(null? l) e]
            [(> e (car l)) (recursion (car l)(cdr l))]
            [else (recursion e (cdr l))]))])
        (recursion (car x)(cdr x)))))
