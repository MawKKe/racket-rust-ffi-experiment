#lang racket

(require ffi/unsafe)

(require (prefix-in rust: "bindings.rkt"))

(displayln ">>> Racket begin <<<")

(rust:hello)

(let ([a 39] [b 3])
    (printf "rust_add_ints(~a, ~a) = ~a~%" a b (rust:add-ints a b)))

(let ([a 41.32] [b 1.69])
    ; note difference in precision
    (printf "rust_add_floats(~a, ~a)  = ~a~%" a b (rust:add-floats a b))
    (printf "rust_add_doubles(~a, ~a) = ~a~%" a b (rust:add-doubles a b)))

(define (recip x) (/ 1 x))

(let* ([elems (map (compose exact->inexact recip) (range 1 6))])
    (printf "sum(~a) = ~a~%" elems (foldl rust:add-doubles 0.0 elems)))

(define c-data '#(1+2i 3+2/4i 4/10+5i))
(define res (rust:sum-complex c-data))
(printf "rust_sum_complex(~a) = ~a~%" c-data res)

(define num-list (list->vector (range 11)))
(printf "rust_sum_ints(~a) = ~a~%" num-list (rust:sum-ints num-list))

(displayln "---")

(define t (rust:make-thing))

(printf "rust_make_thing() = ~a, tag: ~a~%" t (cpointer-tag t))

(let loop ([ctr 0])
  (when (ctr . < . 3)
    (printf "rust_thing_incr(~a) = ~a~%" t (rust:thing-incr t))
    (loop (add1 ctr))))

(printf "rust_thing_free(~a)~%" t)
(rust:thing-free t)

(displayln "---")

(displayln ">>> Racket end <<<")
