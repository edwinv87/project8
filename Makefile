##############################################################################
# File: Makefile															 #
# Author: Edwin Vans														 #
# Date: 05/06/2024															 #
#																			 #
# Description: 																 #
# ------------														 		 #
# Makefile to Build C Project for V Embedded 8-bit Microcontroller Boards  	 #
# 																			 #
##############################################################################

include support/sources.mk 
include support/includes.mk
include support/project_config.mk


# Firmware Variables 
# Target 
TARGET := Firmware
PROCESSOR := 16F18877 
START_ADDR := 800	# The start address (hex) in memory of the firmware (0 - 7FF is used for bootloader)


# Microchip xc8 Compiler Flags 
# See xc8 compiler documentation for more information
CFLAGS := --chip=$(PROCESSOR)
CFLAGS += --codeoffset=$(START_ADDR)
# CFLAGS2 := --checksum=800-7FFD@7FFE,offset=0xFFFF,algorithm=5,width=2,polynomial=0x1021 # This is not needed

# Define Object and Output Directories
BUILD_DIR := ./Debug
OUTDIR := $(BUILD_DIR)/Exe
OBJDIR := $(BUILD_DIR)/Obj

# Objects 
OBJS := $(addprefix $(OBJDIR)/, $(SRCS:.c=.p1))
OBJS_DIR := $(sort $(dir $(OBJS)))

# Dependencies
DEPS := $(addprefix $(OBJDIR)/, $(SRCS:.c=.d))

# Includes 
INCS := $(pathsubst %, -I"%", $(INCS_DIR))


# Build Recipies 
.PHONY: build 
build: $(OUTDIR)/$(TARGET).hex 
	$(info Build complete.)

.PHONY: clean
clean:
	$(info Removing build directories)
	@rm -rf $(BUILD_DIR)

.PHONY: chip-info
chip-info:
	@echo List of Chips Supported by the xc8 Compiler
	$(CC) --chipinfo

$(OBJDIR)/%.p1: %.c | $(OBJS_DIR)
	$(info Compiling file: $<)
	@$(CC) $(CFLAGS) -Q --objdir=$(OBJS_DIR) --pass1 $<

$(OUTDIR)/$(TARGET).hex: $(OBJS) | $(OUTDIR)
	@$(CC) $(CFLAGS) $(OBJS) -O$(OUTDIR)/$(TARGET)

$(OUTDIR):
	$(info Creating output directory)
	@mkdir -p $@

$(OBJS_DIR):
	$(info Creating object directory)
	@mkdir -p $@


-include $(DEPS)