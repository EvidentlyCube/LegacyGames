if a>10{
sound_play(ciuf)
a=0
cret=instance_create(x,y,Bullet)
cret.hspeed=2
if global.pow>0{
cret=instance_create(x,y,Bullet)
cret.vspeed=-3
cret=instance_create(x,y,Bullet)
cret.vspeed=3
if global.pow>1{
cret=instance_create(x,y,Bullet)
cret.vspeed=-2
cret.hspeed=-1
cret=instance_create(x,y,Bullet)
cret.vspeed=2
cret.hspeed=-1
if global.pow>2{
cret=instance_create(x,y,Bullet)
cret.vspeed=-1
cret.hspeed=-3
cret=instance_create(x,y,Bullet)
cret.vspeed=1
cret.hspeed=-3
if global.pow>3{
cret=instance_create(x,y,Bullet)
cret.vspeed=-4+random(5)-random(5)
cret.hspeed=-5+random(3)-random(3)
cret=instance_create(x,y,Bullet)
cret.vspeed=4+random(5)-random(5)
cret.hspeed=-5+random(3)-random(3)
if global.pow>4{
cret=instance_create(x,y,Bullet)
cret.vspeed=-5+random(5)-random(5)
cret.hspeed=-7+random(3)-random(3)
cret=instance_create(x,y,Bullet)
cret.vspeed=5+random(5)-random(5)
cret.hspeed=-7+random(3)-random(3)
if global.pow>5{
cret=instance_create(x,y,Bullet)
cret.vspeed=-6+random(5)-random(5)
cret.hspeed=-12+random(3)-random(3)
cret=instance_create(x,y,Bullet)
cret.vspeed=6+random(5)-random(5)
cret.hspeed=-12+random(3)-random(3)
if global.pow>6{
cret=instance_create(x,y,Bullet)
cret.vspeed=-1
cret=instance_create(x,y,Bullet)
cret.vspeed=1
if global.pow>7{
cret=instance_create(x,y,Bullet)
cret.vspeed=random(5)-random(5)
cret.hspeed=-12+random(3)-random(3)
cret=instance_create(x,y,Bullet)
cret.vspeed=random(5)-random(5)
cret.hspeed=-12+random(3)-random(3)
if global.pow>8{
cret=instance_create(x,y,Bullet)
cret.vspeed=random(5)-random(5)
cret.hspeed=-12+random(3)-random(3)
cret=instance_create(x,y,Bullet)
cret.vspeed=random(5)-random(5)
cret.hspeed=-12+random(3)-random(3)
if global.pow>9{
cret=instance_create(x,y,Bullet)
cret.vspeed=random(5)-random(5)
cret.hspeed=-12+random(3)-random(3)
cret=instance_create(x,y,Bullet)
cret.vspeed=random(5)-random(5)
cret.hspeed=-12+random(3)-random(3)
if global.pow>10{
cret=instance_create(x,y-10,Bullet)
cret.hspeed=-12
cret=instance_create(x,y+10,Bullet)
cret.hspeed=-12
}}}}}}}}}}}
global.accmax+=ceil(global.pow*2+1)
}
