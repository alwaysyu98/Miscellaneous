#lang planet neil/sicp

; smallest-divisor
(define (next n)
  (if (= n 2) 3
      (+ n 2)))
(define (smallest-divisor n)
  (find-divisor n 2))
(define (square n) (* n n))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
(define (divides? a b)
  (= (remainder b a) 0))

; prime?
(define (prime? n)
  (= n (smallest-divisor n)))

; timed-prime-test
(define (timed-prime-test n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))))
(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time))


; https://docs.racket-lang.org/reference/if.html
; For cond and if details, please refer to above official website.
; The then-bodys are evaluated in order, and the
; results from all but the last then-body are ignored.

; use if and use cond to implement
(define (search-for-primes start end)
  (define (search-for-primes-iter start end)
    ;(cond ((<= start end) (timed-prime-test start) (search-for-primes-iter (+ start 2) end))))
    (if (<= start end) ((lambda () (timed-prime-test start) (search-for-primes-iter (+ start 2) end)))))
  (search-for-primes-iter
   (if (odd? start) start (+ start 1))
   end))
      

; test case
(search-for-primes 1000      1050)
(search-for-primes 10000     10050)
(search-for-primes 100000    100050)
(search-for-primes 1000000   1000050)
(search-for-primes 10000000  10000050)
(search-for-primes 100000000 100000050)

; 1009 *** 2
; 1013 *** 2
; 1019 *** 2
; 1021 *** 3
; 10007 *** 6
; 10009 *** 7
; 10037 *** 6
; 10039 *** 7
; 100003 *** 19
; 100019 *** 20
; 100043 *** 20
; 100049 *** 20


; extra if judge to be done
; so rough ratio is 1.5, but 2.0
; 1009 *** 2
; 1013 *** 2
; 1019 *** 1
; 1021 *** 1
; 10007 *** 4
; 10009 *** 5
; 10037 *** 4
; 10039 *** 5
; 100003 *** 13
; 100019 *** 13
; 100043 *** 12
; 100049 *** 12
