if instance_exists(Body){if a=0{x=floor(x/20)*20+10;
y=floor(y/20)*20+10;if Body.x<x+5 && Body.x>x-15 && y>Body.y{if !collision_line(x,y,x,Body.y,SolidWalls,true,true){speed=5;direction=90;a=1}}}
if a=0{if Body.x<x+5 && Body.x>x-15 && y<Body.y{if !collision_line(x,y,x,Body.y,SolidWalls,true,true){speed=5;direction=270;a=2}}}
if a=0{if Body.y<y+5 && Body.y>y-15 && x<Body.x{if !collision_line(x,y,Body.x,y,SolidWalls,true,true){speed=5;direction=0;a=3}}}
if a=0{if Body.y<y+5 && Body.y>y-15 && x>Body.x{if !collision_line(x,y,Body.x,y,SolidWalls,true,true){speed=5;direction=180;a=4}}}}
if a=3{if place_meeting(x+5,y,SolidWalls){speed=0;a=0}}
if a=4{if place_meeting(x-5,y,SolidWalls){speed=0;a=0}}
if a=1{if place_meeting(x,y-5,SolidWalls){speed=0;a=0}}
if a=2{if place_meeting(x,y+5,SolidWalls){speed=0;a=0}}

