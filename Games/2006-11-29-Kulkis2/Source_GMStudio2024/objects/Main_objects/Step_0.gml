if !instance_exists(Body) 
	&& !instance_exists(Died)
{
	instance_create(room_width/2,room_height/2,Died)
}
if keyboard_check_pressed(vk_f2){
	room_restart()
}
