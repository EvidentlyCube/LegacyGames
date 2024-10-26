if global.pause=0{
a-=0.1
image_alpha=a
image_yscale=a
if place_meeting(x,y,Enemies){
with (Enemies){
if place_meeting(x,y,Shot_3){
IN_Flame(x,y,random(360))
hp-=Shot_3.pow
Player.xp+=xp
}
}
}
draw_set_blend_mode(bm_add)
draw_sprite_ext(S_Shot4,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_set_blend_mode(bm_normal)
if a<0{instance_destroy()}
}
