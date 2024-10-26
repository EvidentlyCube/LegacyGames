if collision_rectangle(x,0,x+1,100,wall,1,1){draw_set_color(c_red)}else{
draw_set_color(c_dkgray)}
draw_line(x,0,x,100)
draw_line(x+1,0,x+1,100)
draw_sprite(sprite_index,image_index,x,y)

