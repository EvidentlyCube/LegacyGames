
tile=tile_layer_find(1000000,x,y)
while tile_exists(tile) {
	type = tile_get_background(tile)
	if type = B_WallA { type = WallA } 
	else if type = B_WallB { type = WallB } 
	else if type = B_WallC { type = WallC } 
	else if type = B_WallD_A { type = WallD_A } 
	else if type = B_WallD_B { type = WallD_B } 
	else if type = B_WallD_C { type = WallD_C } 
	else if type = B_WallD_D { type = WallD_D } 
	else if type = B_WallE { type = WallE } 
	else { instance_destroy() }
	
	left = tile_get_left(tile)
	top = tile_get_top(tile)
	image = (left / 20) + ((top / 20) * 4)
	create = instance_create(x, y, type)
	create.image_speed = 0
	create.image_index=image
	create.wall_magic_stop = 1
	tile_delete(tile)
	tile = tile_layer_find(1000000,x,y)
}
instance_destroy()
