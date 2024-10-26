if a>=0{
if ix!=mouse_x or iy!=mouse_y{
	a+=1+room_speed
} else {
	if a>0 {
		show_message("Your score is: " + string(a))
		game_restart()
	}
}
if collision_line(mouse_x,mouse_y,ix,iy,blum,1,1){with (blum){instance_destroy()}}
//window_mouse_set(room_width/2,room_height/2)
ix=mouse_x
iy=mouse_y
c+=1+tuper
if c>=15{
room_speed+=1
c=0
}
tuper+=tuper*0.001+0.001
score=room_speed
}


