macro_rules! print {
    ($bytes : expr, $color : expr) => {
        let vga_buffer = 0xb8000 as *mut u8;
        for (i, &bytes) in $bytes.iter().enumerate() {
            unsafe {
                *vga_buffer.offset(i as isize * 2) = bytes;
                *vga_buffer.offset(i as isize * 2 + 1) = $color as u8;
            }
        }
    };
}
enum VgaColors {
    Black = 0x0,
    Blue = 0x1,
    Green = 0x2,
    Cyan = 0x3,
    Red = 0x04,
    Magenta = 0x5,
    Brown = 0x6,
    LightGray = 0x7,
    DarkGray = 0x8,
    LightBlue = 0x09,
    LightGreen = 0x10,
    LightCayn = 0x11,
    LightRed = 0x12,
    LightMagneta = 0x13,
    LightBrown = 0x14,
    White = 0x15,
}
#[macro_export]
macro_rules! clr {
    () => {
        let vga_buffer = 0xB8000 as *mut u8;
        for i in 0..32768 {
            unsafe {
                *vga_buffer.offset(i as isize * 2) = b' ';
            }
        }
    };
}

pub struct Writer;

impl Writer {
    pub fn log(data: &str) {
        print!(data.as_bytes(), VgaColors::LightGray);
    }
    pub fn warn(data: &str) {
        print!(data.as_bytes(), VgaColors::Green);
    }
    pub fn err(data: &str) {
        print!(data.as_bytes(), VgaColors::Red);
    }
}
