# racket-rust-ffi-experiment

Holy matrimony between Rust and Racket? Umm yes please

This repo contains small experiment on how you could call
into Rust-code from Racket via the (C) FFI supported by both languages.

## Requirements

You need
- Racket
- Rust+cargo
- make
- maybe C++ compiler

## Usage

Run the following to run the main experiment

    $ make

Example output:

    $ make
    cargo build
        Finished dev [unoptimized + debuginfo] target(s) in 0.02s
    ---
    racket main.rkt
    >>> Racket begin <<<
    Hello from Rust!
    rust_add_ints(39, 3) = 42
    rust_add_floats(41.32, 1.69)  = 43.0099983215332
    rust_add_doubles(41.32, 1.69) = 43.01
    sum((1.0 0.5 0.3333333333333333 0.25 0.2)) = 2.283333333333333
    rust_sum_complex(#(1+2i 3+1/2i 2/5+5i)) = 4.4+7.5i
    rust_sum_ints(#(0 1 2 3 4 5 6 7 8 9 10)) = 55
    >>> Racket end <<<

See `Makefile` for other details

## Author

2024-05-01 Markus H (MawKKe) https://github.com/MawKKe

