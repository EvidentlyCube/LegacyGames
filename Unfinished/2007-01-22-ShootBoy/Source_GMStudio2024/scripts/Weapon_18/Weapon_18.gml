function Weapon_18() {
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
