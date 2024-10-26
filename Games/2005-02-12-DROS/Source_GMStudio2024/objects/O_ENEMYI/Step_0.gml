if place_meeting(x,y,O_WEAPON){kill=1}
if kill=1{instance_destroy();ran=floor(random(3))
if ran=0{sound_play(SND_KILL1)}
if ran=1{sound_play(SND_KILL2)}
if ran=2{sound_play(SND_KILL3)}
move=10
}

if global.can=1{
	if global.turn=1{
		if move<2{
		    while dir=0 && move=0{if place_meeting(x+ix,y+iy,O_PLAYER){ende=1;move=1;sound_play(SND_EYE)} else {if !place_meeting(x+ix,y+iy,O_WALL){iy-=16} else move=1}}
		    while dir=1 && move=0{if place_meeting(x+ix,y+iy,O_PLAYER){ende=1;move=1;sound_play(SND_EYE)} else {if !place_meeting(x+ix,y+iy,O_WALL){iy-=16;ix+=16} else move=1}}
		    while dir=2 && move=0{if place_meeting(x+ix,y+iy,O_PLAYER){ende=1;move=1;sound_play(SND_EYE)} else {if !place_meeting(x+ix,y+iy,O_WALL){ix+=16} else move=1}}
		    while dir=3 && move=0{if place_meeting(x+ix,y+iy,O_PLAYER){ende=1;move=1;sound_play(SND_EYE)} else {if !place_meeting(x+ix,y+iy,O_WALL){ix+=16;iy+=16} else move=1}}
		    while dir=4 && move=0{if place_meeting(x+ix,y+iy,O_PLAYER){ende=1;move=1;sound_play(SND_EYE)} else {if !place_meeting(x+ix,y+iy,O_WALL){iy+=16} else move=1}}
		    while dir=5 && move=0{if place_meeting(x+ix,y+iy,O_PLAYER){ende=1;move=1;sound_play(SND_EYE)} else {if !place_meeting(x+ix,y+iy,O_WALL){iy+=16;ix-=16} else move=1}}
		    while dir=6 && move=0{if place_meeting(x+ix,y+iy,O_PLAYER){ende=1;move=1;sound_play(SND_EYE)} else {if !place_meeting(x+ix,y+iy,O_WALL){ix-=16} else move=1}}
		    while dir=7 && move=0{if place_meeting(x+ix,y+iy,O_PLAYER){ende=1;move=1;sound_play(SND_EYE)} else {if !place_meeting(x+ix,y+iy,O_WALL){ix-=16;iy-=16} else move=1}}
		    ix=0
		    iy=0
		    if move=1{move=0}
		}
	}
}



if ende=1{
	smartRoomRestart();
}
