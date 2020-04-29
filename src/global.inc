.ifndef 	GLOBAL_INC
.define		GLOBAL_INC

;init.asm
.global		handle_reset

;main.asm
.global		main, handle_nmi
.globalzp	oam_used, cur_keys, new_keys

;background.asm
.global		draw_bg

;player.asm
.global		init_player, update_player, draw_player

;boulders.asm
.global		init_boulders, update_boulders, draw_boulders

;ppu_clear.asm
.global		ppu_clear_nt, ppu_clear_oam, ppu_screen_on

;input.asm
.global		read_input

;random.asm
.global		set_seed, gen_number

.endif
