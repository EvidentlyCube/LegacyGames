if floor(random(1000))=11{hspeed*=-1;vspeed*=-1}

hspeed+=(rx-x)/100
vspeed+=(ry-y)/100
if point_distance(x,y,rx,ry)<100{
rx=ix+random(300)-random(300)
ry=iy+random(300)-random(300)
part_particles_create(global.s,x,y,global.t1,choose(5,7,13))
}
if abs(hspeed)>20{hspeed/=2}
if abs(vspeed)>20{vspeed/=2}

instance_create(x,y,object6)

