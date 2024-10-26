if place_meeting(x,y,O_WEAPON){kill=1}
if kill=1{instance_destroy();ran=floor(random(3))
if ran=0{sound_play(SND_KILL1)}
if ran=1{sound_play(SND_KILL2)}
if ran=2{sound_play(SND_KILL3)}
}

if global.can=1{
	if global.turn=1{
		if place_meeting(x,y,O_WEAPON){kill=1}
		if y>O_PLAYER.y{if place_free(x,y-16){if place_meeting(x,y,O_MISCG){ide=instance_place(x,y,O_MISCG);ide.solid=true;ide.ende=1}y-=16;exit}}
		if x<O_PLAYER.x{if place_free(x+16,y){if place_meeting(x,y,O_MISCG){ide=instance_place(x,y,O_MISCG);ide.solid=true;ide.ende=1}x+=16;exit}}
		if y<O_PLAYER.y{if place_free(x,y+16){if place_meeting(x,y,O_MISCG){ide=instance_place(x,y,O_MISCG);ide.solid=true;ide.ende=1}y+=16;exit}}
		if x>O_PLAYER.x{if place_free(x-16,y){if place_meeting(x,y,O_MISCG){ide=instance_place(x,y,O_MISCG);ide.solid=true;ide.ende=1}x-=16;exit}}
	}
}