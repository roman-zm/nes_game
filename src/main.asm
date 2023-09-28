.segment "CODE"
.proc compute_scroll
  lda ppuctrl_settings
  and #%11111100
  ora panel_nt
  ; lsr
  ; lsr
  ; asl
  ; asl
  sta PPUCTRL

  lda #$0
  sta PPUSCROLL
  sta PPUSCROLL

Sprite0ClearWait:
  bit $2002
  bvs Sprite0ClearWait

Sprite0Wait:
  bit $2002
  bvc Sprite0Wait

  ; scroll every 2 frames
  lda frame_counter
  and #%00000001
  beq return

  lda scroll
  cmp #$0 ; did we scroll to the end
  bne set_scroll_positions

  ; if we are scroll to the end
  lda ppuctrl_settings
  eor #%00000010
  sta ppuctrl_settings
  ; sta PPUCTRL
  lda #240
  sta scroll

  ; else
set_scroll_positions:
  dec scroll

return:
  jsr perform_scroll
  rts
.endproc

.proc perform_scroll
  ; Write nametable bits to t.
  lda ppuctrl_settings
  and #%00000011
  asl
  asl
  sta PPUADDR

  ; Write y bits to t.
  lda scroll
  sta PPUSCROLL

  ; The last write needs to occur during horizontal blanking
  ; to avoid visual glitches.
  ; HBlank is very short, so calculate the value to write now, before HBlank.

  and #$f8
  asl
  asl
  sta tmp

  lda #$0
  ; Write the X bits to t and x.
  sta PPUSCROLL

  ; Finish calculating the fourth write.
  lsr
  lsr
  lsr
  ora tmp

  ; Wait for HBlank.
  ldx #$4     ; How long to wait. Play around with this value
  ; until you don't have a visual glitch.
loop:
  dex
  bne loop

  ; Write to t and copy t to v.
  sta PPUADDR
  rts
.endproc

.proc main
  lda #$0
  sta frame_counter

  lda #239  ; Y max is 240
  sta scroll

  ; Palettes
  ldx #$3f
  stx PPUADDR
  ldx #$0
  stx PPUADDR

draw_zero_sprite:
  jsr zero_sprite

  ldx #$0
load_palettes:
  lda palettes, x
  sta PPUDATA
  inx
  cpx #$20
  bne load_palettes

  ldx #$20
  jsr draw_starfield

  ldx #$28
  jsr draw_starfield

  jsr draw_objects

  ; enable graphics when crt is vblank
vblankwait:
  bit PPUSTATUS
  bpl vblankwait

  lda #%10010000
  sta ppuctrl_settings
  sta PPUCTRL

  lda #%00011110
  sta PPUMASK

  lda #$0
  sta panel_nt

  lda #$1
  sta nmi_ready

  jmp game_loop
.endproc

.proc zero_sprite
  lda #$0
  sta ZERO_TILE + Sprite::xcoord

  lda #Y_MIN - 8
  sta ZERO_TILE + Sprite::ycoord

  ; lda #$2e
  lda #$c
  sta ZERO_TILE + Sprite::tile

  rts
.endproc

.proc prepare_next_frame
.endproc

