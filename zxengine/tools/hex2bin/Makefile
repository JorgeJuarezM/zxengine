CPFLAGS	=	-std=c99 -O2 -Wall -pedantic
OUT_DIR	:=	.

# Compile
%.o : %.c
	gcc -c $(CPFLAGS) $< -o $@

$(OUT_DIR)/hex2bin: hex2bin.o common.o libcrc.o binary.o
	gcc -O2 -Wall -o $(OUT_DIR)/hex2bin hex2bin.o common.o libcrc.o binary.o

clean:
	rm -f *.o hex2bin
