lazy+=1

if Check_Left(){
    var s_t;
    s_t=spt
    with(Iscrate(x-1,y)){if Noobstacle(x-25,y) && movx=0{movx=-25}}
    while s_t>0 && Nowall(x-1,y) && !Isarrow(x+1,y,0){
        lazy=0
        if sek_e=1{sek_e=2}
        x-=1
        s_t-=1
        if place_meeting(x-1,y,Master){
            global.temp_play_spd=spd;
            global.temp_play_x=775
            global.temp_play_y=y-9
            global.level=global.lev_l;
            global.temp_rebackground=1;
            global.temp_reforeground=1;
            global.temp_rewalling=1;
            room_goto(Generator)
        }
    }
}

if Check_Right(){
    var s_t;
    s_t=spt
    with(Iscrate(x+1,y)){if Noobstacle(x+25,y) && movx=0{movx=25}}
    while s_t>0 && Nowall(x+1,y) && !Isarrow(x+1,y,2){
        lazy=0
        if sek_e=1{sek_e=2}
        x+=1    
        s_t-=1
        if place_meeting(x+1,y,Master){
            global.temp_play_spd=spd;
            global.temp_play_x=0
            global.temp_play_y=y-9
            global.level=global.lev_r;
            global.temp_rebackground=1;
            global.temp_reforeground=1;
            global.temp_rewalling=1;
            
            room_goto(Generator)
        }
    }
}

if (Check_Down() && abs(spd)>1){
spd-=sign(spd)/5;
}

if (Check_Up() && abs(spd)<10){
spd+=sign(spd)/5;
}

var s_d;
s_te+=spd
s_d=sign(s_te)
with(Iscrate(x,y+dround(s_te))){Blink();if Noobstacle(x,y+25*sign(other.spd))&& movy=0{movy=25*sign(other.spd)}}
while abs(s_te)>=1{
      while Nowall(x,y+s_d) && !Isarrow(x,y+s_d,2+s_d) && abs(s_te)>=1{
            y+=s_d
            s_te-=s_d
      }
      if place_meeting(x,y+s_d,Master){
        switch(s_d){
            case(1):
                global.temp_play_spd=spd;
                global.temp_play_x=x-201
                global.temp_play_y=0
                global.level=global.lev_d;
                global.temp_rebackground=1;
                global.temp_reforeground=1;
                global.temp_rewalling=1;        
                room_goto(Generator)
            exit;
            case(-1):
                global.temp_play_spd=spd;
                global.temp_play_x=x-201
                global.temp_play_y=700
                global.level=global.lev_u;
                global.temp_rebackground=1;
                global.temp_reforeground=1;
                global.temp_rewalling=1;
                room_goto(Generator)
            exit;
            }
        }
      if !Nowall(x,y+s_d) or Isarrow(x,y+s_d,2+s_d){s_d*=-1;s_te-=s_te/max(1,abs(s_te));s_te*=-1;spd*=-1}
}


if lazy=200 && sek_e=0{sek_e=1;tim_e=0}

if mouse_check_button(mb_left){
sek_m=3
}
if mouse_check_button_released(mb_left){
if sek_m=3{sek_m=4;tim_m=0;instance_create(x+12,y+17,Acid)}
}
global.spd=spd

