#lang racket

(define (abc-count char k)
  (if (char-alphabetic? char)
      (let ((base (if (char-upper-case? char)
                      (char->integer #\A)
                      (char->integer #\a))))
        (integer->char
         (+ base
            (modulo
             (+ k
                (- (char->integer char) base))
             26))))
      char))

(define (cipher string k)
  (let ([charlist (string->list string)])
    (list->string (let recursion ([charlist charlist] [k k])
      (if (null? charlist)
          '()
          (cons (abc-count (car charlist) k) (recursion (cdr charlist) k)))))))
    