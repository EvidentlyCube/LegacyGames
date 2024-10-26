function Weapon_21() {
	var cret, weap;
	/*Horizontal Miniquadgun*/
	if stam1>=3 && stam1w8>3{
	stam1-=3
	stam1w8=0
	cret=instance_create(x,y-3,Shot_2)
	cret.cut=w_cut
	cret.pow=w_pow/3
	cret.dx=1+random(0.1)-random(0.1)
	cret.dy=0+random(0.1)-random(0.1)
	cret=instance_create(x,y+1,Shot_2)
	cret.cut=w_cut
	cret.pow=w_pow/3
	cret.dx=1+random(0.1)-random(0.1)
	cret.dy=0+random(0.1)-random(0.1)
	cret=instance_create(x,y-1,Shot_2)
	cret.cut=w_cut
	cret.pow=w_pow/3
	cret.dx=1+random(0.1)-random(0.1)
	cret.dy=0+random(0.1)-random(0.1)
	cret=instance_create(x,y+3,Shot_2)
	cret.cut=w_cut
	cret.pow=w_pow/3
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
