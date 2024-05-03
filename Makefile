# Makefile to compile C program for V Embedded 8-bit microcontroller boards 

include support/sources.mk 

# Firmware Variables 
# Target 
TARGET := Firmware

PROCESSOR := 16F18877 

# Compiler
CC = "C:\Program Files\Microchip\xc8\v2.41\bin\xc8.exe"

# Compiler Flags 
CFLAGS := --chip=$(PROCESSOR)


# Objects 
OBJS := $(SRCS:.c=.p1)

# Includes
INCLUDES := -I ./include
OUTDIR = Debug/Exe





%.p1: %.c 
	$(CC) $(CFLAGS) --pass1 $<

$(TARGET): $(OBJS) $(OUTDIR)
	$(CC) $(CFLAGS) $(OBJS) -O$(OUTDIR)/$(TARGET)


$(OUTDIR):
	mkdir -p $@


.PHONY: build 
build: $(TARGET) 

.PHONY: clean
clean:
	rm $(TARGET) $(OBJS)

.PHONY: chip-info
chip-info:
	@echo List of Chips Supported by the xc8 Compiler
	$(CC) --chipinfo