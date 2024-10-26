function Arrowing(argument0, argument1) {
	var ide,koko,ix,iy;
	ix=argument0
	iy=argument1
	ide=instance_place(x,y,Arrows)
	if ide>0{
	   koko=ide.image_index
	   if koko=0{if ix=-1{return(0);exit}}
	   if koko=1{if (ix=-1 && iy=0) or (ix=-1 && iy=-1) or (ix=0 && iy=-1){return(0);exit}}
	   if koko=2{if iy=-1{return(0);exit}}
	   if koko=3{if (ix=1 && iy=0) or (ix=1 && iy=-1) or (ix=0 && iy=-1){return(0);exit}}
	   if koko=4{if ix=1{return(0);exit}}
	   if koko=5{if (ix=1 && iy=0) or (ix=1 && iy=1) or (ix=0 && iy=1){return(0);exit}}
	   if koko=6{if iy=1{return(0);exit}}
	   if koko=7{if (ix=-1 && iy=0) or (ix=-1 && iy=1) or (ix=0 && iy=1){return(0);exit}}
	}
	ide=instance_place(x+ix*20,y+iy*20,Arrows)
	if ide>0{
	   koko=ide.image_index
	   if koko=0{if ix=-1{return(0);exit}}
	   if koko=1{if (ix=-1 && iy=0) or (ix=-1 && iy=-1) or (ix=0 && iy=-1){return(0);exit}}
	   if koko=2{if iy=-1{return(0);exit}}
	   if koko=3{if (ix=1 && iy=0) or (ix=1 && iy=-1) or (ix=0 && iy=-1){return(0);exit}}
	   if koko=4{if ix=1{return(0);exit}}
	   if koko=5{if (ix=1 && iy=0) or (ix=1 && iy=1) or (ix=0 && iy=1){return(0);exit}}
	   if koko=6{if iy=1{return(0);exit}}
	   if koko=7{if (ix=-1 && iy=0) or (ix=-1 && iy=1) or (ix=0 && iy=1){return(0);exit}}
	}
	return(1)



}
