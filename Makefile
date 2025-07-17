# ---- Configuration ----

DEVICE = 16F18877
PROJECT = my_pic_project
TARGET = $(PROJECT).hex

CC = xc8-cc
CFLAGS = --chip=$(DEVICE) -Iinclude -Iconfig -Os

SRC_DIR = src
OBJ_DIR = build
DIST_DIR = dist

SOURCES := $(wildcard $(SRC_DIR)/*.c)
OBJECTS := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SOURCES))

# ---- Rules ----

all: $(DIST_DIR)/$(TARGET)
	@echo "✅ Build complete: $(DIST_DIR)/$(TARGET)"

# Compile .c to .o
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	@echo "🛠️  Compiling $<..."
	@$(CC) $(CFLAGS) -c $< -o $@

# Link .o to .hex
$(DIST_DIR)/$(TARGET): $(OBJECTS)
	@mkdir -p $(DIST_DIR)
	@echo "🔗 Linking objects..."
	@$(CC) $(CFLAGS) $^ -o $(DIST_DIR)/$(PROJECT).elf
	@echo "📦 Generating HEX file..."
	@$(CC) $(CFLAGS) --output-format=hex $(DIST_DIR)/$(PROJECT).elf -o $@

# Clean build artifacts
clean:
	@echo "🧹 Cleaning build and dist directories..."
	@rm -rf $(OBJ_DIR) $(DIST_DIR)
	@echo "✅ Clean complete."

.PHONY: all clean