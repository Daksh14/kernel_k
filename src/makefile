CC = i686-elf-gcc
CFLAGS = -Os -pipe -Wall -Wextra
CARGO = cargo xbuild
RUST_TARGET = specification.json

INTERNAL_CFLAGS = \
	-ffreestanding \
	-masm=intel \
	-fno-pic \
	-mno-sse \
	-mno-sse2 \
	-mno-mmx \
	-mno-80387 \
	-ffreestanding \
	-fno-stack-protector \
	-I. \
	-Wno-address-of-packed-member

LDFLAGS = -O2

INTERNAL_LDFLAGS = \
	-nostdlib \
	-no-pie \
	-lgcc \
	-static-libgcc \
	-Tlinker.ld

BIN_FOLDER = binaries
RUST_O  = rust-0310d0f3743aaf87.o
RUST_D  = rust-0310d0f3743aaf87.d
BOOT_FINAL = boot.bin
KERNEL_FINAL = kernel.bin
OS_FINAL = kernel_k.bin

C_FILES := $(shell find ./ -type f -name '*.c' | sort)
OBJ_C := $(C_FILES:.c=.o)

all: kernel.bin qemu

kernel.bin: $(OBJ_C) rs
	i686-elf-gcc  $(BIN_FOLDER)/$(RUST_O) $(OBJ_C) $(LDFLAGS) $(INTERNAL_LDFLAGS) -o $(BIN_FOLDER)/$(KERNEL_FINAL)
	nasm bootloader/boot.asm -o $(BIN_FOLDER)/$(BOOT_FINAL)

%.o: %.c
	$(CC) $(CFLAGS) $(INTERNAL_CFLAGS) -c $< -o $@

rs:
	$(CARGO) --target=$(RUST_TARGET) --release

os.bin:
	cat $(BIN_FOLDER)/$(BOOT_FINAL) $(BIN_FOLDER)/$(KERNEL_FINAL) > $(BIN_FOLDER)/$(OS_FINAL)

os.clean:
	rm $(BIN_FOLDER)/$(RUST_D) $(BIN_FOLDER)/$(RUST_O) $(BIN_FOLDER)/$(BOOT_FINAL) $(BIN_FOLDER)/$(KERNEL_FINAL) $(OBJ_C)

qemu: os.bin os.clean
	qemu-system-x86_64 -fda $(BIN_FOLDER)/$(OS_FINAL)

clean: os.clean
	rm $(BIN_FOLDER)/*.bin
