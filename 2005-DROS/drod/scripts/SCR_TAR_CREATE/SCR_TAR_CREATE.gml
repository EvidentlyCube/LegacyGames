function SCR_TAR_CREATE() {
	if place_meeting(x+16,y-16,O_MISCA){ur=1} else {ur=0}
	if place_meeting(x+16,y,O_MISCA){r=1} else {r=0}
	if place_meeting(x+16,y+16,O_MISCA){dr=1} else {dr=0}
	if place_meeting(x,y+16,O_MISCA){d=1} else {d=0}
	if place_meeting(x-16,y+16,O_MISCA){dl=1} else {dl=0}
	if place_meeting(x-16,y,O_MISCA){l=1} else {l=0}
	if place_meeting(x-16,y-16,O_MISCA){ul=1} else {ul=0}
	if place_meeting(x,y-16,O_MISCA){u=1} else {u=0}

	kill=0
	if u=0 && ur=0 && ul=0 && r=1 && dr=1 && d=1 && dl=0 && l=0 {image_single=0;die=0;exit}
	if u=0 && ur=0 && ul=0 && r=1 && dr=1 && d=1 && dl=1 && l=1 {image_single=1;die=1;exit}
	if u=0 && ur=0 && ul=0 && r=0 && dr=0 && d=1 && dl=1 && l=1 {image_single=2;die=0;exit}
	if u=1 && ur=1 && ul=0 && r=1 && dr=1 && d=1 && dl=0 && l=0 {image_single=3;die=1;exit}
	if u=1 && ur=1 && ul=1 && r=1 && dr=1 && d=1 && dl=1 && l=1 {image_single=4;die=0;exit}
	if u=1 && ur=0 && ul=1 && r=0 && dr=0 && d=1 && dl=1 && l=1 {image_single=5;die=0;exit}
	if u=1 && ur=1 && ul=0 && r=1 && dr=0 && d=0 && dl=0 && l=0 {image_single=6;die=0;exit}
	if u=1 && ur=1 && ul=1 && r=1 && dr=0 && d=0 && dl=0 && l=1 {image_single=7;die=1;exit}
	if u=1 && ur=0 && ul=1 && r=0 && dr=0 && d=0 && dl=0 && l=1 {image_single=8;die=0;exit}
	if u=1 && ur=1 && ul=1 && r=1 && dr=0 && d=1 && dl=1 && l=1 {image_single=9;die=0;exit}
	if u=1 && ur=1 && ul=1 && r=1 && dr=1 && d=1 && dl=0 && l=1 {image_single=10;die=0;exit}
	if u=1 && ur=0 && ul=1 && r=1 && dr=1 && d=1 && dl=1 && l=1 {image_single=11;die=0;exit}
	if u=1 && ur=1 && ul=0 && r=1 && dr=1 && d=1 && dl=1 && l=1 {image_single=12;die=0;exit}
	if u=1 && ur=0 && ul=1 && r=1 && dr=1 && d=1 && dl=0 && l=1 {image_single=13;die=0;exit}
	if u=1 && ur=1 && ul=0 && r=1 && dr=0 && d=1 && dl=1 && l=1 {image_single=14;die=0;exit}
	instance_destroy()
	instance_create(x,y,O_ENEMYF)



}
