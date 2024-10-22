kill=0
move=0
ix=0
iy=0
dir=floor(random(8))
if place_meeting(x,y,O_MA_EYEUP){dir=0;yx=0;yy=-16}
if place_meeting(x,y,O_MA_EYEUR){dir=1;yx=16;yy=-16}
if place_meeting(x,y,O_MA_EYERI){dir=2;yx=16;yy=0}
if place_meeting(x,y,O_MA_EYEDR){dir=3;yx=16;yy=16}
if place_meeting(x,y,O_MA_EYEDO){dir=4;yx=0;yy=16}
if place_meeting(x,y,O_MA_EYEDL){dir=5;yx=-16;yy=16}
if place_meeting(x,y,O_MA_EYELE){dir=6;yx=-16;yy=0}
if place_meeting(x,y,O_MA_EYEUL){dir=7;yx=-16;yy=-16}
image_single=dir
