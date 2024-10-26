var tile;
image_speed=0
tile=tile_layer_find(1100,x,y)
if tile_exists(tile){
image_index=(floor((tile_get_left(tile)/20)+(tile_get_top(tile)/20)*4))
tile_layer_delete_at(1100,x,y)
}

movx=0
movy=0
switch (image_index){
case(0):movx=1;                 dir=0;der=4;break;
case(1):movx=1;     movy=1;     dir=1;der=4;break;
case(2):movy=1;                 dir=2;der=4;break;
case(3):movx=-1;    movy=1;     dir=3;der=4;break;
case(4):movx=-1;                dir=4;der=-4;break;
case(5):movx=-1;    movy=-1;    dir=5;der=-4;break;
case(6):movy=-1;                dir=6;der=-4;break;
case(7):movx=1;     movy=-1;    dir=7;der=-4;break;
}
drawa=0
drawb=0
oldx=x
oldy=y
ani=0
