if global.op_mus=0{
	SXMS2_MC_StopAllSongs()
}

if SXMS2_MI_IsFinished(1) && global.op_mus=1{
        SXMS2_MC_StopAllSongs();
        SXMS2_MC_PlaySong(1)
}
draw_set_valign(fa_top)
draw_sprite(S_Menuf,0,0,0)
draw_set_blend_mode(bm_add)
draw_sprite_ext(S_Menutfl,0,52,222,1,1,0,c_white,0.6)
draw_sprite_ext(S_Menutfl,0,419,222,1,1,0,c_white,0.6)
draw_sprite_ext(S_Menutfl,1,419,20,1,1,0,c_white,0.6)
draw_set_blend_mode(bm_normal)
__background_set( e__BG.HSpeed, 0, (mouse_x-room_width/2)/200 )
__background_set( e__BG.VSpeed, 0, (mouse_y-room_height/2)/200 )

a=-1
if mouse_x>64 && mouse_x<380 && mouse_y>245 && mouse_y<485 && mode=0{
a=floor((mouse_y-242)/35)
}
if aa!=a && a!=-1{soundplay(Snd_Over)}
aa=a

draw_set_color(c_white)
if a>-1{draw_set_alpha(0.2)
draw_rectangle(64,a*35+262-5,380,a*35+262+5,0)}
draw_set_alpha(1)
draw_set_halign(fa_center)
draw_set_font(global.font2)
if svis=1{
draw_text(225,262,string_hash_to_newline("Continue Campaign"))
draw_text(225,297,string_hash_to_newline("Reset Progress"))
} else {
draw_text(225,262,string_hash_to_newline("Start new Campagin"))
draw_text(225,297,string_hash_to_newline("Progress is Reseted"))
}
draw_text(225,332,string_hash_to_newline("Custom Levels"))
draw_text(225,367,string_hash_to_newline("Editorium"))
draw_text(225,402,string_hash_to_newline("Help"))
if a!=5{draw_text(225,437,string_hash_to_newline("Web Site"))}
draw_text(225,472,string_hash_to_newline("Quit Game"))
draw_set_font(global.font)
switch (a){
case (0):if svis=1{draw_text(225,262,string_hash_to_newline("Continue Campaign"))}else{draw_text(225,262,string_hash_to_newline("Start new Campagin"))};break;
case (1):if svis=1{draw_text(225,297,string_hash_to_newline("Reset Progress"))}else{draw_text(225,297,string_hash_to_newline("Progress is Reseted"))};break;
case (2):draw_text(225,332,string_hash_to_newline("Custom Levels"));break;
case (3):draw_text(225,367,string_hash_to_newline("Editorium"));break;
case (4):draw_text(225,402,string_hash_to_newline("Help"));break;
case (5):draw_text(225,437,string_hash_to_newline("www.mauft.com"));break;
case (6):draw_text(225,472,string_hash_to_newline("Quit Game"));break;
}
if mouse_check_button_pressed(mb_left){
switch (a){
case (0):soundplay(Snd_Click);SXMS2_MC_StopAllSongs();global.leveled=-1;global.editor=0;if file_exists("./save.sav"){file=file_bin_open("./save.sav",2);var dziupa;dziupa=file_bin_read_byte(file);file_bin_seek(file,20);global.level=file_bin_read_byte(file);file_bin_close(file);room_goto(dziupa)} else {global.level=1;room_goto(Level_00)};break;
case (2):soundplay(Snd_Click);SXMS2_MC_StopAllSongs();global.editor=0;global.leveled=0;room_goto(Level_Browse);break;
case (3):soundplay(Snd_Click);SXMS2_MC_StopAllSongs();global.editor=1;global.leveled=-1;room_goto(Level_Copier);break;
case (4):soundplay(Snd_Click);mode=1;break;
case (5):soundplay(Snd_Click);execute_shell("iexplore","http://www.mauft.com");break;
case (6):soundplay(Snd_Click);Gamendor();game_end();break;
}}

if mouse_check_button_pressed(mb_right) && a=1 && svis=1{
svis=0
file_delete("./save.sav")
}
var stt;
switch(a){
case(0):if svis=1{stt="Continue playing#from last#unconquered level."} else {stt="Start a new game#from first level."};break;
case(1):if svis=1{stt="Resets campaign#progress to first#level!#Click it with right#mouse button to#delete!"} else {stt="Progress is already#reseted!"};break;
case(2):stt="Play your levels#and levels created#by people, visit#www.mauft.com#for levels and#instructions!";break;
case(3):stt="Create new levels#and share them#with people!";break;
case(4):stt="Shows help window.";break;
case(5):stt="Visit my web site!#www.mauft.com";break;
case(6):stt="Exits the game.";break;
}
draw_set_font(global.font)
draw_set_valign(fa_middle)
if a!=-1{draw_text(600,112,string_hash_to_newline(stt))}
draw_set_valign(fa_top)

a=-1
if mouse_x>440 && mouse_x<740 && mouse_y>280 && mouse_y<500 && mode=0{
a=floor((mouse_y-275)/25)
}
if ab!=a && a!=-1{soundplay(Snd_Over)}
ab=a

draw_set_color(c_white)
if a>-1{draw_set_alpha(0.2)
draw_rectangle(440,a*25+291-5,740,a*25+291+5,0)
draw_set_alpha(1)}
draw_set_halign(fa_left)
draw_set_font(global.font2)
draw_text(440,250,string_hash_to_newline("Options"))
draw_text(440,290,string_hash_to_newline("Path Limit"))
draw_text(440,315,string_hash_to_newline("Show Title"))
draw_text(440,340,string_hash_to_newline("Del. Underlying"))
draw_text(440,365,string_hash_to_newline("Full Screen"))
draw_text(440,390,string_hash_to_newline("Draw Borders"))
draw_text(440,415,string_hash_to_newline("Change Res"))
draw_text(440,440,string_hash_to_newline("Stay on Top"))
draw_text(440,465,string_hash_to_newline("Sound FX"))
draw_text(440,490,string_hash_to_newline("Music"))
draw_set_font(global.font)
switch (a){
case(0):draw_text(440,290,string_hash_to_newline("Path Limit"));break;
case(1):draw_text(440,315,string_hash_to_newline("Show Title"));break;
case(2):draw_text(440,340,string_hash_to_newline("Del. Underlying"));break;
case(3):draw_text(440,365,string_hash_to_newline("Full Screen"));break;
case(4):draw_text(440,390,string_hash_to_newline("Draw Borders"));break;
case(5):draw_text(440,415,string_hash_to_newline("Change Res"));break;
case(6):draw_text(440,440,string_hash_to_newline("Stay on Top"));break;
case(7):draw_text(440,465,string_hash_to_newline("Sound FX"));break;
case(8):draw_text(440,490,string_hash_to_newline("Music"));break;
}

if mouse_check_button_pressed(mb_left){
switch (a){
case (0):
	soundplay(Snd_Click);
	global.op_path+=1-sign(global.op_path)*2;
	break;
case (1):
	soundplay(Snd_Click);
	global.op_tit+=1-sign(global.op_tit)*2;
	break;
case (2):
	soundplay(Snd_Click);
	global.du+=1-sign(global.du)*2;
	break;
case (3):
	soundplay(Snd_Click);
	global.op_fs+=1-sign(global.op_fs)*2;
	if global.op_cr=0 {
		window_set_fullscreen(global.op_fs);
		window_set_position((display_get_width()-window_get_width())/2,(display_get_height()-window_get_height())/2)
	}
	break;
case (4):
	soundplay(Snd_Click);
	global.op_db+=1-sign(global.op_db)*2;
	window_set_showborder(global.op_db);
	break;
case (5):
	soundplay(Snd_Click);
	global.op_cr+=1-sign(global.op_cr)*2;
	if global.op_cr=1{
		window_set_fullscreen(1)
	} else {
		display_reset(0, false)
		window_set_fullscreen(global.op_fs)
	}
	break;
case (6):
	soundplay(Snd_Click);
	global.op_sot+=1-sign(global.op_sot)*2;
	// @FIXME - Stay on Top is no longer available
	//window_set_stayontop(global.op_sot);
	break;
case (7):
	global.op_fx+=1-sign(global.op_fx)*2;
	soundplay(Snd_Click);
	break;
case (8):
	soundplay(Snd_Click);
	global.op_mus+=1-sign(global.op_mus)*2;
	break;
}
}

switch(a){
case(0):stt="When activated#there will be a#paths limit in#every level.#Only works in#campaign!";break;
case(1):stt="When activated on#start of every#level you will see#level title and#author. Can only#be disactivated for#campagin!";break;
case(2):stt="When activated you#will be able to#place paths on#other paths while#destroying the ones#beneath!#'U' - in-game.";break;
case(3):stt="Makes the game#window to occupy#the whole screen.#Works only if#changie resolution#is disactivated.";break;
case(4):stt="Makes the#game window have#borders and be#moveable.";break;
case(5):stt="Makes the game#to change resolution#to 800x600 for#better feel.";break;
case(6):stt="Makes the game#window always stay#on top of the other#windows.";break;
case(7):stt="Disables sounds.#Press \"F\" in-game#to toggle it!";break;
case(8):stt="Disables music.#Press \"M\" in-game#to toggle it!";break;
}
draw_set_font(global.font)
draw_set_valign(fa_middle)
draw_set_halign(fa_middle)
if a!=-1{draw_text(600,112,string_hash_to_newline(stt))}
draw_set_valign(fa_top)

draw_sprite(S_Gut2,global.op_path,720,290)
draw_sprite(S_Gut2,global.op_tit,720,315)
draw_sprite(S_Gut2,global.du,720,340)
draw_sprite(S_Gut2,global.op_fs,720,365)
draw_sprite(S_Gut2,global.op_db,720,390)
draw_sprite(S_Gut2,global.op_cr,720,415)
draw_sprite(S_Gut2,global.op_sot,720,440)
draw_sprite(S_Gut2,global.op_fx,720,465)
draw_sprite(S_Gut2,global.op_mus,720,490)


if mode>0{
if mode=1{
bubo+=0.016
bibo+=0.02
if bibo>=0.99{bibo=1;bubo=0.8;mode=2}
}
if mode=2 && mouse_check_button_pressed(mb_left){mode=3}
if mode=3{
bubo-=0.016
bibo-=0.02
if bibo<=0{bibo=0;bubo=0;mode=0}
}

draw_set_color(c_black)
draw_set_alpha(bubo)
draw_rectangle(0,0,800,600,0)

draw_set_alpha(bibo)
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_font(global.font2)
draw_text(50,70,string_hash_to_newline("In Linx your objective is to connect#the Bases(1) of the same color using the#Paths(2) of the same color.#Paths of different colors can't cross!#Single Base has to be connected with itself!#You can only place paths on tiles!"))
draw_text(50,230,string_hash_to_newline("Click the Base to change the color#to its' color. Click all over the#playfield to place Paths."))
draw_text(50,325,string_hash_to_newline("There are two Modes in editor:#Bases - For placing bases and empty spaces#Paths - for placing paths#The controls used in levels editor:#0-9 Numbers - select object to place#Space - Toggle mode#'U' - Toggle Delete Underlying#'N' - Type level name#'A' - Change level Author#'S' - Save Level#'C' - Clear level#+/- Numpad - Change Paths limit")) 
draw_set_font(global.font)
draw_text(50,50,string_hash_to_newline("Objective:#   Linx#    Bases#Paths#Paths#       Base"))
draw_text(50,210,string_hash_to_newline("Controls:#          Base##                   Paths"))
draw_text(50,305,string_hash_to_newline("Editor:#              Modes#Bases#Paths##0-9#Space#'U'#'N'#'A'#'S'#'C'#+/-"))

draw_text(645,205,string_hash_to_newline("1 -"))
draw_text(645,275,string_hash_to_newline("2 -"))
draw_sprite_ext(S_Base_Yll,1,690,170,1,1,0,c_white,bibo)
draw_sprite_ext(S_Path_Yll,15,690,240,1,1,0,c_white,bibo)
}
