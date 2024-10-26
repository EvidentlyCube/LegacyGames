hp=floor(random(10))+5+global.hpbonus
czo=0
xp=20
cutable=1
hit="repeat (1){IN_Flame(x,y,random(360))}"
image_speed=0.3
dam=4
if place_meeting(x,y,Enemy_Wall){instance_destroy()}
bond=1+random(0.7)-random(0.7)
czum=(random(0.1)+0.05)*choose(1,-1)
