if global.pause=0{
sox+=0.3
move+=sox
repeat (move){
x+=dx
y+=dy
if place_meeting(x,y,Enemies){
Bullet_Hit(instance_place(x,y,Enemies))
}
}
if x>250{instance_destroy()}
}
