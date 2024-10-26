function Weapon_8() {
	var cret, weap;
	/*Horizontal Minigun*/
	if stam1>=2 && stam1w8>1{
	stam1-=2
	stam1w8=0
	cret=instance_create(x+random(2)-random(2),y+random(3)-random(3),Shot_2)
	cret.cut=w_cut
	cret.pow=w_pow/1.5
	cret.dx=1+random(0.3)-random(0.3)
	cret.dy=0+random(0.05)-random(0.05)
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
