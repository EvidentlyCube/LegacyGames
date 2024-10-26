if instance_exists(Body){if Body.x=x+10 && Body.y=y+10{
k=instance_create(x+10,y+10,BodyDie)
k.colour=Body.colour
k=instance_create(x+10,y+10,EyesDie)
k.angle=Body.dir
with (Body)instance_destroy()}}
