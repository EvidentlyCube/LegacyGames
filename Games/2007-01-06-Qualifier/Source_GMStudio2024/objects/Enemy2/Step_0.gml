if y<125+sprite_height/2{if vspeed<0{vspeed*=-1.1}}
if y>639-sprite_height/2{if vspeed>0{vspeed*=-1.1}}
if hp<=0{instance_destroy();Xplode(x,y);global.scr+=0.0001}
if hit>0{hit-=0.1}
if x<-100{instance_destroy();global.limit-=1}
