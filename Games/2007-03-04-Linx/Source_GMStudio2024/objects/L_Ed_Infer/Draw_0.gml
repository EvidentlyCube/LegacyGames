if del=2{
    draw2+=1-draw2/30;draw+=0.01
}
if del=0{
    draw2-=(draw2-0.7)/10
    if draw>0.7{
        draw-=0.008
    }
    if draw2<0.73{
        bla=1;del=1;draw2=0.699
    }
}
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
    if del=1{ix+=(room_width/2-ix)/10} else {ix+=(ix-room_width/2)/10+4}
    switch (global.pause){
        case(1):
            draw_set_color(c_white)
            draw_set_alpha(1)
            draw_set_font(global.font)
            draw_set_halign(fa_center)
            draw_text(ix,room_height/2-10,string_hash_to_newline("Do you want to save this level?"))
            draw_set_font(global.font2)
            draw_text(ix,room_height/2+10,string_hash_to_newline("Y - Save; N - Cancel"))
            if ix>room_width/2-3 && ix<room_width/2+3{
                if keyboard_check_pressed(ord("Y")){global.lb_generated=0;Save_level();del=2;bla=1;soundplay(Snd_Click)}
                if keyboard_check_pressed(ord("N")){del=2;bla=1;soundplay(Snd_Click)}
            }
        break;
        case(2):
            draw_set_color(c_white)
            draw_set_alpha(1)
            draw_set_font(global.font)
            draw_set_halign(fa_center)
            draw_text(ix,room_height/2-10,string_hash_to_newline("Type level title (Enter-end;45 chars max.):"))
            draw_set_font(global.font2)
            draw_text(ix,room_height/2+10,string_hash_to_newline(global.l_title))
            if ix>room_width/2-3 && ix<room_width/2+3{
                if keyboard_check_pressed(vk_enter) {del=2;bla=1;soundplay(Snd_Click)}
                if keyboard_check_pressed(vk_anykey){
                    var bah;
                    bah=Texting();
                    if bah="back" && string_length(global.l_title)>0{soundplay(Snd_Undo);global.l_title=string_delete(global.l_title,string_length(global.l_title),1)} else{if string_length(global.l_title)<45 && string_length(bah)=1{soundplay(Snd_Type);global.l_title+=bah}}
                }
            }
        break;
        case(3):
            draw_set_color(c_white)
            draw_set_alpha(1)
            draw_set_font(global.font)
            draw_set_halign(fa_center)
            draw_text(ix,room_height/2-10,string_hash_to_newline("Type level author (Enter-end;45 chars max.):"))
            draw_set_font(global.font2)
            draw_text(ix,room_height/2+10,string_hash_to_newline(global.l_author))
            if ix>room_width/2-3 && ix<room_width/2+3{
                if keyboard_check_pressed(vk_enter) {del=2;bla=1;soundplay(Snd_Click)}
                if keyboard_check_pressed(vk_anykey){
                    var bah;
                    bah=Texting();
                    if bah="back" && string_length(global.l_author)>0{soundplay(Snd_Undo);global.l_author=string_delete(global.l_author,string_length(global.l_author),1)} else{if string_length(global.l_author)<45 && string_length(bah)=1{soundplay(Snd_Type);global.l_author+=bah}}
                }
            }
            break;
        case(4):
            draw_set_color(c_white)
            draw_set_alpha(1)
            draw_set_font(global.font)
            draw_set_halign(fa_center)
            draw_text(ix,room_height/2-20,string_hash_to_newline("'1' - Clear Paths"))
            draw_text(ix,room_height/2,string_hash_to_newline("'2' - Clear Whole Level "))
            draw_text(ix,room_height/2+20,string_hash_to_newline("'Escape' - Cancel"))
            if ix>room_width/2-3 && ix<room_width/2+3{
                if keyboard_check_pressed(ord("1")){with(Path){instance_destroy();};del=2;bla=1;soundplay(Snd_Click)}
                if keyboard_check_pressed(ord("2")){with(Path){instance_destroy()};with(Base){instance_destroy()};del=2;bla=1;soundplay(Snd_Click)}
                if keyboard_check_pressed(vk_escape){del=2;bla=1;soundplay(Snd_Click)}
            }
        break;
    }
}
