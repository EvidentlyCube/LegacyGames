function Sc_Panel_Draw() {
	draw_sprite(Panel,0,0,0)
	var variable;
	for (variable=0;variable<15;variable+=1){
	draw_sprite_ext(Pan,variable,0,80+variable*20,1,1,0,c_white,p_shave[variable]/2)
	}/*
	draw_sprite(Pan,0,0,80)
	draw_sprite(Pan,1,0,100)
	draw_sprite(Pan,2,0,120)
	draw_sprite(Pan,3,0,140)
	draw_sprite(Pan,4,0,160)
	draw_sprite(Pan,5,0,180)
	draw_sprite(Pan,6,0,200)
	draw_sprite(Pan,7,0,220)
	draw_sprite(Pan,8,0,240)
	draw_sprite(Pan,9,0,260)
	draw_sprite(Pan,10,0,280)
	draw_sprite(Pan,11,0,300)
	draw_sprite(Pan,12,0,320)
	draw_sprite(Pan,13,0,340)
	draw_sprite(Pan,14,0,360)*/
	draw_sprite(Pan,p_datk,690,370)
	draw_sprite(Pan,p_dmov,690,410)



}
