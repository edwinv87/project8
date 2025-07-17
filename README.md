# Project 8

This is a simple embedded project for the PIC16F18877 microcontroller using the XC8 compiler and a custom Makefile-based build system. Build environment for 8-bit V Embedded microcontroller boards.

## 📁 Project Structure

```
project8/
├── Makefile               # Custom build script using XC8
├── README.md              # Project documentation
├── .gitignore             # Ignore build artifacts and MPLAB files
├── src/                   # Application source code (.c files)
├── include/               # Shared header files
├── config/                # PIC configuration pragmas
├── build/                 # (auto-generated) Compiled object files
└── dist/                  # (auto-generated) Final .hex and .elf files
```

---

## ⚙️ Requirements

- [MPLAB XC8 Compiler](https://www.microchip.com/en-us/tools-resources/develop/microcontrollers/mplab-xc-compilers)
- [Make](https://www.gnu.org/software/make/)
- (Optional) [Graphviz](https://graphviz.org/) if using Doxygen for diagrams
- Tested with:
  - XC8 v2.x
  - PIC16F18877
  - Unix-like shell (Linux, macOS, or Git Bash on Windows)

---

## 🛠️ Building the Project

Open a terminal in the project root and run:

```bash
make
```

This will:

- Compile all `.c` files in `src/`
- Generate `.o` files in `build/`
- Link to create `.elf` and `.hex` in `dist/`

You should see output like:

```
🛠️  Compiling src/main.c...
🔗 Linking objects...
📦 Generating HEX file...
✅ Build complete: dist/my_pic_project.hex
```

---

## 🔄 Cleaning the Project

To clean all build artifacts:

```bash
make clean
```

You’ll see:

```
🧹 Cleaning build and dist directories...
✅ Clean complete.
```

---

## 🧪 Programming the Device

Use MPLAB X, `pickit4`, or `mplabx-ipe` to program the generated HEX file:

```bash
/path/to/mplab_ipe/ipecmd.sh -TPPK4 -P16F18877 -Fdist/my_pic_project.hex -M -OL
```

Replace paths and tool (TPPK4, TPK3, etc.) as needed.

---

## 📄 Documentation (Optional)

If you're using Doxygen for generating documentation:

```bash
doxygen Doxyfile
```

This creates HTML docs in `docs/html/`.

---

## ✅ Notes

- Header files in `include/` are automatically included via `-Iinclude`.
- MPLAB X project files (`nbproject/`) can still be used if you prefer the IDE but want to build from command line.
- Configuration bits are kept in `config/pic_config.h`.

---

## 🧾 License

MIT. See LICENSE file.
