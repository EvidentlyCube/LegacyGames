image_speed=6
dir=1
ran=0
ix=20
ax=20
ay=0
iy=0
if place_meeting(x,y,Left){ix=-20;ax=-20;iy=0;ay=0;dir=3}
if place_meeting(x,y,Up){ix=0;ax=0;iy=-20;ay=-20;dir=0}
if place_meeting(x,y,Down){ix=0;ax=0;iy=20;ay=20;dir=2}
move=0
