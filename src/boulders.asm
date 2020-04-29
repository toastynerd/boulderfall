;boulders.asm
;
;the enemies of the game, in this case boulders
;all code related to managing boulders is here
;
;boulderfall, a single screen NES game!
;
;toastynerd	2020

.include "nes.inc"
.include "global.inc"
.include "defs.inc"

.segment "ZEROPAGE"
	boulders_x:		.res	10
	boulders_y:		.res	10
	boulders_speed:		.res	10
	boulders_num:		.res	1
	pointer_low:		.res	1
	pointer_high:		.res	1
	
.segment "CODE"

.proc init_boulders
;set initial values of boulders
	lda	#$0a
	sta	boulders_num
	ldx	#$00
@loop:
	txa
	asl
	asl
	asl
	asl
	sta	boulders_x, x
	lda 	#$10
	sta	boulders_y, x
	lda	#$01
	sta	boulders_speed, x
	inx
	cpx	boulders_num
	bne	@loop
	rts
.endproc

.proc update_boulders
;update the boulder values 
;the "logic" code for the boulders
;~once per frame
	ldx	#00
@loop:
	lda	boulders_y, x
	clc
	adc	boulders_speed, x
	sta	boulders_y, x
	inx
	cpx	boulders_num
	bne	@loop
	rts
.endproc

.proc draw_boulders
	ldx	#$00
@loop:
	lda	oam_used
	asl
	asl	; number of sprites used * 4
	tay
	lda	boulders_y, x
	sta	OAM, y
	iny
	lda	#$01
	sta	OAM, y
	iny
	lda	#$00
	sta	OAM, y
	iny
	lda	boulders_x, x
	sta	OAM, y
	inx
	inc	oam_used
	cpx	boulders_num
	bne	@loop
	
	
	rts
.endproc
