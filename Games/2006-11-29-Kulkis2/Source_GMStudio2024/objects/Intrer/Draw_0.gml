var isFast = 0;

if keyboard_check(vk_anykey) or mouse_check_button(mb_left) {
	isFast = 1
}


if draw > 0 && timer < 400 {
	draw -= 0.05
	if (isFast) { draw -= 0.05; }
} else {
	timer += 5
	if (isFast) { timer += 50; }
}
if timer > 400 {
	draw += 0.04
	if (isFast) { draw += 0.04; }
}
if draw >= 1 {
	room_goto_next()
}
if isFast && timer < 400 && timer > 0 {
	timer = 400
}

draw_set_alpha(draw)
draw_set_color(c_black)
draw_rectangle(0,0,800,600,0)
