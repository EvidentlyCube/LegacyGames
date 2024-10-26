s_talka=Add_Bmp("talka.ztr",1,0,1,1,0,0,0);
s_talkb=Add_Bmp("talkb.ztr",1,0,1,1,0,0,0);
s_arr=Add_Bmp("arrow.ztr",1,0,1,1,0,-25,-25);

Talker_Get_Special(global.temp_var)

//s_face[0]=Add_Face(0);

__background_set( e__BG.Visible, 1, 0 )

with (Player){instance_change(Player_Stop,0)}

/*
text[0]="YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!#IT IS.....##A-W-E-S-O-M-E!!!"
author[0]='Baka'
side[0]=1
face[0]=s_face[0]
*/

u_text=""
u_author=""
u_face=-1
d_text=""
d_author=""
d_face=-1
current=0
//amount=3
up=0
down=0

if side[current]=0{
    u_text=""
    u_author=author[current]
    u_face=face[current]
    up=1
} else {
    d_text=""
    d_author=author[current]
    d_face=face[current]
    down=1
}
counter=0
/* */
/*  */
