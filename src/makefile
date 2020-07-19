CC = i686-elf-gcc
CFLAGS = -Os -pipe -Wall -Wextra

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

C_FILES := $(shell find ./ -type f -name '*.c' | sort)
OBJ := $(C_FILES:.c=.o)

all: kernel.bin qemu

kernel.bin: $(OBJ)
	i686-elf-gcc $(OBJ) $(LDFLAGS) $(INTERNAL_LDFLAGS) -o binaries/kernel.bin
	nasm bootloader/boot.asm -o binaries/kernel_entry.bin

%.o: %.c
	$(CC) $(CFLAGS) $(INTERNAL_CFLAGS) -c $< -o $@

os.bin:
	cat binaries/kernel_entry.bin binaries/kernel.bin > binaries/os.bin

os.clean:
	rm binaries/kernel.bin
	rm binaries/kernel_entry.bin

qemu: os.bin os.clean
	qemu-system-x86_64 binaries/os.bin

clean:
	rm binaries/*.bin
