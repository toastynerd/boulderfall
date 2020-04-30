title	:=	boulderfall
objs 	:=	init nrom main background player boulders ppu_clear input random
srcdir	:=	src
out 	:=	boulderfall.nes

all: $(out)

objlist = $(foreach o,$(objs),$(srcdir)/$(o).o)

clean:
	rm -f $(objlist) rom/$(out)

cartridge: boulderfall.nes
	inlretro -c nes -m nrom -x 16 -y 8 -p rom/boulderfall.nes

.PHONY: all clean


$(srcdir)/%.o: $(srcdir)/%.asm
	ca65 $< -o $@ --debug-info

boulderfall.nes: $(objlist)
	ld65 -C nrom128.cfg $(objlist) -o rom/$@ -m map.txt
