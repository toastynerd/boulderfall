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

.segment "ZEROPAGE"

.segment "CODE"

.proc init_boulders
;set initial values of boulders
	rts
.endproc

.proc update_boulders
;update the boulder values 
;the "logic" code for the boulders
;~once per frame
	rts
.endproc

.proc draw_boulders
	rts
.endproc
