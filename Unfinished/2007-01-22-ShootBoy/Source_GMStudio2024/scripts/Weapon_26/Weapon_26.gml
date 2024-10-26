function Weapon_26() {
	var cret, weap;
	/*Horizontal Minidoublegun*/
	if stam1>=3 && stam1w8>3{
	stam1-=3
	stam1w8=0
	cret=instance_create(x,y-2,Shot_2)
	cret.cut=w_cut
	cret.pow=w_pow/2
	cret.dx=1+random(0.1)-random(0.1)
	cret.dy=0+random(0.1)-random(0.1)
	cret=instance_create(x,y+2,Shot_2)
	cret.cut=w_cut
	cret.pow=w_pow/2
	cret.dx=1+random(0.1)-random(0.1)
	cret.dy=0+random(0.1)-random(0.1)
	}

	/*Upper Diagonal Minigun*/
	if stam2>=2 && stam2w8>1{
	stam2-=2
	stam2w8=1
	cret=instance_create(x,y,Shot_2)
	cret.cut=w_cut
	cret.pow=w_pow/2
	cret.dx=1+random(0.1)-random(0.3)
	cret.dy=-1+random(0.1)-random(0.1)
	cret.sprite_index=S_Shot2

	/*Down Diagonal Minigun*/
	cret=instance_create(x,y,Shot_2)
	cret.cut=w_cut
	cret.pow=w_pow/2
	cret.dx=1+random(0.1)-random(0.1)
	cret.dy=1+random(0.1)-random(0.1)
	cret.sprite_index=S_Shot3
	}

	/*Horizontal Laser*/
	if stam3>=50 && stam3w8>1{
	stam3-=40
	stam3w8=0
	cret=instance_create(x,y,Shot_3)
	cret.pow=w_pow
	}

	/*Seeker*/
	if stam4>=5 && stam4w8>3{
	stam4-=5
	stam4w8=0
	weap=instance_nearest(x,y,Enemies)
	weap.hp-=w_pow*3
	cret=instance_create(x,y,Shot_5)
	cret.ix=weap.x
	cret.iy=weap.y
	}



}
