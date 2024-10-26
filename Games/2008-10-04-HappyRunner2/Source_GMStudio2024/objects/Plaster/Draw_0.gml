draw_set_color(c_white)
isin=0
if mouse_x>50 && mouse_x<550 && mouse_y>60 && mouse_y<540{

if mouse_check_button_pressed(mb_left){
	global.level=ide.number
	
	execute_string('room_goto(Level_'+string(global.level)+')')
}


if mouse_check_button_pressed(mb_right){
if ide.number=global.maxi-1{global.completed+=1;}
global.number=0
global.maxi=0
room_restart()
}

isin=1

ide=instance_nearest(mouse_x,mouse_y,Level_Elector)
ide.cool=1
if instance_exists(ide-1){
(ide-1).cool=2
}
}

if mouse_x>550 && mouse_y>340 && mouse_y<540 {
draw_set_alpha(0.5)
draw_rectangle(550,floor((mouse_y-300)/40)*40+300,800,floor((mouse_y-300)/40)*40+340,0)
draw_set_alpha(1)
    if mouse_check_button_pressed(mb_left){
        switch(floor((mouse_y-300)/40)){
            case(0):
                
            break;
            case(1):
                global.music+=1-global.music*2;
                if global.music=0{
                    SXMS2_MC_StopAllSongs();
                } else {
                    SXMS2_MC_PlaySong(0);
                }
            break;
            case(2):
                global.sound+=1-global.sound*2;
            break;
            case(3):
                if global.fs=0{
                    global.fs=1;
                    if global.res=0{window_set_fullscreen(1);}
                } else {
                    global.fs=0;
                    if global.res=0{window_set_fullscreen(0);}
                }
            break;
            case(4):
                if global.res=0{
                    global.res=1;
                    window_set_fullscreen(0);
                    display_set_size(800,600);
                    window_set_fullscreen(1);
                } else {
                    global.res=0;
                    window_set_fullscreen(0);
                    display_reset();
                    if global.fs=1{window_set_fullscreen(1);} else {window_set_fullscreen(0);}
                }

            break;
            case(5):
                game_end();
            break;
        }
    }
}

if isin=1{draw_text(552,70,string(ide.number+1));} else {draw_text(552,70,'Level Number:');}
if isin=1{draw_text(552,110,Time(global.time[ide.number]));} else {draw_text(552,110,'Level Time:');}
if isin=1{if global.finish[ide.number]=1{draw_text(552,150,'Finished');} else {draw_text(552,150,'Unfinished');}}  else {draw_text(552,150,'Level State:');}
if global.music=1{draw_text(552,350,'Music On');} else {draw_text(552,350,'Music Off');}
if global.sound=1{draw_text(552,390,'Sound On');} else {draw_text(552,390,'Sound Off');}
if global.fs=1{draw_text(552,430,'F. Screen On');} else {draw_text(552,430,'F. Screen Off');}
if global.res=1{draw_text(552,470,'Resolution On');} else {draw_text(552,470,'Resolution Off');}
draw_text(552,510,'Quit');

