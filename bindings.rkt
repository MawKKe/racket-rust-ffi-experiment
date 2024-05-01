#lang racket/base

(require ffi/unsafe
     ffi/unsafe/define)

(require racket/vector)

; run cargo build to create the library
(define (get-rust-build-dirs)
  '("target/release" "target/debug"))

(define-ffi-definer foo-define
    (ffi-lib "libfoo" #:get-lib-dirs get-rust-build-dirs))

(foo-define hello (_fun -> _void) #:c-id rust_hello)
(foo-define add-ints (_fun _int64 _int64 -> _int64) #:c-id rust_add_ints)
(foo-define add-floats (_fun _float _float -> _float) #:c-id rust_add_floats)
(foo-define add-doubles (_fun _double _double -> _double) #:c-id rust_add_doubles)
(foo-define sum-ints
    (_fun [v : (_vector i _int64)] [_uint64 = (vector-length v)] -> _int64)
    #:c-id rust_sum_int64)

; this must match the struct definition on Rust side (with #[repr(C)])
(define-cstruct _COMPLEX ([a _double] [b _double]))

(foo-define _sum-complex
    (_fun [v : (_vector i _COMPLEX)] [_uint64 = (vector-length v)]
       -> (r : _COMPLEX)
       -> (COMPLEX->complex r))
    #:c-id rust_sum_complex)

(define (sum-complex v)
  (_sum-complex (vector-map complex->COMPLEX v)))

(define (complex->COMPLEX c)
  (make-COMPLEX
    (exact->inexact (real-part c))
    (exact->inexact (imag-part c))))

(define (COMPLEX->complex c)
  (make-rectangular (COMPLEX-a c) (COMPLEX-b c)))

(provide hello add-ints add-floats add-doubles sum-complex sum-ints)
