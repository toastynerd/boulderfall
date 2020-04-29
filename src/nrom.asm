;boulder fall single screen game, woo!
;toastynerd 2020

.import handle_nmi, handle_reset 

.segment "INESHDR"
	.byte	"NES", $1a
	.byte	$01	;prg size in 16k
	.byte	$01	;chr size in 8k
	.byte	$00	;mirroring and lo mapper nibble
	.byte	$00	;mapper number hi nibble

.segment "VECTORS"
	.addr	handle_nmi, handle_reset 
