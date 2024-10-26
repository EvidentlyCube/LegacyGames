if global.iic>0{
sound_play(silup)
with (global.ii[global.iic-1]){instance_destroy()}
global.iic-=1}
