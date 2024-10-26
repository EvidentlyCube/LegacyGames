if a<50{a+=1}
if a=50 && keyboard_check_pressed(ord("G")){
a=251
}
if a>=251{
draw_set_alpha((a-251)/100)
draw_set_color(c_black)
draw_rectangle(0,0,800,600,0)
a+=1
}
if a=380{
if file_exists("./THIS_IS_NOT_A_SAVE.supasave"){
game_load("./THIS_IS_NOT_A_SAVE.supasave")} else {
room_goto_next()}
}
