function SCR_WALL_STEP() {
	if place_meeting(x,y,O_WEAPON){kill=2}
	if kill=2 && broke=1{instance_destroy();sound_play(SND_BREAK)}



}
