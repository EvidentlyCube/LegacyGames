if keyboard_check_pressed(ord("G")){kr=1}
if keyboard_check_released(ord("G")){kr=0}

if kr=1 && !place_meeting(x+0.5,y,Wall){xmove+=1}

if xmove>5{xmove=5}
if kl=0 && kr=0{
if xmove>0{xmove-=1}}
if place_meeting(x+xmove,y,Wall){Die()} else {x+=xmove}
if keyboard_check_released(ord("G")) && ymove=0{ymove=-8;sound_play(s1)} else {
if !place_meeting(x,y+0.3,Wall){ymove+=0.3}}
if !place_meeting(x,y+ymove,Wall){y+=ymove} else 
{do {ymove-=ymove/abs(ymove)/10}until(!place_meeting(x,y+ymove,Wall) && ymove!=0);y+=ymove;ymove=0}
if ymove=0{grav=0}


if xmove!=0{b=2}
if xmove=0{b=0}
if ymove>0{b=3}
if ymove<0{b=4}

if x>room_width{sound_play(s3);room_goto_next()}

if y>room_height{Die()}
