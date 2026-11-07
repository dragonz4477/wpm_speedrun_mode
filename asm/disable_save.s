#inject(0x80065a20)

###
# Globals
###
.set g_disableSave, 0x80001500

###
#
# Code
#
###

lis r3, g_disableSave@ha
lbz r3, g_disableSave@l(r3)