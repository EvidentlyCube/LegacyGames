global.fingo=0
global.list=ds_list_create()
global.grid=ds_grid_create(20,19)
global.iic=0
global.ii[0]=0
global.level=0
global.click=0
global.maxclick=0
global.walls=1
global.togs=1
global.yus=0
global.wid=8
global.hei=10
global.font=font_add_sprite(s_font,ord("0"),1,3)
draw_set_font(global.font)
draw_set_color(c_white)
/* Particle For Twist I Creator */

global.pi_s=part_system_create()
global.pi_ti=part_type_create()
part_type_shape(global.pi_ti,pt_shape_ring)
part_type_size(global.pi_ti,0.3,0.3,0.01,0)
part_type_alpha2(global.pi_ti,0.5,0)
part_type_color2(global.pi_ti,make_color_rgb(255,255,128),c_white)
part_type_life(global.pi_ti,60,60)

room_goto_next()