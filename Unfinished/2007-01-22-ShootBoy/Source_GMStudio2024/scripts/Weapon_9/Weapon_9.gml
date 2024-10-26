function Weapon_9() {
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

	/*Upper Diagonal Minigun*/
	if stam2>=2 && stam2w8>1{
	stam2-=2
	stam2w8=1
	cret=instance_create(x+random(2)-random(2),y+random(2)-random(2),Shot_2)
	cret.cut=w_cut
	cret.pow=w_pow/1.5
	cret.dx=1+random(0.2)-random(0.2)
	cret.dy=-1+random(0.2)-random(0.2)
	cret.sprite_index=S_Shot2

	/*Down Diagonal Minigun*/
	cret=instance_create(x+random(2)-random(2),y+random(2)-random(2),Shot_2)
	cret.cut=w_cut
	cret.pow=w_pow/1.5
	cret.dx=1+random(0.2)-random(0.2)
	cret.dy=1+random(0.2)-random(0.2)
	cret.sprite_index=S_Shot3
	}



}
