if global.move=1{
x=global.px
y=global.py
xmove=global.pxmove
ymove=global.pymove
global.move=0
}

if keyboard_check_pressed(ord("A")){kl=1}
if keyboard_check_released(ord("A")){kl=0}
if keyboard_check_pressed(ord("D")){kr=1}
if keyboard_check_released(ord("D")){kr=0}

if kl=1 && !place_meeting(x-0.5,y,Wall){xmove-=0.5}
if kr=1 && !place_meeting(x+0.5,y,Wall){xmove+=0.5}

/*if keyboard_check(vk_left) && !place_meeting(x-0.5,y,Wall){xmove-=0.5}
if keyboard_check(vk_right) && !place_meeting(x+0.5,y,Wall){xmove+=0.5}*/
if xmove>5{xmove=5}
if xmove<-5{xmove=-5}
if kl=0 && kr=0{
//if !keyboard_check(vk_left) && !keyboard_check(vk_right){
if xmove<0{xmove+=0.5}
if xmove>0{xmove-=0.5}}
if !place_meeting(x+xmove,y,Wall){x+=xmove} else 
{do {xmove-=xmove/abs(xmove)/10}until(!place_meeting(x+xmove,y,Wall) && xmove!=0);x+=xmove;xmove=0}
if keyboard_check_pressed(ord("W")) && ymove=0{ymove=-8} else {
if !place_meeting(x,y+0.3,Wall){ymove+=0.3}}
if !place_meeting(x,y+ymove,Wall){y+=ymove} else 
{do {ymove-=ymove/abs(ymove)/10}until(!place_meeting(x,y+ymove,Wall) && ymove!=0);y+=ymove;ymove=0}
if ymove=0{grav=0}


if xmove!=0{b=2}
if xmove=0{b=0}
if ymove>0{b=3}
if ymove<0{b=4}

/* */
/*  */
