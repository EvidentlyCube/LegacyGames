global.mex=x
global.mey=y
val=0
with (ii_objectivers) {if point_distance(x,y,global.mex,global.mey)=20{val+=1;image_index=val}}
image_index=val
image_speed=0
