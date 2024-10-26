function Block_Align() {
	/*
	Aligning Blocks in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Block_Align()
	*/

	var u,d,l,r;
	u=0
	d=0
	l=0
	r=0
	if place_meeting(x+25,y,Blocker) && group>0{with (instance_place(x+25,y,Blocker)){if color=other.color && group=other.group{r=1}}}
	if place_meeting(x-25,y,Blocker) && group>0{with (instance_place(x-25,y,Blocker)){if color=other.color && group=other.group{l=1}}}
	if place_meeting(x,y+25,Blocker) && group>0{with (instance_place(x,y+25,Blocker)){if color=other.color && group=other.group{d=1}}}
	if place_meeting(x,y-25,Blocker) && group>0{with (instance_place(x,y-25,Blocker)){if color=other.color && group=other.group{u=1}}}

	image_speed=0
	if u=0 && d=0 && l=0 && r=0 {image_index=0}
	if u=0 && d=0 && l=0 && r=1 {image_index=1}
	if u=0 && d=1 && l=0 && r=0 {image_index=2}
	if u=0 && d=0 && l=1 && r=0 {image_index=3}
	if u=1 && d=0 && l=0 && r=0 {image_index=4}
	if u=0 && d=0 && l=1 && r=1 {image_index=5}
	if u=1 && d=1 && l=0 && r=0 {image_index=6}
	if u=0 && d=1 && l=0 && r=1 {image_index=7}
	if u=0 && d=1 && l=1 && r=0 {image_index=8}
	if u=1 && d=0 && l=1 && r=0 {image_index=9}
	if u=1 && d=0 && l=0 && r=1 {image_index=10}
	if u=0 && d=1 && l=1 && r=1 {image_index=11}
	if u=1 && d=1 && l=1 && r=0 {image_index=12}
	if u=1 && d=0 && l=1 && r=1 {image_index=13}
	if u=1 && d=1 && l=0 && r=1 {image_index=14}
	if u=1 && d=1 && l=1 && r=1 {image_index=15}



}
