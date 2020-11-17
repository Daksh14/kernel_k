pub fn port_byte_in(port: u16) -> u8 {
    let res: u8;
    unsafe {
        llvm_asm!("in %dx, %al" : "={al}"(res) : "{dx}"(port));
    }
    res
}

pub fn port_byte_out(port: u16, data: u8) {
    unsafe {
        llvm_asm!("out %al, %dx" ::  "{al}"(data) , "{dx}"(port));
    }
}

pub fn port_word_in(port: u16, data: u8) -> u16 {
    let res: u16;
    unsafe {
        llvm_asm!("in %dx, %ax": "={ax}"(res) : "{dx}"(port));
    }
    res
}

pub fn port_word_out(port: u16, data: u16) {
    unsafe {
        llvm_asm!("out %ax, %dx" : : "{ax}"(data), "{dx}"(port));
    }
}
