;boulder fall single screen game, woo!
;toastynerd 2020

.import handle_nmi, handle_reset, handle_irq

.segment "INESHDR"
	.byte	"NES", $1a
	.byte	$01	;prg size in 16k
	.byte	$01	;chr size in 8k
	.byte	$01	;mirroring and lo mapper nibble
	.byte	$00	;mapper number hi nibble
	.byte	$00, $00, $00, $00, $00, $00, $00, $00
.segment "VECTORS"
	.addr	handle_nmi, handle_reset, handle_irq
