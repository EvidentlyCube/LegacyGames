vspeed+=(ry-y)/100
if point_distance(x,y,rx,ry)<100{
rx=ix
ry=iy+random(300)-random(300)
part_particles_create(global.s,x,y,global.t1,choose(5,7,13))
}
if abs(hspeed)>5{hspeed-=sign(hspeed)}
if abs(vspeed)>5{vspeed-=sign(vspeed)}

instance_create(x,y,object7)
