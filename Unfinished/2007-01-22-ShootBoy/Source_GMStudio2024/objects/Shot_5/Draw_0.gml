if global.pause=0{
a-=30
if a<=0{instance_destroy()} else {
draw_set_alpha(a/255)
draw_line_color(Player.x,Player.y,ix,iy,make_color_rgb(a,a/5,a/10),make_color_rgb(a,a/5,a/10))
draw_set_alpha(1)}
}

