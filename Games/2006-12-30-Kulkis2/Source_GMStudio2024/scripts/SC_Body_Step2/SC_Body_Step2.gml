function SC_Body_Step2() {
	if move=1 && land!=2{
	if movex>0{x+=2;movex-=2}
	if movex<0{x-=2;movex+=2}
	if movey>0{y+=2;movey-=2}
	if movey<0{y-=2;movey+=2}
	if movex=0 && movey=0{move=0}
	}

	if move=1 && land=2{
	if movex>0{x+=1;movex-=1}
	if movex<0{x-=1;movex+=1}
	if movey>0{y+=1;movey-=1}
	if movey<0{y-=1;movey+=1}
	if movex=0 && movey=0{move=0}
	}



}
