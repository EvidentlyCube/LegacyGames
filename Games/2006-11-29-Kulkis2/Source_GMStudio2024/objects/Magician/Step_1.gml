
//Tiles Hunting
//Sprawdza po kolei ka�de pole w poszukiwaniu tiles�w grupy pierwszej-pi�tej (depth=1.000.005-1.000.000)

if (!surface_exists(global.surf_tiles)) {
	global.surf_tiles = surface_create(800,600);
}

var ix,iy,dypth,ide;
var layers = layer_get_all()
surface_set_target(global.surf_tiles)
draw_clear_alpha(c_black, 0);
for (var i = 0; i < array_length(layers); i++) {
	var dypth = layers[i];
	ix=0
	iy=0
	for (ix=0; iy < 30; ix+=1){
		if ix>=40{
			ix=0;
			iy+=1
			}
		ide=tile_layer_find(dypth,ix*20,iy*20)
		if tile_exists(ide){
			draw_background_part(
				tile_get_background(ide),
				tile_get_left(ide),
				tile_get_top(ide),
				tile_get_width(ide),
				tile_get_height(ide),
				ix*20,
				iy*20
			)
			tile_delete(ide)
		}
	}
}
surface_reset_target()

//Walls Hunting
//Ka�e wszytskim murkow wydraweowa� si� na surface
var ix,iy;
ix=0
iy=0
surface_set_target(global.surf_walls)
draw_clear_alpha(c_black, 0);

with (WallA){ SC_Walls_Create_A(WallA) }
with (WallB){SC_Walls_Create_A(WallB)}
with (WallC){SC_Walls_Create_A(WallC)}
with (WallD_A){SC_Walls_Create_B(WallD_A)}
with (WallD_B){SC_Walls_Create_B(WallD_B)}
with (WallD_C){SC_Walls_Create_B(WallD_C)}
with (WallD_D){SC_Walls_Create_B(WallD_D)}
with (WallA){draw_sprite(sprite_index,image_index,x,y);}
with (WallB){draw_sprite(sprite_index,image_index,x,y);}
with (WallC){draw_sprite(sprite_index,image_index,x,y);}
with (WallD_A){draw_sprite(sprite_index,image_index,x,y);}
with (WallD_B){draw_sprite(sprite_index,image_index,x,y);}
with (WallD_C){draw_sprite(sprite_index,image_index,x,y);}
with (WallD_D){draw_sprite(sprite_index,image_index,x,y);}
with (WallA){instance_destroy()}
with (WallB){instance_destroy()}
with (WallC){instance_destroy()}
with (WallD_A){instance_destroy()}
with (WallD_B){instance_destroy()}
with (WallD_C){instance_destroy()}
with (WallD_D){instance_destroy()}

draw_set_color(c_black);
draw_set_alpha(1);
draw_point(0, 599)
draw_point(0, 600)
draw_set_alpha(1);
draw_set_color(c_white);
surface_reset_target()

//Setowanie Master Wall'a

global.surf_sprite=sprite_create_from_surface(
	global.surf_walls,
	0,0,
	800,600,true,true,0,0)
Master_Wall.sprite_index=global.surf_sprite

instance_destroy()
