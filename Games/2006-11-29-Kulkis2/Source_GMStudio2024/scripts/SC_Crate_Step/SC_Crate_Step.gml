function SC_Crate_Step() {
	if place_meeting(x,y,Body){if kofo=0{sonpla(Shuru)}kofo=1
	if Body.dir=0{x+=2}
	if Body.dir=90{y-=2}
	if Body.dir=180{x-=2}
	if Body.dir=270{y+=2}
	if Body.move=0{kofo=0}
	} else {kofo=0}/*
	if instance_exists(Pit){
	lol=instance_nearest(x-10,y-10,Pit)
	if x=lol.x+10 && y=lol.y+10{with (lol) {instance_destroy()}; instance_destroy(); x-=10;y-=10;gimmetile(lolo); sonpla(1)}}
	*/
	if kofo=0{
	lol=instance_position(x-10,y-10,Pit)
	if lol>1000{with (lol) {instance_destroy()}; instance_destroy(); x-=10;y-=10;gimmetile(lolo); sonpla(1)}}



}
