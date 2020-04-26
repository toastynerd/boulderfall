;boulderfall, single screen game, woo!
;toastynerd

.segment "HEADER"
	.byte	"NES"
	.byte	$1a
	.byte	$02
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00, $00, $00, $00

.segment "ZEROPAGE"
;state variables
pointer_low:	.res	1
pointer_high:	.res	1
player_x:	.res	1
player_y:	.res	1
buttons:	.res	1
playerspeedx:	.res	1
player_facing:	.res	1

RIGHTWALL	= $f4
LEFTWALL	= $04
FACINGLEFT	= $00
FACINGRIGHT	= $01

.segment "STARTUP"

reset:
	sei
	cld
	;change the envelope
	ldx	#$40
	stx	$4017
	ldx	$ff
	txs
	inx
	stx	$2000
	stx	$2001
	stx	$4010

vblankwait1:
	bit	$2002
	bpl	vblankwait1


clearmem:
	lda	#$00
	sta	$0100, x
	sta	$0300, x
	sta	$0400, x
	sta	$0500, x
	sta	$0600, x
	sta	$0700, x
	lda	#$ff
	sta	$0200, x
	inx
	bne	clearmem

vblankwait2:
	bit	$2002
	bpl	vblankwait2

loadpalettes:
	lda	$2002
	lda	#$3f
	sta	$2006
	lda	#$00
	sta	$2006
	ldx	#$00
loadpalettesloop:
	lda	palette, x
	sta	$2007
	inx
	cpx	#$20
	bne	loadpalettesloop

loadbackground:
	lda	$2002
	lda	#$20
	sta	$2006
	lda	#$00
	sta	$2006

	lda	#<background
	sta	pointer_low
	lda	#>background
	sta	pointer_high

	ldx	#$00
	ldy	#$00
@outsideloop:

@insideloop:
	lda	(pointer_low), y
	sta	$2007

	iny
	cpy	#$ff
	bne	@insideloop

	inx
	inc	pointer_high
	cpx	#$04
	bne	@outsideloop


;initial values 
	ldx	#$00
sprite_loop:
	lda	sprites, x
	sta	$0204, x
	inx
	cpx	#$14
	bne	sprite_loop

	;player location
	lda	#$cf
	sta	player_y
	lda	#$50
	sta	player_x
	lda	#$01
	sta	playerspeedx
	lda	#FACINGLEFT
	sta	player_facing

	lda	#%10010000
	sta	$2000

	lda	#%00011110
	sta	$2001

	lda	#$00
	sta	$2005
	sta	$2005

gameloop:
	jmp gameloop

nmi:
	lda	#$00
	sta	$2003
	lda	#$02
	sta	$4014

	lda	#%10010000
	sta	$2000

	lda	#%00011110
	sta	$2001

	lda	#$00
	sta	$2005
	sta	$2005

	jsr	ReadController

	jsr	UpdateObjects

GameEngineDone:
	jsr	UpdateSprites
	rti

ReadController:
	lda	#$01
	sta	$4016
	lda	#$00
	sta	$4016
	ldx	#$08
ReadControllerLoop:
	lda	$4016
	lsr	a
	rol	buttons
	dex
	bne	ReadControllerLoop
	rts

UpdateObjects:
	;figure out input and update player
	
checkleft:
	lda	#$02	;bit mask for left
	eor	buttons
	bne	donecheckleft
	lda	player_x
	sec
	sbc	playerspeedx
	sta	player_x

	lda	#FACINGLEFT
	sta	player_facing
donecheckleft:

checkright:
	lda	#$01	;bit mask for right
	eor	buttons
	bne	donecheckright
	lda	player_x
	clc
	adc	playerspeedx
	sta	player_x

	lda	#FACINGRIGHT
	sta	player_facing
donecheckright:

move_boulders:
	;start of boulder sprites
	ldx	#$00
@loop:
	lda	$0204, x
	clc
	adc	#$02
	sta	$0204, x
	inx
	inx
	inx
	inx
	cpx 	#$14
	bne	@loop

	rts

UpdateSprites:
	lda	player_y
	sta	$0200

	lda	#$00
	sta	$0201

;this definitely needs to be refactored but not sure how to do it well
	ldx	player_facing
	cpx	#FACINGLEFT
	bne	faceright
	lda	#$02
	jmp	facedone
faceright:
	lda	#%01000010
facedone:
	sta	$0202

	lda	player_x
	sta	$0203

	rts

palette:
	.incbin "boulderfall.pal"
	.incbin "boulderfall.pal"

sprites:
	.byte	$05, $01, $00, $20
	.byte	$05, $01, $00, $40
	.byte	$05, $01, $00, $60
	.byte	$05, $01, $00, $80
	.byte	$05, $01, $00, $a0

background:
	.incbin "boulderfall.nam"

.segment "VECTORS"
	.word	nmi
	.word	reset

.segment "CHARS"
	.incbin "boulderfall.chr"
