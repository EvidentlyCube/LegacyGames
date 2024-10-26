global.spd=0
global.time=0
global.timer=0
global.colora=7
global.colorb=make_color_rgb(255,255,255)
global.font=font_add_sprite(S_Font,ord("!"),1,1);

for (sasa=0;sasa<16;sasa+=1){
    if surface_exists(sasa){surface_free(sasa)}
}

var tempusix;
tempusix=0;
repeat(21){
global.item[tempusix]=1
tempusix+=1
}

global.background=-1;
global.foreground=-1;
global.wallsprite=-1;

global.text="";

global.lev_r=0
global.lev_d=0
global.lev_l=0
global.lev_u=0

global.temp_first=1;
global.temp_retexture=0;
global.temp_rebackground=1;
global.temp_reforeground=1;
global.temp_rewalling=1;
global.temp_play_x=400
global.temp_play_y=0
global.temp_play_spd=0

/*Blend Testing*/
/*
global.zozo[0]=bm_zero;
global.zozo[1]=bm_one;
global.zozo[2]=bm_src_color;
global.zozo[3]=bm_src_alpha;
global.zozo[4]=bm_src_alpha_sat;
global.zozo[5]=bm_inv_dest_alpha;
global.zozo[6]=bm_inv_dest_color;
global.zozo[7]=bm_inv_src_alpha;
global.zozo[8]=bm_inv_src_color;
global.zozo[9]=bm_dest_alpha;
global.zozo[10]=bm_dest_color;
global.bima=0
global.bimb=0*/

global.texture=Texture_Ground;

//Create_Surfaces()

//Make_Level('./lev000.kil')

global.level=0;

Generate_Savefile("./save2.sav")

Particle_Generate()

room_goto(Generator)