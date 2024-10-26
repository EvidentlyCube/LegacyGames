draw_set_color(c_white)
draw_set_halign(fa_left)
draw_text(94,room_height-16,string_hash_to_newline("001"))
draw_text(163,room_height-16,string_hash_to_newline(string(global.level)))
draw_text(281,room_height-16,string_hash_to_newline(string(global.maxclick)))
draw_set_halign(fa_right)
draw_text(274,room_height-16,string_hash_to_newline(string(global.click)))
if instance_number(i_toggler)=0{
    global.click=0;
    global.maxclick=0;
    ds_grid_clear(global.grid,0);
    if room!=i_RLG {i_scripto();}
    sound_play(winz);
    if room=i_050{
        room_goto(endian)
    } else {
        if room!=i_RLG{
            global.level+=1;
            nexter()
        } else{
            room_goto(togmenu)
        }
    }
}
caption=room_get_name(room)
if global.click>global.maxclick{global.click=0;global.maxclick=0;room_restart()}
if b=22{
var kol,lol;
lol=0
for (kol=0;lol<19;kol+=1){
if kol=20{kol=0;lol+=1}
if lol<19{
if ds_grid_get(global.grid,kol,lol)=1{draw_rectangle(kol*20+5,lol*20+5,kol*20+15,lol*20+15,0)}}
}
}
