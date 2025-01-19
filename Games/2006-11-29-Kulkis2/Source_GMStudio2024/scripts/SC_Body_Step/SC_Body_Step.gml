function SC_Body_Step() {
	if move=0 && land!=1{
	if keyboard_check(vk_left){dir=180;if !place_meeting(x-20,y,SolidWalls){movex=-20;move=1;hy=-1;hx=-1;moved=1;sound_play(Tup);exit}
	if place_meeting(x-20,y,Crate) && !place_meeting(x-40,y,SolidWalls){movex=-20;move=1;hy=-1;hx=-1;sound_play(Tup);exit}}
	if keyboard_check(vk_right){dir=0;if !place_meeting(x+20,y,SolidWalls){movex=20;move=1;moved=2;sound_play(Tup);exit}
	if place_meeting(x+20,y,Crate) && !place_meeting(x+40,y,SolidWalls){movex=20;move=1;sound_play(Tup);exit}}
	if keyboard_check(vk_up){dir=90;if !place_meeting(x,y-20,SolidWalls){movey=-20;move=1;hy=-1;moved=3;sound_play(Tup);exit}
	if place_meeting(x,y-20,Crate) && !place_meeting(x,y-40,SolidWalls){movey=-20;move=1;hy=-1;sound_play(Tup);exit}}
	if keyboard_check(vk_down){dir=270;if !place_meeting(x,y+20,SolidWalls){movey=20;move=1;hx=-1;moved=4;sound_play(Tup);exit}
	if place_meeting(x,y+20,Crate) && !place_meeting(x,y+40,SolidWalls){movey=20;move=1;hx=-1;sound_play(Tup);exit}}
	}

	if move=0 && land=1{
	if keyboard_check(vk_left) && moved=0 or moved=1{dir=180;if !place_meeting(x-20,y,SolidWalls){movex=-20;move=1;hy=-1;hx=-1;moved=1;sound_play(Tup);exit} else {moved=0}}
	if keyboard_check(vk_right) && moved=0 or moved=2{dir=0;if !place_meeting(x+20,y,SolidWalls){movex=20;move=1;moved=2;sound_play(Tup);exit} else {moved=0}}
	if keyboard_check(vk_up) && moved=0 or moved=3{dir=90;if !place_meeting(x,y-20,SolidWalls){movey=-20;move=1;hy=-1;moved=3;sound_play(Tup);exit} else {moved=0}}
	if keyboard_check(vk_down) && moved=0 or moved=4{dir=270;if !place_meeting(x,y+20,SolidWalls){movey=20;move=1;hx=-1;moved=4;sound_play(Tup);exit} else {moved=0}}
	}





}
