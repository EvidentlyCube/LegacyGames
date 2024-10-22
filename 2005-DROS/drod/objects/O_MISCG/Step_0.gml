if place_meeting(x,y+16,O_PIT) && !place_meeting(x,y+16,O_MISCD) && !place_meeting(x,y+16,O_MISCG){image_single=1} else {image_single=0}
if ende=1{instance_destroy();instance_create(x,y,O_PIT);instance_create(x,y,O_EFFECTB);sound_play(SND_TRAP)}
