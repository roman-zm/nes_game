.segment "VECTORS"
  .addr nmi_handler, reset_handler, irq_handler

.segment "CODE"
.proc irq_handler
  rti
.endproc

; calls every frame
.proc nmi_handler
  php
  pha
  tya
  pha
  txa
  pha

  lda nmi_ready
  bne nmi_start

  inc lag_count
  jmp return

nmi_start:
  ; set OAM address to 0
  lda #$0
  sta OAMADDR

  ; copy 256 bytes from #$100 * #$2 to OAM
  lda #$2
  sta OAMDMA

  jsr toggle_panel

  inc frame_counter

  lda 0
  sta nmi_ready

return:

  pla
  tax
  pla
  tay
  pla
  plp

  rti
.endproc

.proc update_scroll

  ; scroll every 2 frames
  lda frame_counter
  and #%00000001
  beq return

  lda scroll
  cmp #$0 ; did we scroll to the end
  bne set_scroll_positions

  ; if we are scroll to the end
  lda ppuctrl_settings
  sta PPUCTRL
  lda #240
  sta scroll

  ; else
set_scroll_positions:
  dec scroll

return:
  rts

.endproc