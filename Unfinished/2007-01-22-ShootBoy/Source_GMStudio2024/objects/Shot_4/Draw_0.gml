if global.pause=0{
if keyboard_check(ord("Z")){
Player.stam3-=5
if Player.stam3<=0{instance_destroy()}
if place_meeting(x,y,Enemies){
with (Enemies){
if place_meeting(x,y,Shot_4){
IN_Flame(x,y,random(360))
hp-=Shot_4.pow
Player.xp+=xp
}
}
}
x=Player.x
y=Player.y
draw_set_blend_mode(bm_add)
draw_sprite_ext(S_Shot4,1,x,y,1,1+random(0.3)-random(0.3),0,c_white,0.3+random(0.5))
draw_set_blend_mode(bm_normal)
} else {instance_destroy()}
}
