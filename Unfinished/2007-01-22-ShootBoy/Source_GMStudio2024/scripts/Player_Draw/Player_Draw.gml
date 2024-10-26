function Player_Draw() {
	draw_sprite(S_Ship,ship,x,y)

	draw_set_alpha(1)
	draw_set_color(c_dkgray)
	draw_rectangle(0,239,250,241,0)
	draw_set_color(c_red)
	draw_rectangle(0,239,250*hp/hpmax,241,0)
	draw_set_color(make_color_rgb(0,150,0))
	draw_rectangle(0,243,124,245,0)
	draw_rectangle(126,243,250,245,0)
	draw_rectangle(0,247,124,249,0)
	draw_rectangle(126,247,250,249,0)

	draw_set_color(make_color_rgb(0,255,0))
	draw_rectangle(124,243,124-124*stam1/stam1max,245,0)
	draw_rectangle(126,243,126+124*stam2/stam2max,245,0)
	draw_rectangle(124,247,124-124*stam3/stam3max,249,0)
	draw_rectangle(126,247,126+124*stam4/stam4max,249,0)



}
