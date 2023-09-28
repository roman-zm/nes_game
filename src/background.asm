.segment "CODE"
.proc draw_starfield
  ; X register stores high byte of nametable
  ; write nametables
  ; big stars first
  lda PPUSTATUS
  txa
  sta PPUADDR
  lda #$6b
  sta PPUADDR
  ldy #$2f
  sty PPUDATA

  lda PPUSTATUS
  txa
  adc #$1
  sta PPUADDR
  lda #$57
  sta PPUADDR
  sty PPUDATA

  lda PPUSTATUS
  txa
  adc #$2
  sta PPUADDR
  lda #$23
  sta PPUADDR
  sty PPUDATA

  lda PPUSTATUS
  txa
  adc #$3
  sta PPUADDR
  lda #$52
  sta PPUADDR
  sty PPUDATA

  ; Next, small star 1
  lda PPUSTATUS
  txa
  sta PPUADDR
  lda #$74
  sta PPUADDR
  ldy #$2d
  sty PPUDATA

  lda PPUSTATUS
  txa
  adc #$1
  sta PPUADDR
  lda #$43
  sta PPUADDR
  sty PPUDATA

  lda PPUSTATUS
  txa
  adc #$1
  sta PPUADDR
  lda #$5d
  sta PPUADDR
  sty PPUDATA

  lda PPUSTATUS
  txa
  adc #$1
  sta PPUADDR
  lda #$73
  sta PPUADDR
  sty PPUDATA

  lda PPUSTATUS
  txa
  adc #$2
  sta PPUADDR
  lda #$2f
  sta PPUADDR
  sty PPUDATA

  lda PPUSTATUS
  txa
  adc #$2
  sta PPUADDR
  lda #$f7
  sta PPUADDR
  sty PPUDATA

  ; Finally, small star 2
  lda PPUSTATUS
  txa
  sta PPUADDR
  lda #$f1
  sta PPUADDR
  ldy #$2e
  sty PPUDATA

  lda PPUSTATUS
  txa
  adc #$1
  sta PPUADDR
  lda #$a8
  sta PPUADDR
  sty PPUDATA

  lda PPUSTATUS
  txa
  adc #$2
  sta PPUADDR
  lda #$7a
  sta PPUADDR
  sty PPUDATA

  lda PPUSTATUS
  txa
  adc #$3
  sta PPUADDR
  lda #$44
  sta PPUADDR
  sty PPUDATA

  lda PPUSTATUS
  txa
  adc #$3
  sta PPUADDR
  lda #$7c
  sta PPUADDR
  sty PPUDATA

  ; Finally, attribute table
  ; lda PPUSTATUS
  ; lda #$23
  ; sta PPUADDR
  ; lda #$c2
  ; sta PPUADDR
  ; lda #%01000000
  ; sta PPUDATA

  lda PPUSTATUS
  lda #$23
  sta PPUADDR
  lda #$e0
  sta PPUADDR
  lda #%00001100
  sta PPUDATA

  rts
.endproc

.proc draw_objects

  lda PPUSTATUS
  lda #$20
  sta PPUADDR
  lda #$60
  sta PPUADDR
  ldx #$3d
  stx PPUDATA

  ; Draw objects on top of the starfield,
  ; and update attribute tables

  ; new additions: galaxy and planet
  lda PPUSTATUS
  lda #$21
  sta PPUADDR
  lda #$90
  sta PPUADDR
  ldx #$30
  stx PPUDATA
  ldx #$31
  stx PPUDATA

  lda PPUSTATUS
  lda #$21
  sta PPUADDR
  lda #$b0
  sta PPUADDR
  ldx #$32
  stx PPUDATA
  ldx #$33
  stx PPUDATA

  lda PPUSTATUS
  lda #$20
  sta PPUADDR
  lda #$42
  sta PPUADDR
  ldx #$38
  stx PPUDATA
  ldx #$39
  stx PPUDATA

  lda PPUSTATUS
  lda #$20
  sta PPUADDR
  lda #$62
  sta PPUADDR
  ldx #$3a
  stx PPUDATA
  ldx #$3b
  stx PPUDATA

  ; Nametable 2 additions: big galaxy, space station

  lda PPUSTATUS
  lda #$28
  sta PPUADDR
  lda #$60
  sta PPUADDR
  ldx #$3d
  stx PPUDATA

  lda PPUSTATUS
  lda #$28
  sta PPUADDR
  lda #$c9
  sta PPUADDR
  lda #$41
  sta PPUDATA
  lda #$42
  sta PPUDATA
  lda #$43
  sta PPUDATA

  lda PPUSTATUS
  lda #$28
  sta PPUADDR
  lda #$e8
  sta PPUADDR
  lda #$50
  sta PPUDATA
  lda #$51
  sta PPUDATA
  lda #$52
  sta PPUDATA
  lda #$53
  sta PPUDATA

  lda PPUSTATUS
  lda #$29
  sta PPUADDR
  lda #$8
  sta PPUADDR
  lda #$60
  sta PPUDATA
  lda #$61
  sta PPUDATA
  lda #$62
  sta PPUDATA
  lda #$63
  sta PPUDATA

  lda PPUSTATUS
  lda #$29
  sta PPUADDR
  lda #$28
  sta PPUADDR
  lda #$70
  sta PPUDATA
  lda #$71
  sta PPUDATA
  lda #$72
  sta PPUDATA

  ; Space station
  lda PPUSTATUS
  lda #$29
  sta PPUADDR
  lda #$f2
  sta PPUADDR
  lda #$44
  sta PPUDATA
  sta PPUDATA

  lda PPUSTATUS
  lda #$29
  sta PPUADDR
  lda #$f6
  sta PPUADDR
  lda #$44
  sta PPUDATA
  sta PPUDATA

  lda PPUSTATUS
  lda #$2a
  sta PPUADDR
  lda #$12
  sta PPUADDR
  lda #$54
  sta PPUDATA
  sta PPUDATA
  lda #$45
  sta PPUDATA
  lda #$46
  sta PPUDATA
  lda #$54
  sta PPUDATA
  sta PPUDATA

  lda PPUSTATUS
  lda #$2a
  sta PPUADDR
  lda #$32
  sta PPUADDR
  lda #$44
  sta PPUDATA
  sta PPUDATA
  lda #$55
  sta PPUDATA
  lda #$56
  sta PPUDATA
  lda #$44
  sta PPUDATA
  sta PPUDATA

  lda PPUSTATUS
  lda #$2a
  sta PPUADDR
  lda #$52
  sta PPUADDR
  lda #$44
  sta PPUDATA
  sta PPUDATA

  lda PPUSTATUS
  lda #$2a
  sta PPUADDR
  lda #$56
  sta PPUADDR
  lda #$44
  sta PPUDATA
  sta PPUDATA

  ; Finally, attribute tables
  lda PPUSTATUS
  lda #$23
  sta PPUADDR
  lda #$dc
  sta PPUADDR
  lda #%00000001
  sta PPUDATA

  lda PPUSTATUS
  lda #$2b
  sta PPUADDR
  lda #$ca
  sta PPUADDR
  lda #%10100000
  sta PPUDATA

  lda PPUSTATUS
  lda #$2b
  sta PPUADDR
  lda #$d2
  sta PPUADDR
  lda #%00001010
  sta PPUDATA

  jsr select_nt_zero
  lda #$3
  jsr draw_panel

  jsr select_nt_two
  lda #$3
  jsr hide_panel

  rts
.endproc

.proc select_nt_two
  lda PPUSTATUS
  lda #$28
  sta PPUADDR
  lda #$20
  sta PPUADDR
  rts
.endproc

.proc select_nt_zero
  lda PPUSTATUS
  lda #$20
  sta PPUADDR
  lda #$20
  sta PPUADDR
  rts
.endproc

.proc hide_panel
  lda #$0

  ldy #$3
loop_y:
  ldx #$20
loop_x:
  sta PPUDATA
  dex
  bne loop_x
  dey
  cpy #$1
  beq draw_mark
  cpy #$0
  bne loop_y

  rts

draw_mark:
  lda #$2
  sta PPUDATA
  lda #$0
  ldx #$1f
  jmp loop_x

.endproc

.proc draw_panel

  ldy #$3
loop_y:
  ldx #$20
loop_x:
  sta PPUDATA
  dex
  bne loop_x
  dey
  bne loop_y

  rts
.endproc
