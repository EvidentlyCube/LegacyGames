function Xplode(argument0, argument1) {
	effect_create_above(ef_explosion,argument0,argument1,0.5,c_red)
	effect_create_above(ef_explosion,argument0,argument1,0.2,c_yellow)
	sound_play(bums)
	global.kill+=1



}
