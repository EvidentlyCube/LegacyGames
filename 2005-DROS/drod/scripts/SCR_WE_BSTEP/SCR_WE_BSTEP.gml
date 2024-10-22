function SCR_WE_BSTEP() {
	if dire!=0{
	global.can=0
	    if dir=0{x=O_PLAYER.x;y=O_PLAYER.y-16}
	    if dir=1{x=O_PLAYER.x+16;y=O_PLAYER.y-16}
	    if dir=2{x=O_PLAYER.x+16;y=O_PLAYER.y}
	    if dir=3{x=O_PLAYER.x+16;y=O_PLAYER.y+16}
	    if dir=4{x=O_PLAYER.x;y=O_PLAYER.y+16}
	    if dir=5{x=O_PLAYER.x-16;y=O_PLAYER.y+16}
	    if dir=6{x=O_PLAYER.x-16;y=O_PLAYER.y}
	    if dir=7{x=O_PLAYER.x-16;y=O_PLAYER.y-16}
	    if place_meeting(x,y,all){deleter=instance_position(x,y,all);deleter.kill=1}
	    if dire=2{dir+=1}
	    if dire=-2{dir-=1}
	    if dire>0{dire-=1}
	    if dire<0{dire+=1}
	}

	if dire!=0{
	global.can=0
	    if dir=0{x=O_PLAYER.x;y=O_PLAYER.y-16}
	    if dir=1{x=O_PLAYER.x+16;y=O_PLAYER.y-16}
	    if dir=2{x=O_PLAYER.x+16;y=O_PLAYER.y}
	    if dir=3{x=O_PLAYER.x+16;y=O_PLAYER.y+16}
	    if dir=4{x=O_PLAYER.x;y=O_PLAYER.y+16}
	    if dir=5{x=O_PLAYER.x-16;y=O_PLAYER.y+16}
	    if dir=6{x=O_PLAYER.x-16;y=O_PLAYER.y}
	    if dir=7{x=O_PLAYER.x-16;y=O_PLAYER.y-16}
	    if place_meeting(x,y,all){deleter=instance_position(x,y,all);deleter.kill=1}
	    if dire=2{dir+=1}
	    if dire=-2{dir-=1}
	    if dire>0{dire-=1}
	    if dire<0{dire+=1}
	}

	if dire=0{global.can=1}



}
