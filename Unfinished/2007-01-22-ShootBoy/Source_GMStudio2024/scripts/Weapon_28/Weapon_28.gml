function Weapon_28() {
	var cret, weap;
	/*Horizontal Magidoublegun*/
	if stam1>=2 && stam1w8>2{
	stam1-=3
	stam1w8=0
	cret=instance_create(x,y-2,Shot_2)
	cret.cut=w_cut
	cret.pow=w_pow/1.5
	cret.dx=1+random(0.1)-random(0.1)
	cret.dy=0+random(0.1)-random(0.1)
	cret=instance_create(x,y+2,Shot_2)
	cret.cut=w_cut
	cret.pow=w_pow/1.5
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

	/*Horizontal Blazer*/
	if !instance_exists(Shot_4) && stam3>=25{
	cret=instance_create(x,y,Shot_4)
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