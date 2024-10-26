draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,global.colorb,image_alpha);
if (sek_m=0){draw_sprite(S_Cursor,0,mouse_x,mouse_y);} else {draw_sprite(S_Cursor,1,mouse_x,mouse_y);}
switch (sek_e){
       case (0):draw_sprite(S_Player_Eyes,0,x,y);break;
       case (1):
            if tim_e<2{tim_e+=0.2}
            draw_sprite(S_Player_Eyes,5+tim_e,x,y)
            break;
       case (2):
            if tim_e>0{tim_e-=0.2} else {sek_e=0;if sek_m=0{sek_m=1;mou_f=10+fran(200)}}
            draw_sprite(S_Player_Eyes,5+tim_e,x,y)
            break;
}
switch (sek_m){
       case (0):
            draw_sprite(S_Player_Mouth,mou_f,x,y)
            mou_t-=1
            if mou_t<=0{
            mou_f=choose(0,1,2,3)
            mou_t=50+fran(20)
            }
            break;
       case (1):
            var ran;
            if tim_m<4{tim_m+=0.2} else {tim_m-=1}
            mou_f-=1
            if mou_f<0{sek_m=2}
            draw_sprite(S_Player_Mouth,4+tim_m,x,y)
            break;
       case (2):
            if tim_m>0{tim_m-=0.2} else {mou_f=choose(0,1,2,3);sek_m=0}
            draw_sprite(S_Player_Mouth,4+tim_m,x,y)
            break;
       case (3):
            draw_sprite(S_Player_Mouth,9,x,y)
            break;
       case (4):
            if tim_m<3{tim_m+=0.2} else {sek_m=0}
            draw_sprite(S_Player_Mouth,11+tim_m,x,y)
            break;
}
