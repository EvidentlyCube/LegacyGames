ran = floor(random(200))
if ran = 1{
	ran = 0.2
} else {
	ran = 0
}
draw_sprite_ext(sprite137, 0, 0, 480, 1, 1, 0, c_white, 0.3+ran+(floor(random(4))/100))
ran = floor(random(200))
if ran = 1 {
	ran = 0.2
} else {
	ran = 0
}
draw_sprite_ext(sprite138, 0, 450, 220, 1, 1, 0, c_white, 0.8+ran+(floor(random(4))/100))
if draw > 0 && timer = 0 {
	draw -= 0.05
}
if draw != 1 {
	draw_set_alpha(draw)
	draw_set_color(c_black)
	draw_rectangle(0, 0, 800, 600, 0)
	draw_set_alpha(1 - draw)
}

var isFast = 0;

if keyboard_check(vk_anykey) or mouse_check_button(mb_left) {
	b += 40;
}

if a < 4 && b >= 300{
	a += 1;
	b = 0
}
if a = 0{
	b+= 10;
	draw_sprite(S_Menub, 0, b, 301)
}
if a = 1{
	b+= 10;
	draw_sprite(S_Menub, 2, b, 351
)
draw_sprite(S_Menub, 0, 300, 301)}
if a = 2{
	b+= 10;
	draw_sprite(S_Menub, 3, b, 401)
	draw_sprite(S_Menub, 0, 300, 301)
	draw_sprite(S_Menub, 2, 300, 351)
}
if a = 3{
	b+= 10;
	draw_sprite(S_Menub, 4, b, 451)
	draw_sprite(S_Menub, 0, 300, 301)
	draw_sprite(S_Menub, 2, 300, 351)
	draw_sprite(S_Menub, 3, 300, 401)
}
if a >= 4{
	draw_sprite(S_Menub, 4, 300, 451)
	draw_sprite(S_Menub, 0, 300, 301)
	draw_sprite(S_Menub, 2, 300, 351)
	draw_sprite(S_Menub, 3, 300, 401)
}
	if a = 4{
		draw_sprite(S_Menuc, 0, 86, 306 + 50 * c)
		if keyboard_check_pressed(vk_up) && c > 0 {
			c -= 1;
			sound_play(Mieniu)
		}
		if keyboard_check_pressed(vk_down) && c < 3 {
			c += 1;
			sound_play(Mieniu)
		}

		if keyboard_check_pressed(vk_enter){
		if c = 0{ a = 5 }
		if c = 1{ a = 6 }
		if c = 2{ a = 6 }
		if c = 3{ a = 5 }
		sound_play(Mieniu2)
	}
}

if a = 6 {
	drawa+= 0.02
	draw_sprite_ext(S_Menua, c-1, 0, 0, 1, 1, 0, c_white, drawa)
	if drawa >= 1{
		a = 7
	}
}
if a = 7 {
	draw_sprite_ext(S_Menua, c-1, 0, 0, 1, 1, 0, c_white, drawa);
	if keyboard_check_pressed(vk_enter) && c = 1{
		a = 8
	}
	if keyboard_check_pressed(vk_escape) && c = 2{
		a = 8
	}
}
if a = 8{
	drawa -= 0.02
	draw_sprite_ext(S_Menua, c-1, 0, 0, 1, 1, 0, c_white, drawa)
	if drawa <= 0{
		a = 4;
		draw = 0
	}
}
if a = 5{
	timer = 1
	draw+= 0.05
	draw_set_alpha(draw)
	draw_set_color(c_black)
	draw_rectangle(0, 0, 800, 600, 0)
	if draw >= 1{
	if c = 0{
		room_goto_next()
	}
	if c = 3{
		game_end()}
	}
}
