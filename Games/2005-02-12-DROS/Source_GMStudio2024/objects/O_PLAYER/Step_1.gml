if global.can = 1 {
	ix=x
	iy=y
	if keyboard_check(vk_numpad1) 
		or keyboard_check(vk_numpad2) 
		or keyboard_check(vk_numpad3) 
		or keyboard_check(vk_numpad4)
		or keyboard_check(vk_numpad5)
		or keyboard_check(vk_numpad6)
		or keyboard_check(vk_numpad7)
		or keyboard_check(vk_numpad8)
		or keyboard_check(vk_numpad9)
		or keyboard_check(ord("Q"))
		or keyboard_check(ord("W"))
		or keyboard_check(ord("A"))
		or keyboard_check(ord("S"))
	{
		O_WEAPON.x = 2000;
		O_WEAPON.y = 2000;
	}
	if keyboard_check(vk_numpad1) && place_free(x-16,y+16) && global.turn=0 {
		if move[1] = 0 or move[1] > 15 {
			x-=16;
			y+=16;
			global.turn=1;
			move[1] += 1;
			moved = 1;
			sound_play(SND_MOVE);
		}
	}
	if keyboard_check(vk_numpad2) && place_free(x,y+16) && global.turn=0 {
		if move[2] = 0 or move[2] > 15 {
			y += 16;
			global.turn = 1;
			move[2] += 1;
			moved = 1;
			sound_play(SND_MOVE);
		}
	}
	if keyboard_check(vk_numpad3) && place_free(x+16,y+16) && global.turn=0 {
		if move[3] = 0 or move[3] > 15 {
			x += 16;
			y += 16;
			global.turn = 1;
			move[3] += 1;
			moved = 1;
			sound_play(SND_MOVE);
		}
	}
	if keyboard_check(vk_numpad4) && place_free(x-16,y) && global.turn=0 {
		if move[4] = 0 or move[4] > 15 {
			x -= 16;
			global.turn = 1;
			move[4] += 1;
			moved = 1;
			sound_play(SND_MOVE);
		}
	}
	if keyboard_check(vk_numpad6) && place_free(x+16,y) && global.turn=0 {
		if move[6] = 0 or move[6] > 15 {
			x += 16;
			global.turn = 1;
			move[6] += 1;
			moved = 1;
			sound_play(SND_MOVE);
		}
	}
	if keyboard_check(vk_numpad7) && place_free(x-16,y-16) && global.turn=0 {
		if move[7] = 0 or move[7] > 15 {
			x -= 16;
			y -= 16;
			global.turn = 1;
			move[7] += 1;
			moved = 1;
			sound_play(SND_MOVE);
		}
	}
	if keyboard_check(vk_numpad8) && place_free(x,y-16) && global.turn=0 {
		if move[8] = 0 or move[8] > 15 {
			y -= 16;
			global.turn = 1;
			move[8] += 1;
			moved = 1;
			sound_play(SND_MOVE);
		}
	}
	if keyboard_check(vk_numpad9) && place_free(x+16,y-16) && global.turn=0 {
		if move[9] = 0 or move[9] > 15{ 
			x += 16;
			y -= 16;
			global.turn = 1;
			move[9] += 1;
			moved = 1;
			sound_play(SND_MOVE);
		}
	}
	if keyboard_check(vk_numpad5) && global.turn = 0 {
		if move[5] = 0 or move[5] > 15 {
			global.turn = 1;
			move[5] += 1;
		}
	}

	if keyboard_check(ord("Q")) && move[10] = 0{
		if move[10] = 0 or move[10] > 15 {
			move[10] -= 16;
			O_WEAPON.dir -= 1;
			global.turn = 1;
			sound_play(SND_SWING)
		}
	}
	if keyboard_check(ord("W")) && move[11] = 0 {
		if move[11] = 0 or move[11] > 15 {
			O_WEAPON.dir += 1;
			global.turn = 1;
			move[11] -= 16;
			sound_play(SND_SWING);
		}
	}
	if keyboard_check(ord("A")) && O_WEAPON.current = 1 && move[12] = 0 {
		if move[12] = 0 or move[12] > 15 {
			O_WEAPON.dir -= 1;
			O_WEAPON.dire = -2;
			global.turn = 1;
			move[12] -= 16;
			sound_play(SND_SWING);
		}
	}
	if keyboard_check(ord("S")) && O_WEAPON.current = 1 && move[13] = 0 {
		if move[13] = 0 or move[13] > 15 {
			O_WEAPON.dir += 1;
			O_WEAPON.dire = 2;
			global.turn = 1;
			move[13] -= 16;
			sound_play(SND_SWING);
		}
	}
	if O_WEAPON.dir>7{O_WEAPON.dir-=8}
	if O_WEAPON.dir<0{O_WEAPON.dir+=8}
	image_single=O_WEAPON.dir

	if moved=1{ if place_meeting(ix,iy,O_MISCD){ide=instance_position(ix,iy,O_PIT) ide.ende=1}}

	if O_WEAPON.current=0{
		if O_WEAPON.dir=0{O_WEAPON.x=x;O_WEAPON.y=y-16}
		if O_WEAPON.dir=1{O_WEAPON.x=x+16;O_WEAPON.y=y-16}
		if O_WEAPON.dir=2{O_WEAPON.x=x+16;O_WEAPON.y=y}
		if O_WEAPON.dir=3{O_WEAPON.x=x+16;O_WEAPON.y=y+16}
		if O_WEAPON.dir=4{O_WEAPON.x=x;O_WEAPON.y=y+16}
		if O_WEAPON.dir=5{O_WEAPON.x=x-16;O_WEAPON.y=y+16}
		if O_WEAPON.dir=6{O_WEAPON.x=x-16;O_WEAPON.y=y}
		if O_WEAPON.dir=7{O_WEAPON.x=x-16;O_WEAPON.y=y-16}
	}
	if O_WEAPON.current=1{
		if O_WEAPON.dir=0{O_WEAPON.x=x;O_WEAPON.y=y-16}
		if O_WEAPON.dir=1{O_WEAPON.x=x+16;O_WEAPON.y=y-16}
		if O_WEAPON.dir=2{O_WEAPON.x=x+16;O_WEAPON.y=y}
		if O_WEAPON.dir=3{O_WEAPON.x=x+16;O_WEAPON.y=y+16}
		if O_WEAPON.dir=4{O_WEAPON.x=x;O_WEAPON.y=y+16}
		if O_WEAPON.dir=5{O_WEAPON.x=x-16;O_WEAPON.y=y+16}
		if O_WEAPON.dir=6{O_WEAPON.x=x-16;O_WEAPON.y=y}
		if O_WEAPON.dir=7{O_WEAPON.x=x-16;O_WEAPON.y=y-16}
	}
	
	if !keyboard_check(vk_numpad1){move[1]=0} else {if key!=keyboard_lastkey{move[1]=0}key=keyboard_lastkey;move[1]+=1}
	if !keyboard_check(vk_numpad2){move[2]=0} else {if key!=keyboard_lastkey{move[2]=0}key=keyboard_lastkey;move[2]+=1}
	if !keyboard_check(vk_numpad3){move[3]=0} else {if key!=keyboard_lastkey{move[3]=0}key=keyboard_lastkey;move[3]+=1}
	if !keyboard_check(vk_numpad4){move[4]=0} else {if key!=keyboard_lastkey{move[4]=0}key=keyboard_lastkey;move[4]+=1}
	if !keyboard_check(vk_numpad5){move[5]=0} else {if key!=keyboard_lastkey{move[5]=0}key=keyboard_lastkey;move[5]+=1}
	if !keyboard_check(vk_numpad6){move[6]=0} else {if key!=keyboard_lastkey{move[6]=0}key=keyboard_lastkey;move[6]+=1}
	if !keyboard_check(vk_numpad7){move[7]=0} else {if key!=keyboard_lastkey{move[7]=0}key=keyboard_lastkey;move[7]+=1}
	if !keyboard_check(vk_numpad8){move[8]=0} else {if key!=keyboard_lastkey{move[8]=0}key=keyboard_lastkey;move[8]+=1}
	if !keyboard_check(vk_numpad9){move[9]=0} else {if key!=keyboard_lastkey{move[9]=0}key=keyboard_lastkey;move[9]+=1}
	if !keyboard_check(ord("Q")){
		move[10] = 0;
	} else {
		if key != keyboard_lastkey {
			move[10] = 0
		}
		key = keyboard_lastkey;
		move[10] = move[10] + 1;
	}
	if !keyboard_check(ord("W")){move[11]=0} else {if key!=keyboard_lastkey{move[11]=0}key=keyboard_lastkey;move[11]+=1}
	if !keyboard_check(ord("A")){move[12]=0} else {if key!=keyboard_lastkey{move[12]=0}key=keyboard_lastkey;move[12]+=1}
	if !keyboard_check(ord("S")){move[13]=0} else {if key!=keyboard_lastkey{move[13]=0}key=keyboard_lastkey;move[13]+=1}
}
moved=0