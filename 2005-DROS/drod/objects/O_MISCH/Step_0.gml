if place_meeting(x,y,O_PLAYER) && a=0{
	a=1;
	b=1;
	saveCheckpoint();
} else { a=0 }
if b>0{
	image_single=1;
	b+=1
}
if b=50{
	image_single=0;
	b=0
}
