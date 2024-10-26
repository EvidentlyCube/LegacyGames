function reBLAing() {
	image_speed=0
	var r,d,l,u;
	r=0
	d=0
	l=0
	u=0
	if place_meeting(x+48,y,object_index) or place_meeting(x+48,y,shmai){r=1}
	if place_meeting(x,y+48,object_index) or place_meeting(x,y+48,shmai){d=1}
	if place_meeting(x-48,y,object_index) or place_meeting(x-48,y,shmai){l=1}
	if place_meeting(x,y-48,object_index) or place_meeting(x,y-48,shmai){u=1}

	if r=0 && d=0 && l=0 && u=0 {image_index=0}
	if r=1 && d=0 && l=0 && u=0 {image_index=1}
	if r=0 && d=1 && l=0 && u=0 {image_index=2}
	if r=0 && d=0 && l=1 && u=0 {image_index=3}
	if r=0 && d=0 && l=0 && u=1 {image_index=4}
	if r=1 && d=0 && l=1 && u=0 {image_index=5}
	if r=0 && d=1 && l=0 && u=1 {image_index=6}
	if r=1 && d=1 && l=0 && u=0 {image_index=7}
	if r=0 && d=1 && l=1 && u=0 {image_index=8}
	if r=0 && d=0 && l=1 && u=1 {image_index=9}
	if r=1 && d=0 && l=0 && u=1 {image_index=10}
	if r=1 && d=1 && l=1 && u=0 {image_index=11}
	if r=0 && d=1 && l=1 && u=1 {image_index=12}
	if r=1 && d=0 && l=1 && u=1 {image_index=13}
	if r=1 && d=1 && l=0 && u=1 {image_index=14}
	if r=1 && d=1 && l=1 && u=1 {image_index=15}



}
