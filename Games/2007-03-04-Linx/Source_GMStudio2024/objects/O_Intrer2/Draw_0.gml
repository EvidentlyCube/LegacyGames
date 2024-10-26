if a<100{a+=0.3
draw_set_alpha(1-a/50)
draw_set_color(c_black)
draw_rectangle(0,0,800,600,0)
}
if floor(a)<=101 && a>15 &&(keyboard_check_pressed(vk_anykey) or mouse_check_button_pressed(mb_any) or !sound_isplaying(Snd_Cager)){
a=251+(100-a)
}
if a>=200{
draw_set_alpha((a-251)/100)
draw_set_color(c_black)
draw_rectangle(0,0,800,600,0)
a+=2
}
if a>=380{
sound_stop_all()
room_goto_next()
}


