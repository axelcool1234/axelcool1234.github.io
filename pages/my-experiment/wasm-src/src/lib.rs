// a tiny, no-deps wasm function that returns a number
#[no_mangle]
pub extern "C" fn run() -> i32 {
    42
}

