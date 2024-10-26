function Weapon_32() {
	var cret, weap;
	/*Horizontal Thriller*/
	if stam1>=5 && stam1w8>2{
	stam1-=5
	stam1w8=0
	cret=instance_create(x,y-2,Shot_6)
	cret.cut=2
	cret.pow=w_pow*3
	cret.dx=1
	cret.dy=0
	cret=instance_create(x,y+2,Shot_6)
	cret.cut=2
	cret.pow=w_pow*3
	cret.dx=1
	cret.dy=0
	}

	/*Upper Diagonal Thriller*/
	if stam2>=5 && stam2w8>2{
	stam2-=5
	stam2w8=0
	cret=instance_create(x,y-1,Shot_6)
	cret.cut=2
	cret.pow=w_pow*3
	cret.dx=1
	cret.dy=-1
	cret.sprite_index=S_Shot2

	/*Down Diagonal Thriller*/
	cret=instance_create(x,y+1,Shot_6)
	cret.cut=2
	cret.pow=w_pow*3
	cret.dx=1
	cret.dy=1
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
