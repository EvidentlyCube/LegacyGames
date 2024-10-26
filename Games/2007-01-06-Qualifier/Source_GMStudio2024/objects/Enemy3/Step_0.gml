bla=(Player.y-y)/100
x-=max(1,4-abs(bla)/20)
y+=bla
if hp<=0{instance_destroy();Xplode(x,y);;global.scr+=0.001}
if hit>0{hit-=0.1}
if x<-100{instance_destroy();global.limit-=1}
