#lang Racket

(define L '(1 2 3 4 5))
(define LL '(1 (2 3 4) (5)))

(cadr L)
(caddr L)
(cadddr L)
(car (cddddr L))

(caadr LL)
(caaddr LL)
