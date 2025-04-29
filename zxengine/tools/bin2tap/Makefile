################################################################################
# Compiler Variables
################################################################################
CC 	=	gcc
CFLAGS 	=	-Wall -O2 -Wno-constant-conversion
OUT_DIR	:=	.

$(OUT_DIR)/bin2tap: bin2tap.c
	$(CC) $(CFLAGS) bin2tap.c -o $(OUT_DIR)/bin2tap -lm

clean:
	rm -f $(OUT_DIR)/bin2tap

.PHONY: clean
