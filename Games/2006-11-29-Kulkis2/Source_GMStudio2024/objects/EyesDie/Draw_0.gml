x+=ix
y+=iy
iy+=0.2
rote+=rot
draw_sprite_ext(S_Eyes,0,x,y,1,1,rote+angle,c_white,1)

if y>room_height+20{instance_destroy()}