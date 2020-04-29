;input.asm
;
;handle input from the controllers to prepare to update the player
;
;boulderfall, a single screen NES game boooya!
;
;toastynerd	2020

.include "nes.inc"
.include "global.inc"

.segment "ZEROPAGE"

.segment "CODE"

.proc read_input
	rts
.endproc
