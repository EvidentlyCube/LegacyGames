function Mening(argument0, argument1, argument2, argument3, argument4) {
	var mix,miy,myx,myy;
	mix=argument0;
	miy=argument1;
	myx=argument2;
	myy=argument3;
	alph=argument4;

	draw_sprite_ext(S_Mener,0,mix,miy,1,1,0,c_white,alph)
	draw_sprite_stretched_ext(S_Mener,1,mix+3,miy,myx-mix-6,3,c_white,alph)
	draw_sprite_ext(S_Mener,2,myx-3,miy,1,1,0,c_white,alph)
	draw_sprite_stretched_ext(S_Mener,3,mix,miy+3,3,myy-miy-6,c_white,alph)
	draw_sprite_stretched_ext(S_Mener,4,myx-3,miy+3,3,myy-miy-6,c_white,alph)
	draw_sprite_ext(S_Mener,5,mix,myy-3,1,1,0,c_white,alph)
	draw_sprite_stretched_ext(S_Mener,6,mix+3,myy-3,myx-mix-6,3,c_white,alph)
	draw_sprite_ext(S_Mener,7,myx-3,myy-3,1,1,0,c_white,alph)
	draw_sprite_stretched_ext(S_Mener,8,mix+3,miy+3,myx-mix-6,myy-miy-6,c_white,alph)



}
