var tile;
image_speed=0
sprite_index=S_Arrows
tile=tile_layer_find(1100,x,y)
if tile_exists(tile){
image_index=(tile_get_left(tile)/20)+(tile_get_top(tile)/20)*4
tile_layer_delete_at(1100,x,y)
}

