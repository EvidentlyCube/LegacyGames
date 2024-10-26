if collision_point(mouse_x,mouse_y,id,1,0){instance_destroy()}
image_angle+=hspeed
if x>room_width && hspeed>0{hspeed*=-1}
if x<0 && hspeed<0{hspeed*=-1}
if y>650{instance_destroy();global.lv-=1}
