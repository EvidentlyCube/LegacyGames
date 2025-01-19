if instance_exists(Body){if a=0{x=10+floor(x/20)*20
y=10+floor(y/20)*20;if Body.y<y+5 && Body.y>y-15 && x<Body.x{if !collision_line(x,y,Body.x,y,SolidWalls,true,true){speed=5;direction=0;a=1}}}
if a=0{if Body.y<y+5 && Body.y>y-15 && x>Body.x{if !collision_line(x,y,Body.x,y,SolidWalls,true,true){speed=5;direction=180;a=2}}}}
if a=1{if place_meeting(x+5,y,SolidWalls){speed=0;a=0}}
if a=2{if place_meeting(x-5,y,SolidWalls){speed=0;a=0}}


