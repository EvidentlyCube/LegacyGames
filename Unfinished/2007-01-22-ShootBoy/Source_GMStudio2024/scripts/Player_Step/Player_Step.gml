function Player_Step() {
	if global.pause=0{
		if engine = 1 {
			Engine_1();
		} else if engine = 2 {
			Engine_2();
		} else {
			Engine_3();
		}
	
		if stam1<stam1max{stam1+=stam1rec} else {stam1=stam1max}
		if stam2<stam2max{stam2+=stam2rec} else {stam2=stam2max}
		if stam3<stam3max{stam3+=stam3rec} else {stam3=stam3max}
		if stam4<stam4max{stam4+=stam4rec} else {stam4=stam4max}
		stam1w8+=1
		stam2w8+=1
		stam3w8+=1
		stam4w8+=1
	}
	if hp<=0{game_restart()}
	if keyboard_check_pressed(ord("P")){global.pause=1}
	if keyboard_check_released(ord("P")){global.pause=0}



}
