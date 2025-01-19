dir=0
timer=0
if place_meeting(x,y,Left){dir=2;angle=dir*90}
if place_meeting(x,y,Right){dir=0;angle=dir*90}
if place_meeting(x,y,Up){dir=1;angle=dir*90}
if place_meeting(x,y,Down){dir=3;angle=dir*90}

val=0

ringe=0
liner=0
