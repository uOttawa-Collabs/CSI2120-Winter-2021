#lang racket

(define (clean-message string)
  (let ([charList (string->list string)])
        (letrec
            ([recursion
              (lambda (charList)
                (cond
                  [(null? charList) '()]
                  [(char-alphabetic? (car charList))
                   (cons (char-upcase (car charList)) (recursion (cdr charList)))]
                  [else
                    (recursion (cdr charList))]))])
          (list->string (recursion charList)))))

(define (shift-char char shift)
  (integer->char (+ (modulo (+ (- (char->integer char) (char->integer #\A)) shift) 26) (char->integer #\A))))

(define (caesar-cipher string shift)
  (let ([charList (string->list (clean-message string))])
    (letrec
        ([recursion
          (lambda (charList)
            (cond
              [(null? charList) '()]
              [else (cons (shift-char (car charList) shift) (recursion (cdr charList)))]))])
      (list->string (recursion charList)))))

              