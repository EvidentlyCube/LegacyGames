function showparta(argument0, argument1) {

	part_emitter_region(global.part_explosion_set,global.part_explodeA,argument0,argument0+20,argument1,argument1+20,ps_shape_line,ps_distr_linear)
	part_emitter_burst(global.part_explosion_set,global.part_explodeA,global.particleD,5)



}
