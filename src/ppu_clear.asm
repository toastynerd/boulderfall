;ppu_clear.asm
;
;housekeeping functions for the ppu
;
;boulderfall, a single screen NES game, boom!
;
;toastynerd	2020

.include "nes.inc"
.include "global.inc"

.segment "ZEROPAGE"

.segment "CODE"

.proc ppu_clear_nt
	rts
.endproc

.proc ppu_clear_oam
	;move all of the unused sprites off screen
	txa
	and	#%11111100
	tax
	lda	#$ff
@loop:
	lda	OAM, x
	inx
	inx
	inx
	inx
	bne	@loop

	rts
.endproc

;@param A value for PPUCTRL
;@param X value for xscroll
;@param Y value for yscroll
;@param Carry Flag sets sprites to visible
.proc ppu_screen_on
	stx	PPUSCROLL
	sty	PPUSCROLL
	sta	PPUCTRL
	lda	#BG_ON
	bcc	@sprites_off
	lda	#BG_ON|OBJ_ON
@sprites_off:
	sta	PPUMASK
	
	rts
.endproc
