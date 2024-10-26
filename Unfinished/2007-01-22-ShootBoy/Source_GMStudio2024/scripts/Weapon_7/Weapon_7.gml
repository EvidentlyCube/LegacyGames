function Weapon_7() {
	var cret, weap;
	/*Horizontal Shots*/
	if stam1>=10 && stam1w8>5{
	stam1-=10
	stam1w8=0
	cret=instance_create(x,y-3,Shot_1)
	cret.cut=w_cut
	cret.pow=w_pow
	cret.dx=1
	cret.dy=0
	cret=instance_create(x+1,y-1,Shot_1)
	cret.cut=w_cut
	cret.pow=w_pow
	cret.dx=1
	cret.dy=0
	cret=instance_create(x+1,y+1,Shot_1)
	cret.cut=w_cut
	cret.pow=w_pow
	cret.dx=1
	cret.dy=0
	cret=instance_create(x,y+3,Shot_1)
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
	cret=instance_create(x,y-1,Shot_1)
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
	cret=instance_create(x,y+1,Shot_1)
	cret.cut=w_cut
	cret.pow=w_pow
	cret.dx=1
	cret.dy=1
	cret.sprite_index=S_Shot3
	}



}
