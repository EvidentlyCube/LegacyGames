image_alpha-=0.05
image_angle+=hspeed
if x>room_width && hspeed>0{hspeed*=-1}
if x<0 && hspeed<0{hspeed*=-1}
if image_alpha<0{instance_destroy()}
