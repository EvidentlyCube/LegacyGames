function crop_vars() {
	switch(item){
	    case(2):
	        varz[0]=(varz[0]+9) mod 9
	    break;
	    case(3):
	        varz[0]=(varz[0]+9) mod 9
	    break;
	    case(16):
	        varz[0]=(varz[0]+4) mod 4
	    break;
	    case(17):
	        varz[0]=(varz[0]+2) mod 2
	    break;
	    case(18):
	        varz[0]=(varz[0]+2) mod 2
	    break;
	    case(19):
	        varz[0]=(varz[0]+4) mod 4
	    break;
	    case(20):
	        varz[0]=(varz[0]+4) mod 4
	    break;
	    case(21):
	        varz[0]=(varz[0]+4) mod 4
	    break;
	    case(22):
	        varz[0]=(varz[0]+4) mod 4
	    break;
	    case(48):
	        varz[0]=(varz[0]+36) mod 36
	        varz[2]=(varz[2]+2) mod 2
	    break;
	    case(49):
	        varz[1]=(varz[1]+9) mod 9
	    break;
	    case(50):
	        varz[1]=(varz[1]+9) mod 9
	        varz[2]=(varz[2]+4) mod 4
	    break;
	    case(52):
	        varz[0]=(varz[0]+4) mod 4
	    break;
	}



}
