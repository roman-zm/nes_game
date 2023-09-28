.segment "CODE"

.proc draw_player
  ; save registers
  php
  pha
  txa
  pha
  tya
  pha

  TILE_SIZE = $08

  ; Write tiles
  lda #$5
  sta PLAYER_ADDR + .sizeof(Sprite) * 0 + Sprite::tile  ; sprite 0   $0201
  sta PLAYER_ADDR + .sizeof(Sprite) * 1 + Sprite::tile  ; sprite 1   $0205

  lda #$7
  sta PLAYER_ADDR + .sizeof(Sprite) * 2 + Sprite::tile  ; sprite 2  $0209
  sta PLAYER_ADDR + .sizeof(Sprite) * 3 + Sprite::tile  ; sprite 3  $020d

  ; Write attributes
  lda #$0
  sta PLAYER_ADDR + .sizeof(Sprite) * 0 + Sprite::attrs  ; sprite 0   $0202
  sta PLAYER_ADDR + .sizeof(Sprite) * 2 + Sprite::attrs  ; sprite 2   $020a

  lda #%01000000
  sta PLAYER_ADDR + .sizeof(Sprite) * 1 + Sprite::attrs  ; sprite 1   $0206
  sta PLAYER_ADDR + .sizeof(Sprite) * 3 + Sprite::attrs  ; sprite 3   $020e

  ; Tile positions
  lda player_y
  sta PLAYER_ADDR + .sizeof(Sprite) * 0 + Sprite::ycoord ; sprite 0   $0200
  sta PLAYER_ADDR + .sizeof(Sprite) * 1 + Sprite::ycoord ; sprite 1   $0204
  clc
  adc #TILE_SIZE
  sta PLAYER_ADDR + .sizeof(Sprite) * 2 + Sprite::ycoord ; sprite 2   $0208
  sta PLAYER_ADDR + .sizeof(Sprite) * 3 + Sprite::ycoord ; sprite 3   $020c

  lda player_x
  sta PLAYER_ADDR + .sizeof(Sprite) * 0 + Sprite::xcoord ; sprite 0   $0203
  sta PLAYER_ADDR + .sizeof(Sprite) * 2 + Sprite::xcoord ; sprite 2   $020b
  clc
  adc #TILE_SIZE
  sta PLAYER_ADDR + .sizeof(Sprite) * 1 + Sprite::xcoord ; sprite 1   $0207
  sta PLAYER_ADDR + .sizeof(Sprite) * 3 + Sprite::xcoord ; sprite 3   $020f

  ; Restore registers
  pla
  tay
  pla
  tax
  pla
  plp

  rts
.endproc

.proc update_player
  ; save registers
  php
  pha
  txa
  pha
  tya
  pha

  jsr move_player
  lda pad1
  and #BTN_A
  beq exit
  jsr move_player

exit:
  ; restore registers
  pla
  tay
  pla
  tax
  pla
  plp

  rts
.endproc

.proc move_player
  ; save registers
  php
  pha
  txa
  pha
  tya
  pha

  lda pad1
  and #BTN_RIGHT
  beq check_down
  lda player_x
  cmp #$f0
  bcs check_down
  inc player_x

check_down:
  lda pad1
  and #BTN_DOWN
  beq check_left
  lda player_y
  cmp #$d7
  bcs check_left
  inc player_y

check_left:
  lda pad1
  and #BTN_LEFT
  beq check_up
  lda player_x
  cmp #$0
  bcc check_up
  beq check_up
  dec player_x

check_up:
  lda pad1
  and #BTN_UP
  beq end_direction_check
  lda player_y
  cmp #$8 + Y_MIN
  bcc end_direction_check
  dec player_y

end_direction_check:

  lda player_x

  ; Restore registers
  pla
  tay
  pla
  tax
  pla
  plp

  rts
.endproc