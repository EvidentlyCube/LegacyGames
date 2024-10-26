function Weapon_0() {
	var cret, weap;

	/*Horizontal Shots*/
	if stam1>=10 && stam1w8>5{
	stam1-=10
	stam1w8=0
	cret=instance_create(x,y,Shot_1)
	cret.cut=w_cut
	cret.pow=w_pow
	cret.dx=1
	cret.dy=0
	}



}
