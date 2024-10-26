if keyboard_check_pressed(vk_escape){a+=1;b=0}
if a>0{b+=1}
if b=100{a=0;b=0}
if a=3{sound_play(sels);room_goto(togmenu)}
if keyboard_check_pressed(vk_anykey) && !keyboard_check(vk_f11){
if b=0 && keyboard_check_pressed(ord("P")){b=1;exit}
if b=1 && keyboard_check_pressed(ord("E")){b=2;exit}
if b=2 && keyboard_check_pressed(ord("A")){b=3;exit}
if b=3 && keyboard_check_pressed(ord("N")){b=4;exit}
if b=4 && keyboard_check_pressed(ord("U")){b=5;exit}
if b=5 && keyboard_check_pressed(ord("T")){b=6;exit}
if b=6 && keyboard_check_pressed(ord("C")){b=7;exit}
if b=7 && keyboard_check_pressed(ord("H")){b=8;exit}
if b=8 && keyboard_check_pressed(ord("O")){b=9;exit}
if b=9 && keyboard_check_pressed(ord("O")){b=10;exit}
if b=10 && keyboard_check_pressed(ord("C")){b=11;exit}
if b=11 && keyboard_check_pressed(ord("H")){b=12;exit}
if b=12 && keyboard_check_pressed(ord("O")){b=13;exit}
if b=13 && keyboard_check_pressed(ord("O")){b=14;exit}
if b=14 && keyboard_check_pressed(ord("B")){b=15;exit}
if b=15 && keyboard_check_pressed(ord("Y")){b=16;exit}
if b=16 && keyboard_check_pressed(ord("G")){b=17;exit}
if b=17 && keyboard_check_pressed(ord("R")){b=18;exit}
if b=18 && keyboard_check_pressed(ord("O")){b=19;exit}
if b=19 && keyboard_check_pressed(ord("U")){b=20;exit}
if b=20 && keyboard_check_pressed(ord("P")){b=21;exit}
if b=21 && keyboard_check_pressed(ord("X")){b=22;exit}
b=0
}
