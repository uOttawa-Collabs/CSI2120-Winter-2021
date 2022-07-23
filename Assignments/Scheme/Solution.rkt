#lang racket

; Question 1
(define (sum-of-divisors n current sum)
  (cond
    [(> 2 (quotient n current)) sum]
    [(= 0 (remainder n current)) (sum-of-divisors n (+ current 1) (+ sum current))]
    [else (sum-of-divisors n (+ current 1) sum)]))
  
(define (find-betrothed n)
  (let* ([t (sum-of-divisors n 1 0)] [r (sum-of-divisors (- t 1) 1 0)])
    (if (= n (- r 1)) (- t 1) #f)))

; Question 2
(define (increasing-order? alist)
  (cond
    [(null? alist) #t]
    [(null? (cdr alist)) #t]
    [(and (<= (car alist) (cadr alist)) (increasing-order? (cdr alist))) #t]
    [else #f]))

; Question 3
(define (vowel? char)
  (let ([c (char-downcase char)])
    (cond
      [(eqv? c #\a) #t]
      [(eqv? c #\e) #t]
      [(eqv? c #\i) #t]
      [(eqv? c #\o) #t]
      [(eqv? c #\u) #t]
      [else #f])))

(define (char-flip-case char)
  (cond
    [(char-upper-case? char) (char-downcase char)]
    [(char-lower-case? char) (char-upcase char)]
    [else #f]))

(define (get-vowels alist)
  (cond
    [(null? alist) '()]
    [(vowel? (car alist)) (cons (char-flip-case (car alist)) (get-vowels (cdr alist)))]
    [else (get-vowels (cdr alist))]))

(define (get-vowels-sc astring)
  (let ([l (string->list astring)])
    (list->string (get-vowels l))))
