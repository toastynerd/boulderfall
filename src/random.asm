;random.asm
;
;code related to the prng for boulderfall
;
;boulderfall, a single screen NES game, kerpow!
;
;toastynerd	2020

;this code taken from: https://wiki.nesdev.com/w/index.php/Random_number_generator

.include "nes.inc"
.include "global.inc"
.include "defs.inc"

.segment "ZEROPAGE"
seed:	.res	2

.segment "CODE"

;set the the seed for prng, does not modify the params
;@param x low byte for the seed
;@param y high byte for the seed
.proc set_seed
	txa
	sta	seed+0
	tya
	sta	seed+1

	rts
.endproc

;using the seed generates a random number and stores it in A
;clobbers Y
.proc gen_number
	ldy	#$08
	lda	seed+0
:
	asl
	rol	seed+1
	bcc	:+
	eor	#$39
:
	dey
	bne	:--
	sta	seed+0
	cmp	#$00
	rts
.endproc
