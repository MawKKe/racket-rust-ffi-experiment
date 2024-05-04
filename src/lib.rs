use std::ffi::{c_double, c_float};

mod thing;

#[no_mangle]
pub extern "C" fn rust_hello() {
    println!("Hello from Rust!");
}

#[no_mangle]
pub extern "C" fn rust_add_ints(left: i64, right: i64) -> i64 {
    left + right
}

#[no_mangle]
pub extern "C" fn rust_add_floats(x: c_float, y: c_float) -> c_float {
    x + y
}

#[no_mangle]
pub extern "C" fn rust_add_doubles(x: c_double, y: c_double) -> c_double {
    x + y
}

#[repr(C)]
pub struct Complex {
    a: c_double,
    b: c_double,
}

#[no_mangle]
pub extern "C" fn rust_sum_int64(x: *const i64, n: u64) -> i64 {
    let sl = unsafe { std::slice::from_raw_parts(x, n as usize) };
    sl.iter().sum()
}

#[no_mangle]
pub extern "C" fn rust_sum_complex(x: *const Complex, n: u64) -> Complex {
    let sl = unsafe { std::slice::from_raw_parts(x, n as usize) };
    let mut a_s: c_double = 0.0;
    let mut b_s: c_double = 0.0;
    for e in sl.iter() {
        a_s += e.a;
        b_s += e.b;
    }
    Complex { a: a_s, b: b_s }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = add(2, 2);
        assert_eq!(result, 4);
    }
}
