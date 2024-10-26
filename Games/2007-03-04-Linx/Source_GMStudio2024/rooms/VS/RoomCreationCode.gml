if !instance_exists(Cursor){instance_create(0,0,Cursor)}

if file_exists("./settings.txt"){
	file=file_text_open_read("./settings.txt")
	global.op_path=file_text_read_real(file)
	file_text_readln(file)
	global.op_tit=file_text_read_real(file)
	file_text_readln(file)
	global.du=file_text_read_real(file)
	file_text_readln(file)
	global.op_fs=file_text_read_real(file)
	file_text_readln(file)
	global.op_db=file_text_read_real(file)
	file_text_readln(file)
	global.op_cr=file_text_read_real(file)
	file_text_readln(file)
	global.op_sot=file_text_read_real(file)
	file_text_readln(file)
	global.op_fx=file_text_read_real(file)
	file_text_readln(file)
	global.op_mus=file_text_read_real(file)
	file_text_close(file)
}else{
	global.op_path=1
	global.op_tit=1
	global.du=0
	global.op_fs=0
	global.op_db=0
	global.op_cr=0
	global.op_sot=0
	global.op_fx=1
	global.op_mus=1
}

if global.op_cr=0{
	window_set_fullscreen(global.op_fs);
}

window_set_showborder(global.op_db)
if global.op_cr=1{
	window_set_fullscreen(1)
}
// @FIXME - Stay on Top is no longer available
//window_set_stayontop(global.op_sot)


global.pathx=0
global.path=0
global.font=font_add_sprite(S_Fonts,ord("!"),0,1)
global.font2=font_add_sprite(S_Fonts2,ord("!"),0,1)
global.level=1
global.editor=1
global.l_title=""
global.l_author=""
global.lb_title=-1
global.lb_finish=-1
global.lb_author=-1
global.lb_limit=-1
global.lb_level=-1
global.pause=0
global.lb_generated=0
global.leveled=-1
global.fin=0
global.musa=choose(2,3,4)

SXMS2_I_Init(48000,32,1,0,0,1,0)
SXMS2_W_Init()
SXMS2_MC_LoadSongEx("./music1.mus",0,0,0,0,1)
SXMS2_MC_LoadSongEx("./music2.mus",1,0,0,0,1)
SXMS2_MC_LoadSongEx("./music3.mus",2,0,0,0,1)
SXMS2_MC_LoadSongEx("./music4.mus",3,0,0,0,1)
SXMS2_MC_LoadSongEx("./music5.mus",4,0,0,0,1)
SXMS2_MC_LoadSongEx("./music6.mus",5,0,0,0,1)

room_goto_next()