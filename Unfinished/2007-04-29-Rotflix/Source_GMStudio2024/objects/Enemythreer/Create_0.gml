var tile;
image_speed=0
tile=tile_layer_find(1100,x,y)
if tile_exists(tile){
dir=(floor((tile_get_left(tile)/20)+(tile_get_top(tile)/20)*4)/2)
tile_layer_delete_at(1100,x,y)
}

oldx=x
oldy=x
draw=0
image_index=0
dumd=0
