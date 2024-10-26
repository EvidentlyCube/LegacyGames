if place_meeting(x,y,O_WEAPON){
	kill=1
}
if kill=1{
	instance_destroy();
	ran=floor(random(3));
	
	if (global.eye_sfx = 0) {
		if ran=0{sound_play(SND_KILL1)}
		else if ran=1{sound_play(SND_KILL2)}
		else {sound_play(SND_KILL3)}
		global.eye_sfx = 1
	}
move=10
}

if global.turn=1{
	if move<2{
	    while move=0{
			if place_meeting(x+ix+yx,y+iy+yy,O_PLAYER){
				move=2;
				sound_play(SND_EYE)
			} else {
				if !place_meeting(x+ix+yx,y+iy+yy,O_WALL){
					ix+=yx;
					iy+=yy;
				} else {
					move=1
				}
			}
		}
	    ix=0
	    iy=0
	    if move=1{
			move=0
		}
	}
	if move=2{
		ix=O_PLAYER.x-x
		iy=O_PLAYER.y-y
		if ix!=0{yx=abs(16/ix);ix=round(ix*yx)} else {ix=0}
		if iy!=0{yy=abs(16/iy);iy=round(iy*yy)} else {iy=0}
		if ix=0 && iy<0 {image_single=0}
		if ix>0 && iy<0 {image_single=1}
		if ix>0 && iy=0 {image_single=2}
		if ix>0 && iy>0 {image_single=3}
		if ix=0 && iy>0 {image_single=4}
		if ix<0 && iy>0 {image_single=5}
		if ix<0 && iy=0 {image_single=6}
		if ix<0 && iy<0 {image_single=7}
	
		if place_free(x+ix,y+iy){
			if place_meeting(x,y,O_MISCG){
				ide=instance_place(x,y,O_MISCG);
				ide.solid=true;
				ide.ende=1
			}
			x+=ix;
			y+=iy
		} else {
			if place_free(x,y+iy){
				if place_meeting(x,y,O_MISCG){
					ide=instance_place(x,y,O_MISCG);
					ide.solid=true;
					ide.ende=1
				}
				y+=iy
			} else {
				if place_free(x+ix,y){
					if place_meeting(x,y,O_MISCG){
						ide=instance_place(x,y,O_MISCG);
						ide.solid=true;
						ide.ende=1
					}
					x+=ix
				}
			}
		}
	}
}
