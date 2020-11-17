#![warn(unused_attributes)]
#![no_main]
#![no_std]
#![feature(global_asm)]
#![feature(llvm_asm)]

mod io;
mod vga;

use crate::io::port_byte_in;
use crate::vga::Writer;
use core::panic::PanicInfo;

global_asm!("call start");

#[no_mangle]
pub extern "C" fn start() {
    clr!();

    Writer::warn("ss");
    loop {}
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
