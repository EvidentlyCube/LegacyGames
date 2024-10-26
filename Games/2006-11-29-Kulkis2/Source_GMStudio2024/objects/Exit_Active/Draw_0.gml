if instance_exists(Body){if Body.x=x && Body.y=y && keyboard_check_pressed(vk_enter){global.levlo[1]=1;room_goto(LevelSelector)}}

if color>150{beniek-=0.5}
if color<150{beniek+=0.5}
if scale>1{beniekc-=0.001}
if scale<1{beniekc+=0.001}
color+=beniek
scale+=beniekc
// Angle Alghoritm
//angle=0 - Aktualny k�t nachylenia
//angspd=0 - Aktualna pr�dko�� razem z kierunkiem rotatowania
//angsmx=0 - Aktualny maxymalny speed rotatowania
//angdir=1 - Aktualny Kierunek rotatowania
//angmod=0 - Aktualna akcja // 0-Stop 1-rozp�dzanie 2-jazda 3-hamowanie
//angstp=0 - Ile jeszcze step�w b�dzie si� rot�o w danym kierunku
if angmod=0{
angsmx=floor(random(10))+5
angdir*=-1
angsmx*=angdir
angstp=floor(random(350))+5
angmod=1
}
if angmod=1{
if angsmx!=floor(angspd){
angspd+=0.2*angdir
} else {angmod=2}
}
if angmod=2{
angstp-=1
{if angstp=0{angmod=3}}
}
if angmod=3{
if 0!=floor(angspd){
angspd-=0.2*angdir
} else {angmod=0}
}
angle+=angspd
if angle>=360{angle-=359}
if angle<=0{angle+=359}
//draw_sprite(S_Exit,0,x,y)
//draw_sprite_ext(S_Exit,0,x,y,1,1,0,make_color_rgb(color,color,color),1)
//draw_set_color(c_white)
//draw_rectangle(x-10,y-10,x+9,y+9,true)
draw_sprite_ext(S_Exit,0,x,y,scale,scale,angle,c_white,0.8)
