function Engine_2() {
	if global.pause=0{
	if keyboard_check(vk_up){if movy>=-spd{movy-=acc}}
	if keyboard_check(vk_down){if movy<=spd{movy+=acc}}
	if keyboard_check(vk_left){if movx>=-spd{movx-=acc}}
	if keyboard_check(vk_right){if movx<=spd{movx+=acc}}
	if !place_meeting(x+movx/100,y,Enemy_Wall){x+=movx/100} else{movx=0}
	if !place_meeting(x,y+movy/100,Enemy_Wall){y+=movy/100} else{movy=0}
	if !keyboard_check(vk_left) && !keyboard_check(vk_right){movx-=sign(movx)*acc}
	if !keyboard_check(vk_up) && !keyboard_check(vk_down){movy-=sign(movy)*acc}
	}
	if x<5{x=5;movx=0}
	if x>245{x=245;movx=0}
	if y<5{y=5;movy=0}
	if y>235{y=235;movy=0}



}
