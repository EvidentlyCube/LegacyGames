if (!surface_exists(global.surf_tiles)) {
	global.surf_tiles = surface_create(800, 600);
	buffer_set_surface(global.surf_tiles_buffer, global.surf_tiles, 0)
}

draw_surface(global.surf_tiles,0,0)

