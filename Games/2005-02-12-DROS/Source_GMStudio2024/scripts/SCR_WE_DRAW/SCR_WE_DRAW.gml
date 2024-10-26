function SCR_WE_DRAW() {
	if current=0{
	    if dir=0{draw_sprite(S_WEAPONA,dir,O_PLAYER.x,O_PLAYER.y-16);x=O_PLAYER.x;y=O_PLAYER.y-16}
	    if dir=1{draw_sprite(S_WEAPONA,dir,O_PLAYER.x+16,O_PLAYER.y-16);x=O_PLAYER.x+16;y=O_PLAYER.y-16}
	    if dir=2{draw_sprite(S_WEAPONA,dir,O_PLAYER.x+16,O_PLAYER.y);x=O_PLAYER.x+16;y=O_PLAYER.y}
	    if dir=3{draw_sprite(S_WEAPONA,dir,O_PLAYER.x+16,O_PLAYER.y+16);x=O_PLAYER.x+16;y=O_PLAYER.y+16}
	    if dir=4{draw_sprite(S_WEAPONA,dir,O_PLAYER.x,O_PLAYER.y+16);x=O_PLAYER.x;y=O_PLAYER.y+16}
	    if dir=5{draw_sprite(S_WEAPONA,dir,O_PLAYER.x-16,O_PLAYER.y+16);x=O_PLAYER.x-16;y=O_PLAYER.y+16}
	    if dir=6{draw_sprite(S_WEAPONA,dir,O_PLAYER.x-16,O_PLAYER.y);x=O_PLAYER.x-16;y=O_PLAYER.y}
	    if dir=7{draw_sprite(S_WEAPONA,dir,O_PLAYER.x-16,O_PLAYER.y-16);x=O_PLAYER.x-16;y=O_PLAYER.y-16}
	}
	if current=1{
	    if dir=0{draw_sprite(S_WEAPONB,dir,O_PLAYER.x,O_PLAYER.y-16);x=O_PLAYER.x;y=O_PLAYER.y-16}
	    if dir=1{draw_sprite(S_WEAPONB,dir,O_PLAYER.x+16,O_PLAYER.y-16);x=O_PLAYER.x+16;y=O_PLAYER.y-16}
	    if dir=2{draw_sprite(S_WEAPONB,dir,O_PLAYER.x+16,O_PLAYER.y);x=O_PLAYER.x+16;y=O_PLAYER.y}
	    if dir=3{draw_sprite(S_WEAPONB,dir,O_PLAYER.x+16,O_PLAYER.y+16);x=O_PLAYER.x+16;y=O_PLAYER.y+16}
	    if dir=4{draw_sprite(S_WEAPONB,dir,O_PLAYER.x,O_PLAYER.y+16);x=O_PLAYER.x;y=O_PLAYER.y+16}
	    if dir=5{draw_sprite(S_WEAPONB,dir,O_PLAYER.x-16,O_PLAYER.y+16);x=O_PLAYER.x-16;y=O_PLAYER.y+16}
	    if dir=6{draw_sprite(S_WEAPONB,dir,O_PLAYER.x-16,O_PLAYER.y);x=O_PLAYER.x-16;y=O_PLAYER.y}
	    if dir=7{draw_sprite(S_WEAPONB,dir,O_PLAYER.x-16,O_PLAYER.y-16);x=O_PLAYER.x-16;y=O_PLAYER.y-16}
	}



}
