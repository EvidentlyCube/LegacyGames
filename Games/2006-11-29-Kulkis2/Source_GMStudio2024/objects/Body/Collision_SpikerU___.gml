k=instance_create(x,y,BodyDie)
k.colour=colour
k=instance_create(x,y,EyesDie)
k.angle=dir
instance_destroy()
sound_play(Die)
