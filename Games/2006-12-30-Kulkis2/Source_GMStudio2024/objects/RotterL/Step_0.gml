if ix=0 && iy=0{
if dir=0 {
if !place_meeting(x-20,y,SolidWalls){dir=3;ix=-20;exit} else {if !place_meeting(x,y-20,SolidWalls){iy=-20} else {if !place_meeting(x+20,y,SolidWalls){dir=1;exit} else {dir=2;exit}}}}
if dir=1 {
if !place_meeting(x,y-20,SolidWalls){dir=0;iy=-20;exit} else {if !place_meeting(x+20,y,SolidWalls){ix=20} else {if !place_meeting(x,y+20,SolidWalls){dir=2;exit} else {dir=3;exit}}}}
if dir=2 {
if !place_meeting(x+20,y,SolidWalls){dir=1;ix=20;exit} else {if !place_meeting(x,y+20,SolidWalls){iy=20} else {if !place_meeting(x-20,y,SolidWalls){dir=3;exit} else {dir=0;exit}}}}
if dir=3 {
if !place_meeting(x,y+20,SolidWalls){dir=2;iy=20;exit} else {if !place_meeting(x-20,y,SolidWalls){ix=-20} else {if !place_meeting(x,y-20,SolidWalls){dir=0;exit} else {dir=1;exit}}}}
}



if ix>0{ix-=2;x+=2}
if ix<0{ix+=2;x-=2}
if iy>0{iy-=2;y+=2}
if iy<0{iy+=2;y-=2}
