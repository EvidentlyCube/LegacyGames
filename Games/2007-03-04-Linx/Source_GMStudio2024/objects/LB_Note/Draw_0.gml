if del=2{draw2+=1-draw2/20;draw+=0.005}
if del=0{draw2-=(draw2-0.7)/20;if draw>0.7{draw-=0.004};if draw2<0.73{bla=1;del=1;draw2=0.699}}
draw_set_color(c_black)
draw_set_alpha(1-draw)
draw_rectangle(0,0,room_width,room_height,0)
draw_set_blend_mode(bm_subtract)
draw_rectangle_color(0,room_height/2,room_width,room_height/2+60*(1-draw2/20),c_white,c_white,c_black,c_black,0)
draw_rectangle_color(0,room_height/2-60*(1-draw2/20),room_width,room_height/2,c_black,c_black,c_white,c_white,0)
draw_rectangle_color(0,room_height/2,room_width,room_height/2+60*(1-draw2/20),c_white,c_white,c_black,c_black,0)
draw_rectangle_color(0,room_height/2-60*(1-draw2/20),room_width,room_height/2,c_black,c_black,c_white,c_white,0)
draw_set_blend_mode(bm_normal)


if draw2>19.9{Master.diss=0;global.pause=0;instance_destroy()}

if bla=1{
        if del=1{ix+=(room_width/2-ix)/20} else {ix+=(ix-room_width/2)/20+2}
        draw_set_color(c_white)
        draw_set_alpha(1)
        draw_set_font(global.font)
        draw_set_halign(fa_right)
        if (global.pause=1){
        draw_text(ix+200,room_height/2-30,string_hash_to_newline("Number of Levels in Database:"))
        draw_text(ix+200,room_height/2,string_hash_to_newline("Number of Imported Levels:"))
        draw_text(ix+200,room_height/2+30,string_hash_to_newline("Number of Identical Levels:"))
        } else {
        draw_text(ix+200,room_height/2-30,string_hash_to_newline("Number of Your Levels:"))
        draw_text(ix+200,room_height/2,string_hash_to_newline("Number of Uploaded Levels:"))
        draw_text(ix+200,room_height/2+30,string_hash_to_newline("Number of Identical Levels:"))
        }
        draw_set_font(global.font2)
        draw_set_halign(fa_left)
        draw_text(ix+215,room_height/2-30,string_hash_to_newline(string(vara)))
        draw_text(ix+215,room_height/2,string_hash_to_newline(string(varb)))
        draw_text(ix+215,room_height/2+30,string_hash_to_newline(string(varc)))
        if ix>room_width/2-3 && ix<room_width/2+3{
        if keyboard_check_pressed(vk_anykey) or mouse_check_button(mb_any){del=2;bla=1}
        }
}
