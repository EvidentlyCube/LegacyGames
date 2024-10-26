if vspeed!=0{vspeed/=1.2}
hspeed+=0.4
if x>1024{instance_destroy()}
if y<125{if vspeed<0{vspeed*=-1}}
if y>639{if vspeed>0{vspeed*=-1}}
