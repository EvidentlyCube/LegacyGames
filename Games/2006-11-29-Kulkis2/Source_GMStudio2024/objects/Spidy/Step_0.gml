if behavior!=2{if behavior=0{
dirc+=random(0.1)-random(0.1)
if dirc>2{dirc=2}
if dirc<-2{dirc=-2}
ran=floor(random(1000))
if ran=1{dirn+=random(100)-random(100)}
}
if instance_exists(Body){if Body.x-x<30 && Body.x-x>-30 && Body.y-y<30 && Body.y-y>-30{behavior=1;timer=0;dirn=point_direction(x,y,Body.x,Body.y)+180}}
if behavior=1{
timer+=1
dirc=0
speed=nspeed+1
if timer>=100{speed=nspeed;behavior=0}
}
direction=dirn+dirc
}

if behavior=2{
timer+=1
}
if timer>=150{
alpha-=0.0075
}
if alpha<-0{instance_destroy()}
var __b__;
__b__ = action_if_variable(behavior, 2, 0);
if !__b__
{
{
action_bounce(1, 1);
dirn=direction
}
}
