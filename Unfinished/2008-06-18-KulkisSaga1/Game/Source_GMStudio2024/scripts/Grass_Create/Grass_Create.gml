function Grass_Create() {
	if place_meeting(x+25,y,Wall){r=1} else {r=0}
	if place_meeting(x,y+25,Wall){d=1} else {d=0}
	if place_meeting(x-25,y,Wall){l=1} else {l=0}
	if place_meeting(x,y-25,Wall){u=1} else {u=0}



}
