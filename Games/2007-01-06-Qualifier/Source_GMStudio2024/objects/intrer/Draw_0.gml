if a<50{a+=1}
if a=50 && (keyboard_check_pressed(vk_anykey) or mouse_check_button_pressed(mb_any)){
a=251
}
if a>=251{
draw_set_alpha((a-251)/100)
draw_set_color(c_black)
draw_rectangle(0,0,400,400,0)
a+=1
}
if a=380{room_goto_next()}
