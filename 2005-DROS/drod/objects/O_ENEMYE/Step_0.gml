if place_meeting(x,y,O_WEAPON){kill=1}
if kill=1{
	instance_destroy()
}
if global.turn=1{
image_single+=1
if image_index=6{instance_create(x,y,O_ENEMYA);instance_destroy()}}