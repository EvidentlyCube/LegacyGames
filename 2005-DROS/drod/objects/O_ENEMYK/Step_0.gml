if place_meeting(x,y,O_WEAPON){kill=1}
if kill=1{instance_destroy();ran=floor(random(3))
if ran=0{sound_play(SND_KILL1)}
if ran=1{sound_play(SND_KILL2)}
if ran=2{sound_play(SND_KILL3)}
}

if global.turn=1{
	if dir=0{ix=0;iy=-16}
	if dir=1{ix=16;iy=-16}
	if dir=2{ix=16;iy=0}
	if dir=3{ix=16;iy=16}
	if dir=4{ix=0;iy=16}
	if dir=5{ix=-16;iy=16}
	if dir=6{ix=-16;iy=0}
	if dir=7{ix=-16;iy=-16}
	if place_free(x+ix,y+iy){if place_meeting(x,y,O_MISCG){ide=instance_place(x,y,O_MISCG);ide.solid=true;ide.ende=1}x+=ix;y+=iy} else {dir+=1}
	if dir=8{dir=0}
	image_single=dir
}