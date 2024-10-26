if keyboard_check_pressed(vk_anykey) && b=0{
b=0
if a=0 && keyboard_check_pressed(ord("H")){a=1;exit}
if a=1 && keyboard_check_pressed(ord("A")){a=2;exit}
if a=2 && keyboard_check_pressed(ord("C")){a=3;exit}
if a=3 && keyboard_check_pressed(ord("K")){a=4;exit}
if a=4 && keyboard_check_pressed(ord("E")){a=5;exit}
if a=5 && keyboard_check_pressed(ord("R")){a=6;exit}
a=0
}

if keyboard_check_pressed(vk_anykey) && a=0{
a=0
if b=0 && keyboard_check_pressed(ord("P")){b=1;exit}
if b=1 && keyboard_check_pressed(ord("R")){b=2;exit}
if b=2 && keyboard_check_pressed(ord("O")){b=3;exit}
if b=3 && keyboard_check_pressed(ord("C")){b=4;exit}
if b=4 && keyboard_check_pressed(ord("E")){b=5;exit}
if b=5 && keyboard_check_pressed(ord("E")){b=6;exit}
if b=6 && keyboard_check_pressed(ord("D")){b=7;exit}
if b=7 && keyboard_check_pressed(ord("W")){b=8;exit}
if b=8 && keyboard_check_pressed(ord("I")){b=9;exit}
if b=9 && keyboard_check_pressed(ord("T")){b=10;exit}
if b=10 && keyboard_check_pressed(ord("H")){b=11;exit}
if b=11 && keyboard_check_pressed(ord("C")){b=12;exit}
if b=12 && keyboard_check_pressed(ord("A")){b=13;exit}
if b=13 && keyboard_check_pressed(ord("U")){b=14;exit}
if b=14 && keyboard_check_pressed(ord("T")){b=15;exit}
if b=15 && keyboard_check_pressed(ord("I")){b=16;exit}
if b=16 && keyboard_check_pressed(ord("O")){b=17;exit}
if b=17 && keyboard_check_pressed(ord("N")){b=18;exit}
if b=18 && keyboard_check_pressed(ord("S")){b=19;exit}
if b=19 && keyboard_check_pressed(ord("E")){b=20;exit}
if b=20 && keyboard_check_pressed(ord("N")){b=21;exit}
if b=21 && keyboard_check_pressed(ord("P")){b=22;exit}
if b=22 && keyboard_check_pressed(ord("A")){b=23;exit}
if b=23 && keyboard_check_pressed(ord("I")){b=24;exit}

b=0
}
if a=6{
if v=0{
a=get_integer("Type the secret code here:",0)
}else {a=instance_number(ii_objectivers)*room+instance_number(ii_objectivers)-666}
if real(a)=instance_number(ii_objectivers)*room+instance_number(ii_objectivers)-666{v=ds_list_find_value(global.list,instance_number(ii_block))}
a=0
}

if b=24{clipboard_set_text(string(instance_number(ii_objectivers)*room+instance_number(ii_objectivers)-666));b=0}
if keyboard_check_pressed(vk_escape){u+=1;z=0}
if u>0{z+=1}
if z=100{u=0;z=0}
if u=3{ds_list_clear(global.list);sound_play(sels);room_goto(cardmenu)}
