function Weapon_11() {
	var cret, weap;
	/*Horizontal Shots*/
	if stam1>=10 && stam1w8>5{
	stam1-=10
	stam1w8=0
	cret=instance_create(x,y-2,Shot_1)
	cret.cut=w_cut
	cret.pow=w_pow
	cret.dx=1
	cret.dy=0
	cret=instance_create(x,y+2,Shot_1)
	cret.cut=w_cut
	cret.pow=w_pow
	cret.dx=1
	cret.dy=0
	}

	/*Horizontal Laser*/
	if stam3>=50 && stam3w8>1{
	stam3-=40
	stam3w8=0
	cret=instance_create(x,y,Shot_3)
	cret.pow=w_pow
	}



}
