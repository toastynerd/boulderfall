; background.asm
; functions and code related to rendering the background
; boulderfall, a single screen NES game wooo!
; toastynerd 2020

.include "nes.inc"
.include "global.inc"

.segment "ZEROPAGE"
pointer_low:	.res	1
pointer_high:	.res	1

.segment "CODE"
.proc draw_bg
	lda	PPUSTATUS
	lda	#$20
	sta	PPUADDR
	lda	#$00
	sta	PPUADDR

	lda	#<background
	sta	pointer_low
	lda	#>background
	sta	pointer_high

	ldx	#$00
	ldy	#$00
@outsideloop:

@insideloop:
	lda	(pointer_low), y
	sta	PPUDATA

	iny
	bne	@insideloop

	inx
	inc	pointer_high
	cpx	#$04
	bne	@outsideloop

	rts
.endproc

.segment "RODATA"
background:
	.incbin "../bin/boulderfall.nam"
