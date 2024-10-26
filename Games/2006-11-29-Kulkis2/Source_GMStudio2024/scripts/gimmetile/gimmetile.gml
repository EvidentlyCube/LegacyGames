function gimmetile(argument0) {
	tile_add(argument0,0,0,20,20,x,y,4)

	part_emitter_region(global.part_explosion_set,global.part_explodeA,x,x+20,y,y+20,ps_shape_line,ps_distr_linear)
	part_emitter_burst(global.part_explosion_set,global.part_explodeA,global.particleD,5)



}
