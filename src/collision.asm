.segment "CODE"

.proc check_collision
  ldx #$0

loop:
  ldy #$0

nested_loop:
  lda projectiles + Projectile::ycoord, X
  cmp #$ff
  beq check_next_projectile

  lda meteors + Meteor::ycoord, Y
  cmp #$ff
  beq check_next_meteor

; projectile y < meteor y + height
  lda meteors + Meteor::ycoord, Y
  adc #$2
  cmp projectiles + Projectile::ycoord, X
  bcc check_next_meteor

; projectile x < meteor x + width
  lda meteors + Meteor::xcoord, Y
  adc #$6
  cmp projectiles + Projectile::xcoord, X
  bcc check_next_meteor

; projectile y + height > meteor y
  lda projectiles + Projectile::ycoord, X
  adc #$2
  cmp meteors + Meteor::ycoord, Y
  bcc check_next_meteor

; projectile x + width > meteor x
  lda projectiles + Projectile::xcoord, X
  adc #$6
  cmp meteors + Meteor::xcoord, Y
  bcc check_next_meteor

collision_detected:
  lda #$ff
  sta projectiles + Projectile::ycoord, X
  sta meteors + Meteor::ycoord, Y
  jmp check_next_projectile

check_next_meteor:
  iny
  iny
  cpy #.sizeof(Meteor) * METEORS_COUNT
  bne nested_loop

check_next_projectile:
  inx
  inx
  cpx #.sizeof(Projectile) * PRJCTL_COUNT
  bne loop

  rts
.endproc
