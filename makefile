CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
BIN = arm-none-eabi-objcopy
STL = st-flash
CFLAGS = -mthumb -mcpu=cortex-m3 

all: app.bin

crt.o: crt.s
	$(AS) -o crt.o crt.s //tập hợp đầu ra của trình biên dịch để linker

main.o: main.c
	$(CC) $(CFLAGS) -c -o main.o main.c  //biên dịch

app.elf: linker.ld crt.o main.o
	$(LD) -T linker.ld -o app.elf crt.o main.o //liên kết các file

app.bin: app.elf
	$(BIN) -O binary app.elf app.bin //tạo tệp nhị phân 

clean:
	rm -f *.o *.elf *.bin

flash: app.bin
	$(STL) write app.bin 0x8000000

erase:
	$(STL) erase
