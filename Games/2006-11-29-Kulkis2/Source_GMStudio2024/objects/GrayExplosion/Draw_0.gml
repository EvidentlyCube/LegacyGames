draw_sprite_ext(S_GrayExplosion,0,x,y,size,size,rote,c_white,image_alpha)
if size<2{size+=(2-size)/10}
if size>0.9{image_alpha-=0.1}
if image_alpha<=0{instance_destroy()}
rote+=roter
