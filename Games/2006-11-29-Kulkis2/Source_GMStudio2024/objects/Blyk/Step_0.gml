if move=0
 {
 x=floor(x/20)*20
 y=floor(y/20)*20
 ax=ix
 ay=iy
 a[0]=0
 a[1]=0
 a[2]=0
 a[3]=0
 if !place_meeting(x+iy,y+ix,SolidWalls){a[0]=1}
 if !place_meeting(x-iy,y-ix,SolidWalls){a[1]=1}
 if !place_meeting(x+ix,y+iy,SolidWalls){a[2]=1}
 if !place_meeting(x-ix,y-iy,SolidWalls){a[3]=1}
 if a[0]=1 or a[1]=1 or a[2]=1  {
 b=0
  for (ran=floor(random(3));b<=0;ran=floor(random(3))){
   if ran=0 && a[0]=1{b=1;ix=ay;iy=ax}
   if ran=1 && a[1]=1{b=1;ix=ay*-1;iy=ax*-1}
   if ran=2 && a[2]=1{b=1;ix=ax;iy=ay} 
   }
  } else  {if a[3]=1 && a[2]=0{b=1;ix=ax*-1;iy=ay*-1}}
 if place_free(x+ix,y+iy){ax=ix;ay=iy;move=1;
  if ax!=0{ax-=ix/10;x+=ix/10}
  if ay!=0{ay-=iy/10;y+=iy/10}}
}

if move=1{
 if ax!=0{ax-=ix/10;x+=ix/10}
 if ay!=0{ay-=iy/10;y+=iy/10}
 if ax=0 && ay=0{move=0}
}

