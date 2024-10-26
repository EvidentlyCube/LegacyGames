if instance_exists(Body){if a=0{if Body.x<x+5 && Body.x>x-15 && y>Body.y{if !collision_line(x,y,x,Body.y,SolidWalls,true,true){speed=5;direction=90;a=1}}}}
if a=1{if place_meeting(x,y-5,SolidWalls){

a=instance_create(x,y,SmallExploder)
a.sprite_index=sprite_index
a.image_index=image_index
a.image_speed=0
instance_create(x,y,Explosion)
instance_destroy()}}
