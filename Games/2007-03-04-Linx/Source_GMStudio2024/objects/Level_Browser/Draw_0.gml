if SXMS2_MI_IsFinished(global.musa) && global.op_mus=1{
        global.musa=choose(2,3,4);
        SXMS2_MC_StopAllSongs();
        SXMS2_MC_PlaySong(choose(2,3,4))
}

draw_set_alpha(1)
Mening(10,10,room_width-10,335,0.6)
Mening(10,345,room_width-10,415,0.6)
Mening(10,425,room_width-10,594,0.6)
__background_set( e__BG.HSpeed, 0, (mouse_x-room_width/2)/200 )
__background_set( e__BG.VSpeed, 0, (mouse_y-room_height/2)/200 )

draw_set_alpha(0.3)
draw_set_color(c_white)
draw_set_halign(fa_center)
if mouse_y<330 && mouse_y>15 && global.pause=0{
draw_rectangle(2,floor((mouse_y+5)/21)*21-1,room_width-2,floor((mouse_y+5)/21)*21+9,0)
}
draw_set_alpha(1)

curr-=7
while curr<0{curr+=ds_list_size(global.lb_title)}
repeat(15){
if ds_list_find_value(global.lb_finish,curr)=1{draw_set_font(global.font)} else {draw_set_font(global.font2)}
draw_text(room_width/2,25+21*pos,string_hash_to_newline(ds_list_find_value(global.lb_title,curr)))
curr+=1
pos+=1
if curr>ds_list_size(global.lb_title)-1{curr-=ds_list_size(global.lb_title)}
}
curr-=8
pos=0
if keyboard_check_pressed(vk_down) && global.pause=0{curr+=1;soundplay(Snd_Place)}
if keyboard_check_pressed(vk_pagedown) && global.pause=0{curr+=15;soundplay(Snd_Place)}
if keyboard_check_pressed(vk_pageup) && global.pause=0{curr-=15;soundplay(Snd_Place)}
if keyboard_check_pressed(vk_up) && global.pause=0{curr-=1;soundplay(Snd_Place)}
if keyboard_check(vk_down) && global.pause=0{tumex+=1 if tumex>10{curr+=1}} else {
if keyboard_check(vk_up) && global.pause=0{tumex-=1 if tumex<-10{curr-=1}} else {tumex=0}}
if mouse_y<330 && mouse_y>15 && global.pause=0{
    if aaa!=floor((mouse_y+5)/21)-8{soundplay(Snd_Over)}
    aaa=floor((mouse_y+5)/21)-8
    now=floor((mouse_y+5)/21)-8+curr
    while now<0{now+=ds_list_size(global.lb_title)}
    while now>ds_list_size(global.lb_title)-1{now-=ds_list_size(global.lb_title)}
    draw_set_font(global.font)
    draw_text(room_width/2,360,string_hash_to_newline(ds_list_find_value(global.lb_title,now)))
    draw_text(room_width/2,380,string_hash_to_newline(ds_list_find_value(global.lb_author,now)))

    if mouse_check_button_pressed(mb_left){
        global.leveled=now
        global.editor=0
        global.level=now
        global.path=0
        global.l_title=ds_list_find_value(global.lb_title,now)
        global.l_author=ds_list_find_value(global.lb_author,now)
        global.pathx=real(ds_list_find_value(global.lb_limit,now))
        room_goto(Loaded_Level)
    }
    var kifonx;
    if ds_list_find_value(global.lb_finish,now)=1{kifonx="  Finished  "} else {kifonx="Unfinished  "}
    draw_text(room_width/2,400,string_hash_to_newline("Paths Limit: "+ds_list_find_value(global.lb_limit,now)+"    "+kifonx))
} else {if kufo=0{
    draw_set_font(global.font2)
    draw_text(room_width/2,360,string_hash_to_newline("--Level Title--"))
    draw_text(room_width/2,380,string_hash_to_newline("--Level Author--"))
    draw_text(room_width/2,400,string_hash_to_newline("Paths Limit: ---"+"    "+"Level Status"))
    } else {
        aaa=-666
        if global.pause=0{
            draw_set_font(global.font)
            switch(kufo){
            case(1):draw_text(room_width/2,360,string_hash_to_newline("Import levels from file.#No need to use it now, hence there is#ingame levels downloading."));break;
            case(2):draw_text(room_width/2,360,string_hash_to_newline("Opens textfile holding your levels.#No need to use it now, hence there is#ingame levels uploading."));break;
            case(3):draw_text(room_width/2,360,string_hash_to_newline("Downloads new levels from online database.#Warning! The game will stop for few seconds!"));break;
            case(4):draw_text(room_width/2,360,string_hash_to_newline("Uploads your levels to online database.#Warning! The game will stop for few seconds!"));break;
            case(5):draw_text(room_width/2,360,string_hash_to_newline("Opens editor and allows you to make levels."));break;
            case(6):draw_text(room_width/2,360,string_hash_to_newline("Returns to the title screen."));break;
            }
        }
    }
}

now=-1
if mouse_y>470 && mouse_y<590 && global.pause=0{
now=floor((mouse_y-470)/20)
draw_set_alpha(0.3)
draw_set_color(c_white)
draw_rectangle(200,floor((mouse_y-470)/20)*20+475,room_width-200,floor((mouse_y-470)/20)*20+485,0)
draw_set_alpha(1)
}
if aa!=now && now!=-1{soundplay(Snd_Over)}
aa=now
draw_set_font(global.font)
draw_text(400,440,string_hash_to_newline("Mouse Whell or Arrow keys to scroll!"))
draw_text(400,460,string_hash_to_newline("Left Mouse Button to play selected level!"))
draw_set_font(global.font2)
draw_text(400,480,string_hash_to_newline("Import Levels"))
draw_text(400,500,string_hash_to_newline("Open Your levels"))
draw_text(400,520,string_hash_to_newline("Download New Levels Directly"))
draw_text(400,540,string_hash_to_newline("Upload YOUR Levels Directly"))
draw_text(400,560,string_hash_to_newline("Create Your Levels"))
draw_text(400,580,string_hash_to_newline("Return to Main Menu"))
draw_set_font(global.font)
kufo=0
switch (now){
case(0):draw_text(400,480,string_hash_to_newline("Import Levels"));kufo=1;break;
case(1):draw_text(400,500,string_hash_to_newline("Open Your levels"));kufo=2;break;
case(2):draw_text(400,520,string_hash_to_newline("Download New Levels Directly"));kufo=3;break;
case(3):draw_text(400,540,string_hash_to_newline("Upload YOUR Levels Directly"));kufo=4;break;
case(4):draw_text(400,560,string_hash_to_newline("Create Your Levels"));kufo=5;break;
case(5):draw_text(400,580,string_hash_to_newline("Return to Main Menu"));kufo=6;break;
}
if mouse_check_button_pressed(mb_left){
switch (now){
case(0):soundplay(Snd_Click);event_user(0);break;
case(1):soundplay(Snd_Click);execute_shell("./levels/my.txt","");break;
case(2):soundplay(Snd_Click);Levels_Download();break;
case(3):soundplay(Snd_Click);Levels_Upload();break;
case(4):soundplay(Snd_Click);global.editor=1;global.leveled=-1;room_goto(Level_Copier);break;
case(5):soundplay(Snd_Click);room_goto(TS);break;
}
}


