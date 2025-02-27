
if (!surface_exists(global.surf_shadow)) {
	global.surf_shadow = surface_create(800,600);
}
if (!surface_exists(global.surf_tiles)) {
	global.surf_tiles = surface_create(800,600);
}
if (!surface_exists(global.surf_walls)) {
	global.surf_walls = surface_create(800,600);
}

sprite_delete(global.surf_sprite)
surface_set_target(global.surf_shadow)
draw_clear_alpha(make_color_rgb(1,0,0),0)
surface_reset_target()
surface_set_target(global.surf_tiles)
draw_clear_alpha(make_color_rgb(1,0,0),0)
surface_reset_target()
surface_set_target(global.surf_walls)
draw_clear_alpha(make_color_rgb(1,0,0),0)
surface_reset_target()
