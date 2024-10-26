if a<100{a+=0.3
draw_set_alpha(1-a/50)
draw_set_color(c_black)
draw_rectangle(0,0,800,600,0)
}
if floor(a)<=101 {
czacza+=1
if keyboard_check_pressed(vk_anykey) or mouse_check_button_pressed(mb_any) or czacza=500{
a=251+(100-a)
}
}
if a>=200{
draw_set_alpha((a-251)/100)
draw_set_color(c_black)
draw_rectangle(0,0,800,600,0)
a+=1.5
}
if a>=380{
room_goto(Intro_Cage)
}



