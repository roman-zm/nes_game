.segment "CODE"
.proc reset_handler
  sei        ; ignore IRQs
  cld        ; disable decimal mode

  ldx #$40
  stx $4017  ; disable APU frame IRQ
  ldx #$ff
  txs        ; Set up stack

  inx          ; now X = 0
  stx PPUCTRL  ; disable NMI
  stx PPUMASK  ; disable rendering
  stx $4010    ; disable DMC IRQs

  ; Optional (omitted):
  ; Set up mapper and jmp to further init code here.

  ; The vblank flag is in an unknown state after reset,
  ; so it is cleared here to make sure that @vblankwait1
  ; does not exit immediately.
  bit $2002

  ; First of two waits for vertical blank to make sure that the
  ; PPU has stabilized
@vblankwait1:
  bit $2002
  bpl @vblankwait1

  ; We now have about 30,000 cycles to burn before the PPU stabilizes.
  ; One thing we can do with this time is put RAM in a known state.
  ; Here we fill it with $00, which matches what (say) a C compiler
  ; expects for BSS.  Conveniently, X is still 0.
  txa
@clrmem:
  sta $0000, x
  sta $0100, x
  sta $0200, x
  sta $0300, x
  sta $0400, x
  sta $0500, x
  sta $0600, x
  sta $0700, x
  inx
  bne @clrmem

  lda #$2
  sta energy_cooldown

  ; set seed
  lda #$3f
  sta seed
  sta seed + 1

  lda #$80
  sta player_x
  lda #$a0
  sta player_y

  ; Other things you can do between vblank waits are set up audio
  ; or set up other mapper registers.

@vblankwait2:
  bit $2002
  bpl @vblankwait2

  jmp main
.endproc

