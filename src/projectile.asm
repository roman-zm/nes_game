
.segment "CODE"

; add new projectile
.proc add_projectile
  php
  pha
  tax
  pha
  tay
  pha

  ldx #$0
loop:
  ; find unused projectile and write new one
  lda projectiles + Projectile::ycoord, X
  cmp #$ff
  beq write_projectile

  inx
  inx
  cpx #.sizeof(Projectile) * PRJCTL_COUNT

  bne loop
  jmp return

write_projectile:
  ; X - address of unused projectile
  lda player_y
  sta projectiles + Projectile::ycoord, X

  lda player_x
  sta projectiles + Projectile::xcoord, X

  lda #PRJCTL_COOLDOWN_VALUE
  sta projectile_cooldown

return:
  pla
  tay
  pla
  tax
  pla
  plp
  rts
.endproc

.proc update_projectiles
  php
  pha
  tax
  pha
  tay
  pha

  lda projectile_cooldown
  cmp #$0
  beq check_fire_btn
  dec projectile_cooldown
  jmp move_projectiles_init

check_fire_btn:
  lda pad1
  and #BTN_B
  beq move_projectiles_init
  jsr add_projectile

move_projectiles_init:
  ldx #$0
move_projectiles_loop:
  lda projectiles + Projectile::ycoord, X
  cmp #$ff

  ; If projectile Ycoord less than FE
  bne move_projectile_body
  ; Else
  jmp goto_next

move_projectile_body:
  sec
  sbc #$3
  cmp #Y_MIN
  bcs set_a_to_projectile
  ; If carry is cleared, then destroy projectile by setting ff to ycoord
  lda #$ff

set_a_to_projectile:
  sta projectiles + Projectile::ycoord, X

goto_next:
  inx
  inx  ; move to next X
  cpx #.sizeof(Projectile) * PRJCTL_COUNT
  bne move_projectiles_loop

  pla
  tay
  pla
  tax
  pla
  plp
  rts
.endproc

.proc draw_projectiles
  php
  pha
  tax
  pha
  tay
  pha

  ldx #$0 ; projectile index
loop:
  txa ; sizeof(Projectile) == 2 bytes
  asl ; sizeof(Sprite) == 4 bytes
  tay ; следовательно Y - индекс спрайта = X * 2

  lda projectiles + Projectile::ycoord, X  ; projectile Y coord
  sta PRJCTL_ADDR + Sprite::ycoord, Y

  lda #$9  ; set tile
  sta PRJCTL_ADDR + Sprite::tile, Y

  lda #%00000010  ; set palette
  sta PRJCTL_ADDR + Sprite::attrs, Y

  lda projectiles + Projectile::xcoord, X  ; load X coord
  clc
  adc #$4
  sta PRJCTL_ADDR + Sprite::xcoord, Y

  inx
  inx

  cpx #.sizeof(Projectile) * PRJCTL_COUNT
  bne loop

  pla
  tay
  pla
  tax
  pla
  plp

  rts
.endproc