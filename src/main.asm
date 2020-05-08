; main.asm
; boulderfall, a single screen NES game , wooo
; toastynerd 2020

.include "nes.inc"
.include "global.inc"
.include "defs.inc"

.segment "ZEROPAGE"
nmis:		.res	1
oam_used:	.res	1
cur_keys:	.res	1
new_keys:	.res	1
game_state:	.res	1
start_time:	.res	2

.segment "CODE"

.proc handle_nmi
	inc	nmis	;should already be zeroed from clearmem
	rti
.endproc

.proc handle_irq
	rti
.endproc

.proc main
	lda	#STATETITLE
	sta	game_state
	jsr	load_palette

	jsr	draw_bg

	lda	#VBLANK_NMI
	sta	PPUCTRL

init_sprites:

	jsr	init_player
	jsr	init_boulders

game_loop:
	inc	start_time
	jsr	read_input
	clc
	jsr	check_start
	bcs	init_sprites
	jsr	check_collisions


	lda	#$00
	sta	oam_used

	lda	game_state

	cmp	#STATETITLE
	beq	title_loop

	cmp	#STATEPLAYING	
	bne	not_playing

	jsr	update_player
	jsr	update_boulders
not_playing:
	jsr	draw_player
	jsr	draw_boulders
title_loop:

	ldx	oam_used
	jsr	ppu_clear_oam

	lda	nmis
vblank:
	cmp	nmis
	beq	vblank

	lda	#$00
	sta	nmis

	lda	#$00
	sta	OAMADDR
	lda	#>OAM
	sta	OAM_DMA

	;turn screen on
	ldx	#$ff
	lda	game_state
	cmp	#STATETITLE
	beq	display_title
	ldx	#$00
display_title:
	ldy	#$00
	lda	#VBLANK_NMI|BG_0000|OBJ_1000
	sec
	jsr	ppu_screen_on
	
	jmp	game_loop
.endproc

.proc load_palette
	lda	PPUSTATUS
	lda	#$3f
	sta	PPUADDR
	lda	#$00
	sta	PPUADDR
	ldx	#$00
@loop:
	lda	palette, x
	sta	PPUDATA
	inx
	cpx	#$20
	bne	@loop
	rts

.endproc

.segment "RODATA"
palette:
	.incbin "../bin/boulderfall.pal"
	.incbin "../bin/boulderfall.pal"

.segment "CHR"
	.incbin "../bin/boulderfall.chr"
