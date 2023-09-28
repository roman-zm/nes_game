
.segment "CODE"

  ; add new energy_bank
.proc add_energy_bank
  php
  pha
  tax
  pha
  tay
  pha

  ldx #$0
loop:
  lda energy_banks + EnergyBank::ycoord, X
  cmp #$ff
  beq write_energy_bank

  inx
  inx

  cpx #.sizeof(EnergyBank) * ENERGY_BANK_COUNT
  bne loop
  jmp return

write_energy_bank:
  lda #$0 + Y_MIN
  sta energy_banks + EnergyBank::ycoord, X

  jsr prng
  lda seed
  cmp #$f1
  bcc write_energy_bank_x
  sbc #$f
write_energy_bank_x:
  sta energy_banks + EnergyBank::xcoord, X

return:
  pla
  tay
  pla
  tax
  pla
  plp
  rts
.endproc

.proc update_energy_banks
  php
  pha
  tax
  pha
  tay
  pha

  ; spawn energy_bank
  lda frame_counter
  cmp #$0
  bne move_energy_banks_init
  dec energy_cooldown
  bne move_energy_banks_init
  jsr add_energy_bank
  lda #$2
  sta energy_cooldown

move_energy_banks_init:
  ldx #$0
move_energy_banks_loop:
  lda energy_banks + EnergyBank::ycoord, X
  cmp #$ff

  ; if energy_bank Y less than FF
  bne move_energy_bank_body
  ;  else
  jmp goto_next

move_energy_bank_body:
  clc
  adc #$1
  bcc set_a_to_energy_bank
  lda #$ff

set_a_to_energy_bank:
  sta energy_banks + EnergyBank::ycoord, X
  jmp goto_next

goto_next:
  inx
  inx  ; move to next X
  cpx #.sizeof(EnergyBank) * ENERGY_BANK_COUNT
  BNE move_energy_banks_loop

  pla
  tay
  pla
  tax
  pla
  plp
  rts
.endproc

.proc draw_energy_banks
  php
  pha
  tax
  pha
  tay
  pha

  ldx #$0
loop:
  txa
  asl
  tay

  lda energy_banks + EnergyBank::ycoord, X  ; energy_bank Y coord
  stA ENERGY_BANK_ADDR + Sprite::ycoord, Y

  lda #$b  ; set tile
  sta ENERGY_BANK_ADDR + Sprite::tile, Y

  lda #%00000000  ; set palette
  sta ENERGY_BANK_ADDR + Sprite::attrs, Y

  lda energy_banks + EnergyBank::xcoord, X  ; load X coord
  clc
  adc #$4
  sta ENERGY_BANK_ADDR + Sprite::xcoord, Y

  inx
  inx
  cpx #.sizeof(EnergyBank) * ENERGY_BANK_COUNT
  bne loop

  pla
  tay
  pla
  tax
  pla
  plp

  rts
.endproc