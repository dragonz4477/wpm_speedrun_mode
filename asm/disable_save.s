#inject(0x80065a20)

###
# Globals
###
.set g_isSpeedRunMode, 0x80001500

###
#
# Code
#
###

# the inject address lets this flag also become a boolean of whether to abort saving
lis r3, g_isSpeedRunMode@ha
lbz r3, g_isSpeedRunMode@l(r3)
