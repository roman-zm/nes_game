.segment "CODE"

; Bit | Button
; ----|-------
;  0  | Right
;  1  | Left
;  2  | Down
;  3  | Up
;  4  | Start
;  5  | Select
;  6  | B
;  7  | A
.proc read_controller1
  pha
  txa
  pha
  php

  lda #$1
  sta CONTROLLER1
  lda #$0
  sta CONTROLLER1

  lda #%00000001
  sta pad1

read_next:
  lda CONTROLLER1
  lsr
  rol pad1
  bcc read_next

  plp
  pla
  tax
  pla

  rts
.endproc

