#lang racket

(define (loop LA LB)
  (if (or (null? LA) (null? LB))
      '()
      (cons (abs (- (car LA) (car LB))) (loop (cdr LA) (cdr LB)))))

(define (length-list L)
  (if (null? L)
      0
      (+ 1 (length-list(cdr L)))))

(define (absDiff LA LB)
  (if (not (eq? (length-list LA) (length-list LB)))
      "List have different length"
      (loop LA LB)))
