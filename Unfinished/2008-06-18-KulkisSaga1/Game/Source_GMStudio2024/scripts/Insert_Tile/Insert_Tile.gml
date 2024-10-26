function Insert_Tile(argument0) {
	/*
	Drawing a tile in the wall texture in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Insert_Tile(id)
	id - tile id
	*/

	draw_background_part_ext(tile_get_background(argument0),tile_get_left(argument0),tile_get_top(argument0),tile_get_width(argument0),tile_get_height(argument0),tile_get_x(argument0),tile_get_y(argument0),1,1,c_white,draw_get_alpha())
	tile_delete(argument0)



}
