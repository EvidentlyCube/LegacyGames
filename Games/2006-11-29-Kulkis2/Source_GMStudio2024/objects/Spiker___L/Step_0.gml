if instance_exists(Body){if a=0{if Body.y<y+5 && Body.y>y-15 && x>Body.x{if !collision_line(x,y,Body.x,y,SolidWalls,true,true){speed=5;direction=180;a=1}}}}
if a=1{if place_meeting(x-5,y,SolidWalls){
a=instance_create(x,y,SmallExploder)
a.sprite_index=sprite_index
a.image_index=image_index
a.image_speed=0
instance_create(x,y,Explosion)
instance_destroy()}}
