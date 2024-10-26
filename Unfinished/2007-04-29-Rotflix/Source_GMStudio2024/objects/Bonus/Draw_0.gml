if a=0{draw_sprite(S_Bonus,0,x,y)
if place_meeting(x,y,Player){a=1}}
if a=1{
draw_sprite_ext(S_Bonus,0,x,y,1,1,0,c_white,b)
draw_sprite(S_Bonus,1,x,y)
b-=0.02+c
if b<=0{b=1;a=2}
}
if a=2{
draw_sprite(S_Bonus,b,x,y)
b+=0.5
if b=7{a=3;b=1+random(5)}
}
if a=3{
b-=0.05+c
draw_sprite_ext(S_Bonus,7,x,y,1,1,0,c_white,b)
if b<=0{instance_destroy()}
}
