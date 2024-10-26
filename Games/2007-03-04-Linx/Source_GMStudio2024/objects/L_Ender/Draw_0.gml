if global.pause=1{mote=100}
if mote<99{mote+=2}
if mote=99{
draw_set_alpha(0.8/max(1,mouse_y/100));
draw_set_font(global.font);
draw_set_color(c_black);
draw_rectangle(0,570,800,600,0);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(400,585,string_hash_to_newline("-=:Press any mouse button to continue:=-"));
if mouse_check_button(mb_any){mote=100}
}


if mote=100{
draw+=0.04+draw/10
draw_set_color(c_black)
draw_set_alpha(draw)
draw_rectangle(0,0,room_width,room_height,0)
if draw>=1{
global.pause=0
if global.leveled=-1{
if global.good=1 && global.editor=0{global.level+=1;room_goto_next()} else {room_goto(TS)}} else {
if global.good=1{global.fin=1} else {global.fin=0}
room_goto(Level_Browse)
}
}
}
