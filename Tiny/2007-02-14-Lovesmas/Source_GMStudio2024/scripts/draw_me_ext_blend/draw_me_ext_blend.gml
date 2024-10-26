function draw_me_ext_blend(argument0) {
	draw_set_blend_mode(argument0)
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_set_blend_mode(bm_normal)



}
