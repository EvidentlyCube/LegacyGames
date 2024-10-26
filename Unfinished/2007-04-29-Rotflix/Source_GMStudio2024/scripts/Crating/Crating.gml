function Crating(argument0, argument1) {
	var ide,koko,ix,iy;
	ix=argument0
	iy=argument1
	ide=instance_place(x+ix*20,y+iy*20,Crate)
	if ide>0{
	   if !place_meeting(ide.x+ix*20,ide.y+iy*20,Solid) && !place_meeting(ide.x+ix*20,ide.y+iy*20,Player) {with (ide){oldx=x;oldy=y;x+=ix*20;y+=iy*20;draw=20;return(1);exit}}
	}
	return (0)



}
