a=0
//if image_alpha>0{image_alpha=0.1}
image_blend=c_black
image_alpha=0
if place_meeting(x,y,Look){
if !collision_line(x+(min(9,max(-9,Player.x-x))),y+(min(9,max(-9,Player.y-y))),Player.x,Player.y,Wall,1,1){a=1}
}
if a=1{
//image_alpha=1-1/(200/point_distance(x,y,Player.x,Player.y))
var koks;
koks=255-255/((200/point_distance(x,y,Player.x,Player.y))*1.3)
image_blend=make_color_rgb(koks,koks,koks)
image_alpha=1
}
