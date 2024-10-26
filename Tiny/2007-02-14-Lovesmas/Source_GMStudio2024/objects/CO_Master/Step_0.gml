spd+=0.002
timer+=spd
if timer>ran{
timer-=ran
ran=floor(random(2))
if ran=0{
instance_create(-30,random(room_width/2),CO_Heart)
ran=random(100)+10
}

if ran=1{
instance_create(830,random(room_width/2),CO_Heart)
ran=random(100)+10
}




}

if global.lv=0{
	show_message("Your score is: " + string(global.sc));
	global.sc=0;
	global.lv=100;
	room_restart()
}
