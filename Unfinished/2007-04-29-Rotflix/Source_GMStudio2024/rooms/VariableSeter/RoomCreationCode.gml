global.turn=0
global.key_up=vk_numpad8
global.key_left=vk_numpad4
global.key_down=vk_numpad2
global.key_right=vk_numpad6
global.key_upright=vk_numpad9
global.key_upleft=vk_numpad7
global.key_downleft=vk_numpad1
global.key_downright=vk_numpad3
global.key_wait=vk_numpad5
instance_create(0,0,Main_objects_OtherObjects)

global.con_iy[0]=0;global.con_ix[0]=1;
global.con_iy[1]=1;global.con_ix[1]=0;
global.con_iy[2]=0;global.con_ix[2]=-1;
global.con_iy[3]=-1;global.con_ix[3]=0;
global.con_movx[0]=1;
global.con_movx[1]=1;
global.con_movx[2]=0;
global.con_movx[3]=-1;
global.con_movx[4]=-1;
global.con_movx[5]=-1;
global.con_movx[6]=0;
global.con_movx[7]=1;
global.con_movy[0]=0;
global.con_movy[1]=1;
global.con_movy[2]=1;
global.con_movy[3]=1;
global.con_movy[4]=0;
global.con_movy[5]=-1;
global.con_movy[6]=-1;
global.con_movy[7]=-1;


global.part_sys_a=part_system_create();
part_system_depth(global.part_sys_a,0)

global.part_type_a=part_type_create();
part_type_sprite(global.part_type_a,S_Enemyfive,0,0,0);
part_type_size(global.part_type_a,1,1,-0.06,0)
part_type_color1(global.part_type_a,make_color_rgb(255,250,20))
part_type_alpha3(global.part_type_a,1,0.1,0);
part_type_life(global.part_type_a,30,3);
global.part_type_b=part_type_create();
part_type_shape(global.part_type_b,pt_shape_ring);
part_type_size(global.part_type_b,0.1,0.2,0.01,0.01)
part_type_color1(global.part_type_b,make_color_rgb(255,250,20))
part_type_alpha2(global.part_type_b,1,0);
part_type_life(global.part_type_b,50,80);

global.surf_tiles=surface_create(room_width,room_height)
surface_set_target(global.surf_tiles)
draw_clear_alpha(make_color_rgb(1,0,0),0)
surface_reset_target()

room_goto(Level_000)