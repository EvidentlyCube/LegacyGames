if global.pause=0{
image_speed=0.3
czo+=czum
x+=sin(czo)*bond-0.2
y+=cos(czo)*bond


if hp<=0{repeat(10){IN_Flame(x,y,random(360))}Player.xp+=xp;instance_destroy()}

if x<-10{instance_destroy()}
} else {image_speed=0}
