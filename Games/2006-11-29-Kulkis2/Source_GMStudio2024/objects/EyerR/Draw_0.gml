timer+=1
if timer=100{timer=0;dir-=1}
if dir=-1{dir=3}
if angle!=dir*90{angle-=5}
if angle<0{angle+=360}

if angle=dir*90 && dir=0 && instance_exists(Body){if Body.x>x && Body.y=y{for (val=0;!place_meeting(x+val*20,y,Master_Wall);val+=1){if place_meeting(x+val*20,y,Body){Body.die=1;ringe=1}}}}
if angle=dir*90 && dir=1 && instance_exists(Body){if Body.x=x && Body.y<y{for (val=0;!place_meeting(x,y-val*20,Master_Wall);val+=1){if place_meeting(x,y-val*20,Body){Body.die=1;ringe=1}}}}
if angle=dir*90 && dir=2 && instance_exists(Body){if Body.x<x && Body.y=y{for (val=0;!place_meeting(x-val*20,y,Master_Wall);val+=1){if place_meeting(x-val*20,y,Body){Body.die=1;ringe=1}}}}
if angle=dir*90 && dir=3 && instance_exists(Body){if Body.x=x && Body.y>y{for (val=0;!place_meeting(x,y+val*20,Master_Wall);val+=1){if place_meeting(x,y+val*20,Body){Body.die=1;ringe=1}}}}

draw_sprite_ext(S_Eyer,0,x,y,1,1,angle,c_white,1)



if ringe=1{
part_emitter_region(global.part_explosion_set,global.part_explodeA,x,x,y,y,ps_shape_line,ps_distr_linear)
part_emitter_burst(global.part_explosion_set,global.part_explodeA,global.particleA,1)
part_emitter_region(global.part_explosion_set,global.part_explodeA,Body.x,Body.x,Body.y,Body.y,ps_shape_line,ps_distr_linear)
part_emitter_burst(global.part_explosion_set,global.part_explodeA,global.particleA,1)
bx=Body.x
by=Body.y
ringe=0
liner=10}


if liner>0{
draw_set_color(c_black)
draw_set_alpha(liner/10)
draw_roundrect(x-2,y-2,bx+2,by+2,false)
draw_set_alpha(1)
liner-=1
}

