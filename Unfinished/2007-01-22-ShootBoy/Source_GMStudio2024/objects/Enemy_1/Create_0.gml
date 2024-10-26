hp=floor(random(5))+5+global.hpbonus
czo=0
xp=10
cutable=1
hit="repeat (1){IN_Flame(x,y,random(360))}"
dam=1
if place_meeting(x,y,Enemy_Wall){instance_destroy()}
