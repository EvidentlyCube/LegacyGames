hspeed+=(rx-x)/100
if point_distance(x,y,rx,ry)<100{
rx=ix+random(300)-random(300)
ry=iy
part_particles_create(global.s,x,y,global.t1,choose(5,7,13))
}
if abs(hspeed)>5{hspeed-=sign(hspeed)}
if abs(vspeed)>5{vspeed-=sign(vspeed)}
instance_create(x,y,object7)
