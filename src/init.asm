; boulderfall, single screen game
; init.asm - reset code and other init things
; toastynerd 2020

.include "nes.inc"
.include "global.inc"
.include "defs.inc"

.segment "CODE"
.proc handle_reset
	sei
	cld

	ldx	#$00
	stx	PPUCTRL
	stx	PPUMASK
	stx	$4010
	dex		;set x to $ff
	txs
	bit	PPUSTATUS
	bit	SNDCHN
	lda	#$40
	sta	P2
	lda	#$0f
	sta	SNDCHN
	jsr	vblankwait

	ldx	#$00
	jsr	ppu_clear_oam

clearmem:
	ldx	#$00
@loop:
	lda	#$00
	sta	$00, x
	sta	$0100, x
	sta	$0300, x
	sta	$0400, x
	sta	$0500, x
	sta	$0600, x
	sta	$0700, x
	lda	#$ff
	sta	$0200, x
	inx
	bne	@loop

	jsr	vblankwait
	
	lda	#STATEPLAYING
	sta	game_state

	jmp	main
.endproc

vblankwait:
@loop:
	bit	PPUSTATUS
	bpl	@loop
	rts
