function SC_Small_Mover2() {
	if mover>0 && mover<50{
	mover+=1}
	if mover>=50{
	if !place_meeting(x+ix,y+iy,SolidWalls) && !place_meeting(x+ix,y+iy,Body){
	if mover=50{sonpla(Shuru);mover=51}
	if ix>0{x+=2;ix-=2}
	if iy>0{y+=2;iy-=2}
	if ix<0{x-=2;ix+=2}
	if iy<0{y-=2;iy+=2}
	if ix=0 && iy=0{mover=0}} else {mover=0}
	}



}
