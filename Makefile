example_obj := example.o

DEPDIR = .deps

PYTHON := python3

CC65_PATH := tools/cc65
CA65 := $(CC65_PATH)/bin/ca65
CL65 := $(CC65_PATH)/bin/cl65
LD65 := $(CC65_PATH)/bin/ld65

CHR_ENCODE := $(PYTHON) tools/nes_chr_encode.py

CAFLAGS = -g
LDFLAGS =

.SUFFIXES:
.SECONDEXPANSION:
.PRECIOUS:
.SECONDARY:
.PHONY: clean tools

example.nes: $(example_obj)

tools/cTools/scan_includes:
	$(MAKE) -C tools/cTools/

# Build tools when building the rom.
# This has to happen before the rules are processed, since that's when scan_includes is run.
ifeq (,$(filter clean tools/cTools/,$(MAKECMDGOALS)))
$(info $(shell $(MAKE) -C tools/cTools/))
endif

%.o: dep = $(shell tools/cTools/scan_includes $(@D)/$*.s)
$(example_obj): %.o: %.s $$(dep)
	$(CA65) $(CAFLAGS) $*.s -o $@

gfx/%.chr: gfx/%.png
	$(CHR_ENCODE) $< $@

%.nes: %.cfg
	$(LD65) $(LDFLAGS) -Ln $(basename $@).lbl --dbgfile $(basename $@).dbg -o $@ -C $< $(example_obj)

clean:
	-rm -f  $(example_obj) example.nes *.d example.dbg example.lbl gfx/*.chr
	$(MAKE) clean -C tools/cTools/