.ifndef 	GLOBAL_INC
.define		GLOBAL_INC

;init.asm
.global		handle_reset

;main.asm
.global		main, handle_nmi, handle_irq
.globalzp	oam_used, cur_keys, new_keys, game_state

;background.asm
.global		draw_bg, draw_title

;player.asm
.global		init_player, update_player, draw_player
.globalzp	player_x, player_y, start_time

;boulders.asm
.global		init_boulders, update_boulders, draw_boulders, check_collisions

;ppu_clear.asm
.global		ppu_clear_nt, ppu_clear_oam, ppu_screen_on

;input.asm
.global		read_input, check_start

;random.asm
.global		set_seed, gen_number

.endif
