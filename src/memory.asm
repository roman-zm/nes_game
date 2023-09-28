.segment "ZEROPAGE"
lag_count: .res 1
nmi_ready: .res 1  ; 0 - not ready, 1 - ready

player_x: .res 1
player_y: .res 1
scroll: .res 1
frame_counter: .res 1
ppuctrl_settings: .res 1
pad1: .res 1

projectiles: .res .sizeof(Projectile) * 8
projectile_cooldown: .res 1

meteors: .res .sizeof(Meteor) * 4
meteors_cooldown: .res 1
energy_banks: .res .sizeof(EnergyBank) * 2
energy_cooldown: .res 1

seed: .res 2       ; initialize 16-bit seed to any value except 0
tmp: .res 1

panel_nt: .res 1

.segment "OAM"
ZERO_TILE: .res .sizeof(Sprite)
PLAYER_ADDR: .res .sizeof(Sprite) * 4
PRJCTL_ADDR: .res .sizeof(Sprite) * PRJCTL_COUNT ; $0210
METEORS_ADDR: .res .sizeof(Sprite) * METEORS_COUNT ; $0220
ENERGY_BANK_ADDR: .res .sizeof(Sprite) * ENERGY_BANK_COUNT