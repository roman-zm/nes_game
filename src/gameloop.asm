.segment "CODE"
.proc game_loop
  jsr compute_scroll
  jsr read_controller1

  jsr update_player
  jsr update_projectiles

  jsr update_meteors
  jsr update_energy_banks
  jsr check_collision

  jsr draw_player
  jsr draw_projectiles
  jsr draw_meteors
  jsr draw_energy_banks

  ; jsr toggle_panel
  jsr ppu_update
  jmp game_loop

.endproc

.proc ppu_update
  lda #1
  sta nmi_ready
:
  lda nmi_ready
  bne :-
  rts
.endproc

.proc toggle_panel
  lda scroll
  cmp #$20
  bne return

  lda ppuctrl_settings
  and #$3
  ; currently on nametable 0
  ; beq hide_on_zero
  beq nt_zero

nt_two:
  lda frame_counter
  and #$1
  beq hide_on_two

show_on_zero:
  jsr select_nt_zero
  lda #$3
  jsr draw_panel
  jmp return

hide_on_two:
  jsr toggle_panel_nt
  jsr select_nt_two
  ; lda #$2
  ; jsr draw_panel
  jsr hide_panel
  jmp return

; ------
nt_zero:
  lda frame_counter
  and #$1
  beq hide_on_zero

show_on_two:
  jsr select_nt_two
  lda #$3
  jsr draw_panel
  jmp return

hide_on_zero:
  jsr toggle_panel_nt
  jsr select_nt_zero
  ; lda #$2
  ; jsr draw_panel
  jsr hide_panel
  jmp return

; --------

return:
  rts
.endproc

.proc toggle_panel_nt
  lda panel_nt
  eor #%00000010
  sta panel_nt
  rts
.endproc