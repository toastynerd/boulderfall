;input.asm
;
;handle input from the controllers to prepare to update the player
;
;boulderfall, a single screen NES game boooya!
;
;toastynerd	2020

.include "nes.inc"
.include "global.inc"
.include "defs.inc"

.segment "CODE"

.proc read_input
	lda	#$01
	sta	P1
	lda	#$00
	sta	P1
	ldx	#$08
@loop:
	lda	P1
	lsr	a
	rol	cur_keys
	dex
	bne	@loop
	rts
.endproc

.proc check_start
	lda	#KEY_START
	eor	cur_keys
	bne	done_check_start
	lda	#STATEPLAYING
	sta	game_state

	ldx	#<start_time
	ldy	#>start_time
	jsr	set_seed
	sec

done_check_start:
	rts
.endproc
