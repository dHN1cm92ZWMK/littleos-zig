OBJECTS = loader.o kmain.o
ZIG = zig
# freestanding, NOT native! native generates std lib usages
# CPU i386 to prevent generating SSE
ZIGFLAGS = build-obj -mcpu=i386 -target x86-freestanding

LDFLAGS = -T link.ld -melf_i386
AS = nasm
ASFLAGS = -f elf

all: kernel.elf

kernel.elf: $(OBJECTS)
	ld $(LDFLAGS) $(OBJECTS) -o kernel.elf

os.iso: kernel.elf
	cp kernel.elf iso/boot/kernel.elf
	genisoimage -R -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -A os -input-charset utf8 -quiet -boot-info-table -o os.iso iso

run: os.iso
	qemu-system-i386 -d int,cpu_reset -D ./qemu.log -no-reboot --drive media=cdrom,file=os.iso,readonly=on

%.o: %.zig
	$(ZIG) $(ZIGFLAGS) $<

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -rf *.o kernel.elf os.iso
