objs :=	boulderfall.o
out :=	boulderfall.nes

all: $(out)

clean:
	rm -f $(objs) $(out)

cartridge: boulderfall.nes
	inlretro -c nes -m nrom -x 32 -y 8 -p boulderfall.nes

.PHONY: all clean

%.o: %.asm
	ca65 $< -o $@ --debug-info

boulderfall.o: boulderfall.asm

boulderfall.nes: $(objs)
	ld65 -t nes $(objs) -o $@
