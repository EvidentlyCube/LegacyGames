draw_sprite_ext(S_Pixel,0,x,y,1,1,0,make_color_rgb(kolo,kolo,0),kolo/255)
if global.pause=0{
speed=0.2
kolo-=30-random(40)
if kolo<=10{instance_destroy()}
} else {speed=0}
