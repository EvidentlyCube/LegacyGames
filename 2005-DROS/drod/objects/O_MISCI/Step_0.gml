if global.turn = 1 && x = O_WEAPON.x && y = O_WEAPON.y {
	while open[a] != 0{
		global.a = open[a];
	    with O_MISCJ {
	        if type = global.a{
	            solid = 0;
				visible = 0
	        }
	    }
		a+=1
		sound_play(SND_ORB1)
	}

	a = 0
	while close[a] != 0{
		global.a = close[a];
	    with O_MISCJ {
	        if type = global.a{
				solid = 1;
				visible = 1;
	        } 
	    }
		a+=1
		sound_play(SND_ORB1)
	}

	a = 0
	while togle[a] != 0 {
		global.a = togle[a];
	    with O_MISCJ {
	        if type = global.a{
				if solid = 0{
					solid = 1;
					visible = 1;
				} else {
					solid = 0;
					visible = 0;
				}
	        } 
	    }
		a += 1
		sound_play(SND_ORB1)
	}
	a = 0
}
