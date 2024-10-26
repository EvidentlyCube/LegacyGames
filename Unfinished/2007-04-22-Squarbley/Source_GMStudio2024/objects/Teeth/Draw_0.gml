ba=radtodeg(sin(a))-50+image_angle
bb=-radtodeg(sin(a))+60+image_angle
if mode=0{
a+=0.2
c=point_direction(x,y,Player.x,Player.y)
image_angle=c
if c>225 && c<315{
if !collision_line(x,y,Player.x,Player.y,Wall,0,1){
mode=1
xvec=Player.x-x
yvec=Player.y-y
}
}}


if mode=1{
a+=0.2
if ba-bb<-200{
a=4.79
mode=2
divid=max(abs(xvec),abs(yvec))
xvec/=divid
yvec/=divid
}
}

if mode=2{
repeat(10){
x+=xvec
y+=yvec
if place_meeting(x,y,Player){mode=3;global.move=1;break}
if place_meeting(x,y,Wall){mode=3;break}
}
}

if mode>2 && mode<100{
if a<7.5{a+=1.25/4}
mode+=1
}

if mode=100{
y-=yvec
x-=xvec
if x>ix-1 && x<ix+1 && y>iy-1 && y<iy+1{x=ix;y=iy;mode=0}
}

z=0
image_blend=c_black
image_alpha=0
if place_meeting(x,y,Look){
if !collision_line(x,y,Player.x,Player.y,Wall,1,1){z=1}
}
if z=1{
var koks;
koks=255-255/((200/max(0.1,point_distance(x,y,Player.x,Player.y)))*1.3)
image_blend=make_color_rgb(koks,koks,koks)
image_alpha=1
}

draw_sprite_ext(S_Teeth,1,x,y,1,1,bb,image_blend,1)
draw_sprite_ext(S_Teeth,0,x,y,1,1,ba,image_blend,1)

