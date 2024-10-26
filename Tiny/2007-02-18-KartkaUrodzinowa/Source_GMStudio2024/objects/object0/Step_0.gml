x+=(rx-x)/4
y+=(ry-y)/4
if point_distance(x,y,rx,ry)<1{
rx=ix+random(80)-random(80)
ry=iy+random(80)-random(80)

}
if global.tim=0 && !sound_isplaying(sound1){game_end()}
if collision_point(mouse_x,mouse_y,object0,1,0) && global.tim>0{
global.scr+=50/point_distance(mouse_x,mouse_y,(100002).x,(100002).y)
global.scr+=50/point_distance(mouse_x,mouse_y,(100003).x,(100003).y)
global.scr+=50/point_distance(mouse_x,mouse_y,(100006).x,(100006).y)
global.scr+=50/point_distance(mouse_x,mouse_y,(100008).x,(100008).y)
global.scr+=50/point_distance(mouse_x,mouse_y,(100011).x,(100011).y)
global.scr+=50/point_distance(mouse_x,mouse_y,(100010).x,(100010).y)
if collision_point(mouse_x,mouse_y,object1,1,1){global.scr-=50}
if global.scr<0{global.scr=0}
}

