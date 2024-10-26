draw_set_alpha(1)
draw_sprite_ext(sprite_index,0,ix,iy,1,1,0,make_color_hsv(color,250,250),1)
color+=0.5

a+=pi/100
ix+=radtodeg(sin(a))/25
b-=0.1
iy-=b
if iy>300 && b<0{b=5}

if global.op_mus=0{duvu=11}

draw_set_color(c_white)
draw_set_font(global.font)
draw_set_halign(fa_center)

draw_text(405,450,string_hash_to_newline("CONGRATULATIONS!#You have succesfully managed to#get through all the 40 levels in LINX!#Want to play more levels?#Download them at: www.mauft.com#Want more games?#You will undoubtly find them at www.mauft.com!"))

if instance_exists(Faderiner){gugu=0}
//if gugu=37{
if SXMS2_MI_GetRow(5) mod 8=0{
if gugu=1{
__background_set( e__BG.HSpeed, 0, random(4)-random(4) )
__background_set( e__BG.VSpeed, 0, random(4)-random(4) )
if da=1{part_emitter_burst(ps,em,pt2,3)}
gugu=0
duvu+=1}
} else {gugu=1}
if duvu>10 && SXMS2_MI_GetRow(5) mod 8<4{
draw_text(405,10,string_hash_to_newline("Press Any Key"))
}
if duvu>10 && (keyboard_check(vk_anykey) or mouse_check_button(mb_any)) && da=1{
da-=0.01
part_emitter_destroy_all(ps)
}

if da<1{
da-=0.01
draw_set_alpha(1-da)
draw_set_color(c_black)
draw_rectangle(0,0,800,600,0)
}

if da<=0{
part_type_destroy(pt1)
part_type_destroy(pt2)
part_system_destroy(ps)
SXMS2_MC_StopAllSongs()
room_goto(TS)}
