;player.asm
;
;all of the code and values associated with the player
;
;boulderfall, a single screen NES game, yah!!!!
;
;toastynerd	2020

.include "nes.inc"
.include "global.inc"
.include "defs.inc"


.segment "ZEROPAGE"
player_x:	.res	1
player_y:	.res	1
player_speed:	.res	1
player_facing:	.res	1

.segment "CODE"

.proc init_player
;initial player value
	lda	#$cf
	sta	player_y
	lda	#$50
	sta	player_x
	lda	#$02
	sta	player_speed
	lda	#FACINGLEFT
	sta	player_facing
	rts
.endproc

.proc update_player
;player logic code does not contain input handling
	rts
.endproc

.proc draw_player
;draw the player to the ppu
	lda	player_y
	sta	OAM

	lda	#$00
	sta	OAM + 1

	ldx	player_facing
	cpx	#FACINGLEFT
	lda	#$02
	bne	@faceright
	jmp	@facedone
@faceright:
	lda	#%01000010
@facedone:
	sta	OAM + 2

	lda	player_x
	sta	OAM + 3
	inc	oam_used

	rts
.endproc
