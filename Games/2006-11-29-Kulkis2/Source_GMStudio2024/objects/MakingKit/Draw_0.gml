draw_set_color(c_white)
draw_set_font(font0)
draw_text(mouse_x+15,mouse_y+15,string_hash_to_newline(string(a)+ string(b)))
if type=1{
draw_text(mouse_x+15,mouse_y+25,string_hash_to_newline("Changing: " + string(d)))
draw_text(mouse_x+15,mouse_y+35,string_hash_to_newline("Action:"+ string(act) +"/"+ string(e)))
draw_text(mouse_x+15,mouse_y+45,string_hash_to_newline("Action Type: " + g[act] + "  " + string(h[act])))
if f[act]=0 or f[act]=2{draw_sprite(S_Blockers,h[act],mouse_x-15,mouse_y-15)} else {draw_sprite(i[act],0,mouse_x-35,mouse_y-35)}
draw_text(mouse_x+15,mouse_y+55,string_hash_to_newline(string(m[act]) +"/"+ string(n[act])))
draw_text(mouse_x+15,mouse_y+65,string_hash_to_newline(string(l)+" /Vis=" + string(o)))

}
