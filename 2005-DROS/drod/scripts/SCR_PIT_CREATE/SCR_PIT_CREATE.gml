function SCR_PIT_CREATE() {
	if !place_meeting(x,y-16,O_PIT){image_single=0}
	if place_meeting(x,y-16,O_PIT) && !place_meeting(x,y-32,O_PIT){image_single=1}
	if place_meeting(x,y-16,O_PIT) && place_meeting(x,y-32,O_PIT){image_single=2}



}
