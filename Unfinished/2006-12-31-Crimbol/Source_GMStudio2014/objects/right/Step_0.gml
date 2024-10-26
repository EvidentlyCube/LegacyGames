lol=instance_create(x,y,wall)
lol.sprite_index=sprite2

if czok>0{czok-=1} else {czok=floor(random(100)+10);ran=random(1)-random(1)}
if !place_meeting(x-10,y,left) && sign(ran)=-1{x+=ran}
if x<48 && sign(ran)=1{x+=ran}
