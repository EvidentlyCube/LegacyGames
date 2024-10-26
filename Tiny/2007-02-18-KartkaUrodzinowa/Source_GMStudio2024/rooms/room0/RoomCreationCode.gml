global.s=part_system_create()
part_system_depth(global.s,0)
global.t1=part_type_create()
part_type_shape(global.t1,pt_shape_star)
part_type_alpha2(global.t1,1,0)
part_type_color_rgb(global.t1,100,255,100,255,100,255)
part_type_speed(global.t1,1,15,0,0)
part_type_gravity(global.t1,0.5,270)
part_type_direction(global.t1,45,135,0,0)
part_type_orientation(global.t1,45,135,0,0,1)
part_type_size(global.t1,0.1,1,-0.01,0)
part_type_life(global.t1,60,60)

global.font=font_add_sprite(sprite6,ord("0"),0,0)
global.scr=0
global.tim=100
sound_play(sound1)