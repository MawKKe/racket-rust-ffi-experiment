
pub struct Thing {
    counter: u8,
}

impl Thing {
    pub fn new(count: u8) -> Self {
        Self { counter: count }
    }

    pub fn count(&mut self) -> u8 {
        let old = self.counter;
        let (a, _b) = self.counter.overflowing_add(1);
        self.counter = a;
        return old;
    }
}

#[no_mangle]
pub extern "C" fn rust_thing_new(count: u8) -> *mut Thing {
    let boxed_a = Box::new(Thing::new(count));
    Box::into_raw(boxed_a)
}

#[no_mangle]
pub unsafe extern "C" fn rust_thing_incr(thing: *mut Thing) -> u8 {
    let ref_thing = &mut*thing;
    ref_thing.count()
}

#[no_mangle]
pub unsafe extern "C" fn rust_thing_free(thing: *mut Thing) {
    drop(Box::from_raw(thing));
}
