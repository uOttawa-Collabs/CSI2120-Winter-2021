#lang racket

(define (loop LA LB)
  (cond
    [(and (null? LA) (null? LB)) '()]
    [(null? LA) (cons (abs (- 0 (car LB))) (loop '() (cdr LB)))]
    [(null? LB) (cons (abs (car LA)) (loop (cdr LA) '()))]
    [else (cons (abs (- (car LA) (car LB))) (loop (cdr LA) (cdr LB)))]))

(define (absDiffA LA LB)
  (loop LA LB))
