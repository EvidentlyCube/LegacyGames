if global.op_path=0 && global.leveled=-1 && global.editor=0{global.pathx=0}
if global.pause=0 && global.editor=1{
if keyboard_check_pressed(vk_anykey){
switch (keyboard_key){
case(ord("1")):inst=Base_Blk;soundplay(Snd_Click);itemmo=1;break;
case(ord("2")):inst=Base_Wht;soundplay(Snd_Click);itemmo=2;break;
case(ord("3")):inst=Base_Red;soundplay(Snd_Click);itemmo=3;break;
case(ord("4")):inst=Base_Orn;soundplay(Snd_Click);itemmo=4;break;
case(ord("5")):inst=Base_Yll;soundplay(Snd_Click);itemmo=5;break;
case(ord("6")):inst=Base_Grn;soundplay(Snd_Click);itemmo=6;break;
case(ord("7")):inst=Base_Trq;soundplay(Snd_Click);itemmo=7;break;
case(ord("8")):inst=Base_Blu;soundplay(Snd_Click);itemmo=8;break;
case(ord("9")):inst=Base_Vlt;soundplay(Snd_Click);itemmo=9;break;
case(ord("0")):inst=Block;soundplay(Snd_Click);itemmo=0;break;
}}

}

if global.editor=0 && SXMS2_MI_IsFinished(global.musa) && global.op_mus=1{
        global.musa=choose(2,3,4);
        SXMS2_MC_StopAllSongs();
        SXMS2_MC_PlaySong(choose(2,3,4))
}
if global.editor=1 && SXMS2_MI_IsFinished(0) && global.op_mus=1{
        SXMS2_MC_StopAllSongs();
        SXMS2_MC_PlaySong(0)
}
