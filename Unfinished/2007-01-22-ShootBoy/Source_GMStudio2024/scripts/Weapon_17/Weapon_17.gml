function Weapon_17() {
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

	/*Upper Diagonal Shots*/
	if stam2>=10 && stam2w8>5{
	stam2-=10
	stam2w8=0
	cret=instance_create(x-1,y-2,Shot_1)
	cret.cut=w_cut
	cret.pow=w_pow
	cret.dx=1
	cret.dy=-1
	cret.sprite_index=S_Shot2

	/*Down Diagonal Shots*/
	cret=instance_create(x-1,y+2,Shot_1)
	cret.cut=w_cut
	cret.pow=w_pow
	cret.dx=1
	cret.dy=1
	cret.sprite_index=S_Shot3
	}
	/*Horizontal Blazer*/
	if !instance_exists(Shot_4) && stam3>=25{
	cret=instance_create(x,y,Shot_4)
	cret.pow=w_pow
	}



}
