function Sc_Mouse_Select() {
	/* Wybieranie opcji przy pomocy myszki*/
	var ix,iy;
	ix=floor(mouse_x/20)
	iy=floor((mouse_y-80)/20)
	if ix=0{
	switch (iy){
	case (0): if p_shave[0]=2{p_atk=0;p_datk=0;exit;}
	case (1): if p_shave[1]=2{p_atk=1;p_datk=1;exit;}
	case (2): if p_shave[2]=2{p_atk=2;p_datk=2;exit;}
	case (3): if p_shave[3]=2{p_atk=3;p_datk=3;exit;}
	case (4): if p_shave[4]=2{p_move=11;p_dmov=4;exit;}
	case (5): if p_shave[5]=2{p_move=12;p_dmov=5;exit;}
	case (6): if p_shave[6]=2{p_move=13;p_dmov=6;exit;}
	case (7): if p_shave[7]=2{p_move=14;p_dmov=7;exit;}
	case (8): if p_shave[8]=2{p_move=15;p_dmov=8;exit;}
	case (9): if p_shave[9]=2{p_move=16;p_dmov=9;exit;}
	case (10): if p_shave[10]=2{p_atk=4;p_datk=10;exit;}
	case (11): if p_shave[11]=2{p_atk=5;p_datk=11;exit;}
	case (12): if p_shave[12]=2{p_atk=6;p_datk=12;exit;}
	case (13): if p_shave[13]=2{p_atk=7;p_datk=13;exit;}
	case (14): if p_shave[14]=2{p_atk=8;p_datk=14;exit;}
	}
	}



}
