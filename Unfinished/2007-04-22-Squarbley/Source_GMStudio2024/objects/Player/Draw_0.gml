dir=point_direction(x,y-2,mouse_x,mouse_y)+90
draw_sprite(S_Body,0,x,y)
if point_distance(x,y-2,mouse_x,mouse_y)>4{
xpos=x+sin(degtorad(dir))*4
ypos=y+cos(degtorad(dir))*4-2
draw_sprite(S_Eyeback,0,xpos,ypos)} else {draw_sprite(S_Eyeback,0,mouse_x,mouse_y)}
if point_distance(x,y-2,mouse_x,mouse_y)>6{
xpos=xpos+sin(degtorad(dir))*2
ypos=ypos+cos(degtorad(dir))*2
Look.x=xpos
Look.y=ypos
Look.image_angle=dir-90
Look2.image_angle=0
draw_sprite(S_Pupil,0,xpos,ypos)}else{draw_sprite(S_Pupil,0,mouse_x,mouse_y);
Look.x=999
Look.y=999
Look.image_angle=0}
draw_sprite(S_Mouths,b,x,y)

Look2.x=x
Look2.y=y

puf+=0.1
draw_sprite(S_Cross,0,mouse_x,mouse_y)
draw_sprite(S_Cross,1,mouse_x-radtodeg(sin(puf))/25,mouse_y-radtodeg(sin(puf))/25)
draw_sprite(S_Cross,2,mouse_x+radtodeg(sin(puf))/25,mouse_y-radtodeg(sin(puf))/25)
draw_sprite(S_Cross,3,mouse_x+radtodeg(sin(puf))/25,mouse_y+radtodeg(sin(puf))/25)
draw_sprite(S_Cross,4,mouse_x-radtodeg(sin(puf))/25,mouse_y+radtodeg(sin(puf))/25)
