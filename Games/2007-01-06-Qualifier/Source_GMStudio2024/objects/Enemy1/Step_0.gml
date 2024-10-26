vspeed+=(Player.y-y)/1000
hspeed-=0.03
image_angle+=10
if y<125+sprite_width/2{if vspeed<0{vspeed*=-1}}
if y>639-sprite_width/2{if vspeed>0{vspeed*=-1}}
if hp<=0{instance_destroy();Xplode(x,y);global.scr+=0.0001}
if hit>0{hit-=0.1}
if x<-100{instance_destroy();global.limit-=1}
