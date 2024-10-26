SXMS2_I_Init(48000,32,1,0,0,1,0)
SXMS2_W_Init()
SXMS2_MC_LoadSongEx("./music.mus",0,0,0,0,1)



global.timer=0
global.font=font_add_sprite(S_Font,ord("!"),1,1)
draw_set_font(global.font)

global.number=0
global.maxi=0;
for(a=0;a<24;a+=1){
    global.finish[a]=0;
    global.time[a]=59940;
}
global.completed=0
global.music=1;
global.sound=1;
global.fs=0;
global.res=0





if file_exists("./save.svg"){
    game_load("./save.svg")
    exit
}
SXMS2_MC_StopAllSongs();SXMS2_MC_PlaySong(0);
room_goto_next();