lazy=0

var s_d;
s_te+=spd
s_d=sign(s_te)
with(Iscrate(x,y+dround(s_te))){Blink();if Noobstacle(x,y+25*sign(other.spd))&& movy=0{movy=25*sign(other.spd)}}
while abs(s_te)>=1{
      while Nowall(x,y+s_d) && !Isarrow(x,y+s_d,2+s_d) && abs(s_te)>=1{
            y+=s_d
            s_te-=s_d
      }     
      if !Nowall(x,y+s_d) or Isarrow(x,y+s_d,2+s_d){s_d*=-1;s_te-=s_te/max(1,abs(s_te));s_te*=-1;spd*=-1}
}


if lazy=200 && sek_e=0{sek_e=1;tim_e=0}
global.spd=spd

