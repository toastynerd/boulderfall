title	:=	boulderfall
objs 	:=	init nrom main background player boulders ppu_clear input
srcdir	:=	src
out 	:=	boulderfall.nes

all: $(out)

objlist = $(foreach o,$(objs),$(srcdir)/$(o).o)

clean:
	rm -f $(objlist) rom/$(out)

cartridge: boulderfall.nes
	inlretro -c nes -m nrom -x 32 -y 8 -p boulderfall.nes

.PHONY: all clean


$(srcdir)/%.o: $(srcdir)/%.asm
	ca65 $< -o $@ --debug-info

boulderfall.nes: $(objlist)
	ld65 -C nrom128.cfg $(objlist) -o rom/$@ -m map.txt
