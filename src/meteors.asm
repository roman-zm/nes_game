.segment "CODE"

.proc update_meteors

  ; Spawn meteor
  dec meteors_cooldown
  bne move_meteors_init
  jsr add_meteor
  lda #$3f
  sta meteors_cooldown

move_meteors_init:
  ldx #$0
move_meteors_loop:
  lda meteors + Meteor::ycoord, X
  cmp #$ff

  ; If meteor Y less than FF
  bne move_meteor_body
  ; Else
  jmp goto_next

move_meteor_body:
  clc
  adc #$1
  bcc set_a_to_meteor
  lda #$ff
set_a_to_meteor:
  sta meteors + Meteor::ycoord, X
  jmp goto_next

goto_next:
  inx
  inx  ; move to next X
  cpx #.sizeof(Meteor) * METEORS_COUNT
  bne move_meteors_loop

  rts
.endproc

; add new meteor
.proc add_meteor
  ldx #$0
loop:
  lda meteors + Meteor::ycoord, X
  cmp #$ff
  beq write_meteor

  inx
  inx

  cpx #.sizeof(Meteor) * METEORS_COUNT
  bne loop
  jmp return

write_meteor:
  lda #$0 + Y_MIN
  sta meteors + Meteor::ycoord, X

  jsr prng
  lda seed
  cmp #$f1
  bcc write_meteor_x
  sbc #$f
write_meteor_x:
  sta meteors + Meteor::xcoord, X

return:
  rts
.endproc

.proc draw_meteors

  ldx #$0
loop:
  txa
  asl
  tay

  lda meteors + Meteor::ycoord, X  ; meteor Y coord
  sta METEORS_ADDR + Sprite::ycoord, Y

  lda #$a  ; set tile
  sta METEORS_ADDR + Sprite::tile, Y

  lda #%00000011  ; set palette
  sta METEORS_ADDR + Sprite::attrs, Y

  lda meteors + Meteor::xcoord, X  ; load X coord
  clc
  adc #$4
  sta METEORS_ADDR + Sprite::xcoord, Y

  inx
  inx
  cpx #.sizeof(Meteor) * METEORS_COUNT
  bne loop

  rts
.endproc