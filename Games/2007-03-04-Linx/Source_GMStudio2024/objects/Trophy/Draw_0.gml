draw_set_alpha(1)
draw_sprite_ext(S_Trophy,1,x,y,1,1,0,c_white,1)

a+=pi/100
x+=radtodeg(sin(a))/80

if collision_point(mouse_x,mouse_y,Trophy,0,0){
draw_set_color(c_white)
draw_set_font(global.font)
draw_set_valign(fa_middle)
draw_set_halign(fa_center)
draw_text(600,112,string_hash_to_newline("You can now use#+/- on Numpad#to move through#levels in #the Campaign!"))
}
