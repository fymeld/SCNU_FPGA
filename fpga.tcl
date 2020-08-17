#Setup.tcl 
# Setup pin setting for EP2C5_ board 
#未使用的IO引脚
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED" 
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF 
#时钟引脚
set_location_assignment PIN_23 -to clk
#led灯引脚
set_location_assignment PIN_51 -to leds[7]
set_location_assignment PIN_49 -to leds[6]
set_location_assignment PIN_44 -to leds[5]
set_location_assignment PIN_42 -to leds[4]
set_location_assignment PIN_38 -to leds[3]
set_location_assignment PIN_33 -to leds[2]
set_location_assignment PIN_31 -to leds[1]
set_location_assignment PIN_28 -to leds[0]

#按键引脚
set_location_assignment PIN_30 -to rst_n
set_location_assignment PIN_50 -to keys[6]
set_location_assignment PIN_46 -to keys[5]
set_location_assignment PIN_43 -to keys[4]
set_location_assignment PIN_39 -to keys[3]
set_location_assignment PIN_34 -to keys[2]
set_location_assignment PIN_32 -to keys[1]
set_location_assignment PIN_52 -to keys[0]



set_location_assignment PIN_144 -to seg_leds[0]
set_location_assignment PIN_143 -to seg_leds[1]
set_location_assignment PIN_142 -to seg_leds[2]
set_location_assignment PIN_141 -to seg_leds[3]
set_location_assignment PIN_138 -to seg_leds[4]
set_location_assignment PIN_137 -to seg_leds[5]
set_location_assignment PIN_136 -to seg_leds[6]
set_location_assignment PIN_135 -to seg_leds[7]

set_location_assignment PIN_133 -to 	seg_nCS[5]
set_location_assignment PIN_132 -to 	seg_nCS[4]
set_location_assignment PIN_129 -to	seg_nCS[3]
set_location_assignment PIN_3 -to 	seg_nCS[2]
set_location_assignment PIN_2 -to 	seg_nCS[1]
set_location_assignment PIN_1 -to 	seg_nCS[0]