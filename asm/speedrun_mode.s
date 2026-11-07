#inject(0x80066304)

###
# Constants
###
.set KPAD_BTN_1,      (1 << 9)
.set KPAD_BTN_2,      (1 << 8)
.set SECTION_3_OFFSET, 0x1B060

###
# Structure offsets
###
.set Controller_mKPADStatus, 0xA0
.set KPADStatus_hold,        0x00

###
# Globals
###
.set g_isSpeedRunMode, 0x80001500  
.set g_ppControllers,  0x80265304

###
#
# Code
#
###

# Register aliases
.set tmp,           31
.set pSaveHeader,   30
.set pSaveSection3, 29
.set pController,   28
.set isToggle,      27
.set isSpeedRun,    26

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
  # (held_buttons & RESET_COMBO) == RESET_COMBO ? 1 : 0
  lwz    tmp, Controller_mKPADStatus + KPADStatus_hold(pController)
  andi.  tmp, tmp, RESET_COMBO # clear non reset combo bits
  subi   tmp, tmp, RESET_COMBO # tmp will be zero when the exact buttons are held
  cntlzw tmp, tmp              # will be 32 when tmp is zero
  srwi.  isToggle, tmp, 5      # 2^5 == 32, isToggle becomes a boolean
  
  # keep the current mode if the button combo is not held
  beq+ __apply_speedrun_mode_flag

  # toggle the speedrun mode flag
  lis    tmp, g_isSpeedRunMode@ha
  lbz    isSpeedRun, g_isSpeedRunMode@l(tmp)
  cntlzw isSpeedRun, isSpeedRun    # will be 32 when isSpeedRun == false
  srwi.  isSpeedRun, isSpeedRun, 5 # will be 1 when isSpeedRun == false (inverts the flag)
  stb    isSpeedRun, g_isSpeedRunMode@l(tmp)

__apply_speedrun_mode_flag:
  # skip the mod code if not in speedrun mode
  lis    tmp, g_isSpeedRunMode@ha
  lbz    isSpeedRun, g_isSpeedRunMode@l(tmp)
  cmplwi isSpeedRun, 0
  beq+   __epilogue

  # most values are in section #3 of the save file.
  # make a pointer to section #3 to reduce the size of the writes that follow.
  __set tmp, SECTION_3_OFFSET
  add pSaveSection3, pSaveHeader, tmp

  li r0, 0

  # Cone Zone
  stb r0, (0x1BB35-SECTION_3_OFFSET)(pSaveSection3)

  # Veggie Guardin'
  stb r0, (0x1BB42-SECTION_3_OFFSET)(pSaveSection3)
  stb r0, (0x1B0F3-SECTION_3_OFFSET)(pSaveSection3)

  # Skip Skimmer
  stb r0, (0x1BB41-SECTION_3_OFFSET)(pSaveSection3)
  stb r0, (0x1B0EF-SECTION_3_OFFSET)(pSaveSection3)

  # Pose Mii Plus
  stb r0, (0x1BB3D-SECTION_3_OFFSET)(pSaveSection3)

  # Trigger Twist
  stb r0, (0x1BB43-SECTION_3_OFFSET)(pSaveSection3)
  stb r0, (0x1B0F7-SECTION_3_OFFSET)(pSaveSection3)

  # Jump Park
  stb r0, (0x1BB36-SECTION_3_OFFSET)(pSaveSection3)
  stb r0, (0x1B0C3-SECTION_3_OFFSET)(pSaveSection3)
  stb r0, (0x1B107-SECTION_3_OFFSET)(pSaveSection3)

  # Teeter Targets
  stb r0, (0x1BB3F-SECTION_3_OFFSET)(pSaveSection3)
  stb r0, 0x2B(pSaveHeader)
  stb r0, 0x3B(pSaveHeader)
  stw r0, (0x1B0E4-SECTION_3_OFFSET)(pSaveSection3) # 0x1B0E4 - 0x1B0E7
  stw r0, (0x1B128-SECTION_3_OFFSET)(pSaveSection3) # 0x1B128 - 0x1B12B

  # Spooky Search
  stb r0, (0x1BB34-SECTION_3_OFFSET)(pSaveSection3)
  stb r0, (0x1B0BB-SECTION_3_OFFSET)(pSaveSection3)

  # Wind Runner
  stb r0, (0x1BB3E-SECTION_3_OFFSET)(pSaveSection3)
  stb r0, (0x1B0E3-SECTION_3_OFFSET)(pSaveSection3)
  stb r0, (0x1B127-SECTION_3_OFFSET)(pSaveSection3)

  # Treasure Twirl
  stb r0, (0x1BB3A-SECTION_3_OFFSET)(pSaveSection3)
  stb r0, (0x1B0D3-SECTION_3_OFFSET)(pSaveSection3)
  stb r0, (0x1B117-SECTION_3_OFFSET)(pSaveSection3)

  # Flutter Fly
  stb r0, (0x1BB3C-SECTION_3_OFFSET)(pSaveSection3)
  stb r0, (0x1B0DB-SECTION_3_OFFSET)(pSaveSection3)

  # Star Shuttle
  stb r0, (0x1BB37-SECTION_3_OFFSET)(pSaveSection3)
  stw r0, (0x1B0C4-SECTION_3_OFFSET)(pSaveSection3) # 0x1B0C4-0x1B0C7
  stw r0, (0x1B108-SECTION_3_OFFSET)(pSaveSection3) # 0x1B108-0x1B10B

__epilogue:
  __pop_stack r3 0x100 true

  # return 0 (save file is OK)
  li r3, 0
