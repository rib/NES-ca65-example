# Minimal NES example using ca65

This is a small example program for the NES, based on this example by
[Brad Smith](http://rainwarrior.ca):
https://github.com/bbbradsmith/NES-ca65-example

So far this has just been updated to use `make` for building and to encode
the CHR data at build time based on png source graphics.

It hopefully still serves the same purpose as Brad's original repo; demonstrating
a minimal starting point for programming the NES.

This depends on the CC65 toolchain, though it only uses the ca65 assembler,
not the C compiler:

https://cc65.github.io/

Open [example.s](example.s) and read the comments for information about this program.

To build, first clone and build the cc65 toolchain:

```bash
git clone https://github.com/cc65/cc65 tools/cc65
make -C tools/cc65
```

Then run `make`, which should produce "example.nes".

_(It's assumed by default that ca64 can be found at `tools/cc65/bin/ca65`, so if you
put it anywhere else you can use `make CC65_PATH=/path/to/cc65` to specify where
the toolchain is, or edit the Makefile)_

I recommend [Mesen](https://www.mesen.ca) for debugging.

The .dbg file produced by the linker will also provide debug symbols for
Mesen, NintendulatorDX and NESICIDE.
