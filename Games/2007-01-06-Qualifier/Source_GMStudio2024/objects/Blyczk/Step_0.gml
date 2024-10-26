x-=2
if hp<=0{instance_destroy();Xplode(x,y);global.scr+=0.05}
if hit>0{hit-=0.1}
image_index=floor(hp/5)
if x<-100{instance_destroy();global.limit-=2}
