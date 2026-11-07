#inject(0x80066304)

###
# Constants
###
.set KPAD_BTN_DLEFT,  (1 << 0)
.set KPAD_BTN_DRIGHT, (1 << 1)
.set KPAD_BTN_DDOWN,  (1 << 2)
.set KPAD_BTN_DUP,    (1 << 3)
.set KPAD_BTN_PLUS,   (1 << 4)
.set KPAD_BTN_MINUS,  (1 << 12)
.set KPAD_BTN_1,      (1 << 9)
.set KPAD_BTN_2,      (1 << 8)
.set KPAD_BTN_A,      (1 << 11)
.set KPAD_BTN_B,      (1 << 10)
.set KPAD_BTN_HOME,   (1 << 15)

###
# Structure offsets
###
.set KPADStatus_hold, 0x00
.set Controller_mKPADStatus, 0xA0
.set Controller_mKPADReadLen, 0xFA0

###
# Globals
###
.set g_ppControllers, 0x80265304
.set g_disableSave,   0x80001500  

###
#
# Code
#
###

# Register aliases
.set tmp,         31
.set pSaveData,   30
.set pController, 29
.set held,        28

# Reset button combo
.set RESET_COMBO, (KPAD_BTN_1 | KPAD_BTN_2)

__prologue:
  __push_stack r3 0x100 true

  # load controller array
  lis tmp, g_ppControllers@ha
  lwz tmp, g_ppControllers@l(tmp)
  # load P1 controller
  lwz pController, 0x0(tmp)

  # check for button combo
  # held = (held & RESET_COMBO) ? 1 : 0
  lwz held, Controller_mKPADStatus+KPADStatus_hold(pController)
  andi. tmp, held, RESET_COMBO
  addi tmp, tmp, -RESET_COMBO
  cntlzw tmp, tmp
  srwi. held, tmp, 5 # 2^5 == 32
  
  # modify save file if combo held
  beq __epilogue
  li r0, 0

  # Cone Zone
  __set r31, 0x1BB35
  stbx r0, r31, r30

  # Veggie Guardin'
  __set r31, 0x1BB42
  stbx r0, r31, r30

  __set r31, 0x1B0F3
  stbx r0, r31, r30

  # Skip Skimmer
  __set r31, 0x1BB41
  stbx r0, r31, r30

  __set r31, 0x1B0EF
  stbx r0, r31, r30

  # Pose Mii Plus
  __set r31, 0x1BB3D
  stbx r0, r31, r30

  # Trigger Twist
  __set r31, 0x1BB43
  stbx r0, r31, r30

  __set r31, 0x1B0F7
  stbx r0, r31, r30

  # Jump Park
  __set r31, 0x1BB36
  stbx r0, r31, r30

  __set r31, 0x1B0C3
  stbx r0, r31, r30
  __set r31, 0x1B107
  stbx r0, r31, r30

  # Teeter Targets
  __set r31, 0x1BB3F
  stbx r0, r31, r30

  __set r31, 0x2B
  stbx r0, r31, r30
  __set r31, 0x3B
  stbx r0, r31, r30
  __set r31, 0x1B0E4
  stbx r0, r31, r30
  __set r31, 0x1B0E5
  stbx r0, r31, r30
  __set r31, 0x1B0E6
  stbx r0, r31, r30
  __set r31, 0x1B0E7
  stbx r0, r31, r30
  __set r31, 0x1B128
  stbx r0, r31, r30
  __set r31, 0x1B129
  stbx r0, r31, r30
  __set r31, 0x1B12A
  stbx r0, r31, r30
  __set r31, 0x1B12B
  stbx r0, r31, r30

  # Spooky Search
  __set r31, 0x1BB34
  stbx r0, r31, r30

  __set r31, 0x1B0BB
  stbx r0, r31, r30

  # Wind Runner
  __set r31, 0x1BB3E
  stbx r0, r31, r30

  __set r31, 0x1B0E3
  stbx r0, r31, r30
  __set r31, 0x1B127
  stbx r0, r31, r30

  # Treasure Twirl
  __set r31, 0x1BB3A
  stbx r0, r31, r30

  __set r31, 0x1B0D3
  stbx r0, r31, r30
  __set r31, 0x1B117
  stbx r0, r31, r30

  # Flutter Fly
  __set r31, 0x1BB3C
  stbx r0, r31, r30

  __set r31, 0x1B0DB
  stbx r0, r31, r30

  # Star Shuttle
  __set r31, 0x1BB37
  stbx r0, r31, r30

  __set r31, 0x1B0C4
  stbx r0, r31, r30
  __set r31, 0x1B0C5
  stbx r0, r31, r30
  __set r31, 0x1B0C6
  stbx r0, r31, r30
  __set r31, 0x1B0C7
  stbx r0, r31, r30
  __set r31, 0x1B108
  stbx r0, r31, r30
  __set r31, 0x1B109
  stbx r0, r31, r30
  __set r31, 0x1B10A
  stbx r0, r31, r30
  __set r31, 0x1B10B
  stbx r0, r31, r30

__epilogue:
  # signal to save disable code
  lis tmp, g_disableSave@ha
  stb held, g_disableSave@l(tmp)

  __pop_stack r3 0x100 true
  # return 0 (save file is OK)
  li r3, 0