if global.pause=0{
x-=0.3
y-=sign(y-Player.y)/10

if hp<=0{repeat(10){IN_Flame(x,y,random(360))}Player.xp+=xp;instance_destroy()}
czo+=1
if czo=4{IN_Flame(x,y,random(0+random(20)-random(20)));czo=0}

if x<-10{instance_destroy()}}
