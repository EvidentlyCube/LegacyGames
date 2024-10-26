if wait>240{
if draw>0 && timer<400{draw-=0.01} else {timer=1}
if keyboard_check(vk_anykey) && timer<400 && timer>0{timer=400}

draw_set_alpha(draw)
draw_set_color(c_black)
draw_rectangle(0,0,800,600,0)
} else {wait+=1;
draw_set_color(c_black)
draw_rectangle(0,0,800,600,0)}


if (draw > 0.5) {
	can_exit=1
}