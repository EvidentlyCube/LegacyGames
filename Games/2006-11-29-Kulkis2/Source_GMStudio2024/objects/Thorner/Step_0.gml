if move=0{
x=floor(x/20)*20
y=floor(y/20)*20
 if place_meeting(x+ix,y+iy,SolidWalls){ax=ix;ay=iy;
  if !place_meeting(x+iy,y+ix,SolidWalls){
   if !place_meeting(x-iy,y-ix,SolidWalls){
    ran=floor(random(2))
    if ran=0{ix=ay;iy=ax}
    if ran=1{ix=ay*-1;iy=ax*-1}
   } else {ix=ay;iy=ax}
  } else {if !place_meeting(x-iy,y-ix,SolidWalls){ix=ay*-1;iy=ax*-1} else {ix*=-1;iy*=-1}}
 }
 if !place_meeting(x+ix,y+iy,SolidWalls){ax=ix;ay=iy;move=1;
  if ax!=0{ax-=ix/10;x+=ix/10}
 if ay!=0{ay-=iy/10;y+=iy/10}}
}

if move=1{
 if ax!=0{ax-=ix/10;x+=ix/10}
 if ay!=0{ay-=iy/10;y+=iy/10}
 if ax=0 && ay=0{move=0}
}
