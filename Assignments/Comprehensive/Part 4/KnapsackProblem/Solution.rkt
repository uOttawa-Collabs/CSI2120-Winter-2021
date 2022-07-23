#lang racket

; CSI2120 - 2021W
;
; Comprehensive Assignment Part 4
; Solution.rkt
;
; @author Xiaoxuan Wang 300133594

; Utilities
(define (generateOutputFilename inputFilename)
  (let ([matchResult (regexp-match #rx"(.+)\\..+" inputFilename)])
    (if (list? matchResult)
      (string-append (cadr matchResult) ".sol")
      (string-append inputFilename ".sol"))))

; returns '(itemCount itemList knapsackCapacity)
(define (parseInput inputFilePort)
  (letrec ([recursion
            (lambda (inputFilePort lineCount itemCount)
              (cond
                [(= lineCount 0)
                 (let ([newItemCount (read inputFilePort)])
                   (cons newItemCount (cons (recursion inputFilePort (+ lineCount 1) newItemCount) (cons (read inputFilePort) empty))))]
                [(<= lineCount itemCount)
                 (let ([itemName (read inputFilePort)] [itemValue (read inputFilePort)] [itemWeight (read inputFilePort)])
                   (cons (cons itemName (cons itemValue (cons itemWeight empty)))
                         (recursion inputFilePort (+ lineCount 1) itemCount)))]
                [else empty]))])
    (recursion inputFilePort 0 0)))

; Item operations
(define (item-getName item)
  (car item))
(define (item-getValue item)
  (cadr item))
(define (item-getWeight item)
  (caddr item))

; Knapsack operations (stack)
(define (knapsack-put knapsack item)
  (cons item knapsack))
(define (knapsack-getTotalValue knapsack)
  (letrec ([recursion
            (lambda (knapsack valueAccumulator)
              (if (null? knapsack)
                valueAccumulator
                (recursion (cdr knapsack) (+ valueAccumulator (item-getValue (car knapsack))))))])
    (recursion knapsack 0)))
(define (knapsack-getTotalWeight knapsack)
  (letrec ([recursion
            (lambda (knapsack weightAccumulator)
              (if (null? knapsack)
                weightAccumulator
                (recursion (cdr knapsack) (+ weightAccumulator (item-getWeight (car knapsack))))))])
    (recursion knapsack 0)))
(define (knapsack-getItemNameList knapsack)
  (if (null? knapsack)
   '()
   (cons (item-getName (car knapsack)) (knapsack-getItemNameList (cdr knapsack)))))

; Algorithm
; returns '(totalValue itemNameList)
(define (knapsack knapsackCapacity itemCount itemList)
  (let ([resultKnapsack
         (letrec ([recursion
                   (lambda (knapsackCapacity itemCount itemList currentKnapsack)
                     (cond
                       [(null? itemList) currentKnapsack]
                       [(<= (item-getWeight (car itemList)) (- knapsackCapacity (knapsack-getTotalWeight currentKnapsack)))
                        (let
                            ([knapsackLeft (recursion knapsackCapacity itemCount (cdr itemList) (knapsack-put currentKnapsack (car itemList)))]
                             [knapsackRight (recursion knapsackCapacity itemCount (cdr itemList) currentKnapsack)])
                          (if (> (knapsack-getTotalWeight knapsackLeft) (knapsack-getTotalWeight knapsackRight))
                              knapsackLeft
                              knapsackRight))]
                       [else (recursion knapsackCapacity itemCount (cdr itemList) currentKnapsack)]))])
           (recursion knapsackCapacity itemCount itemList '()))])
    (cons (knapsack-getTotalValue resultKnapsack) (cons (knapsack-getItemNameList resultKnapsack) empty))))

; Entry point
(define (solveKnapsack filename)
  (let (
        [inputFilePort (open-input-file filename)]
        [outputFilePort (open-output-file (generateOutputFilename filename) #:exists 'replace)])
    (begin
      (let* (
             [parsedList (parseInput inputFilePort)]
             [itemCount (car parsedList)]
             [itemList (cadr parsedList)]
             [knapsackCapacity (caddr parsedList)]
             [resultList (knapsack knapsackCapacity itemCount itemList)]
             [totalValue (car resultList)]
             [itemNameList (cadr resultList)])
        (begin
          (write totalValue outputFilePort)
          (newline outputFilePort)
          (if (not (null? itemNameList))
              (begin
                (write (car itemNameList) outputFilePort)
                (letrec ([recursiveWrite
                          (lambda (itemNameList outputFilePort)
                            (cond
                              [(null? itemNameList) (newline outputFilePort)]
                              [else (begin
                                      (display "  " outputFilePort)
                                      (write (car itemNameList) outputFilePort)
                                      (recursiveWrite (cdr itemNameList) outputFilePort))]))])
                  (recursiveWrite (cdr itemNameList) outputFilePort)))
              #f)))
      (close-input-port inputFilePort)
      (close-output-port outputFilePort))))
