lol=instance_create(x,y,wall)
lol.sprite_index=sprite1

if czok>0{czok-=1} else {czok=floor(random(100)+10);ran=random(1)-random(1)}
if !place_meeting(x+10,y,right) && sign(ran)=1{x+=ran}
if x>2 && sign(ran)=-1{x+=ran}
