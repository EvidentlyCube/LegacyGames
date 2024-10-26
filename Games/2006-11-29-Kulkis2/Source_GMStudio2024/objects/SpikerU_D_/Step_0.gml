if instance_exists(Body){if a=0{x=10+floor(x/20)*20
y=10+floor(y/20)*20;if Body.x<x+5 && Body.x>x-15 && y>Body.y{if !collision_line(x,y,x,Body.y,SolidWalls,true,true){speed=5;direction=90;a=1}}}
if a=0{if Body.x<x+5 && Body.x>x-15 && y<Body.y{if !collision_line(x,y,x,Body.y,SolidWalls,true,true){speed=5;direction=270;a=2}}}}
if a=1{if place_meeting(x,y-5,SolidWalls){speed=0;a=0}}
if a=2{if place_meeting(x,y+5,SolidWalls){speed=0;a=0}}

