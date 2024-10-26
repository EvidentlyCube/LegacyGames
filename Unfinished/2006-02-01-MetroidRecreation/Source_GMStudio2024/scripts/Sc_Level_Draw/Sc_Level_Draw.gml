function Sc_Level_Draw() {
	a=2
	for (b=1;b<25;a+=1){
	if a>33{a=0;b+=1}
	if b=25{exit}
	draw_set_color(c_white)
	if ds_grid_get(lev_g,a,b)=1 {draw_sprite(Wall,0,a*20-20,60+b*20)}
	if ds_grid_get(lev_g,a,b)=2 {draw_sprite(Pit,0,a*20-20,60+b*20)}
	//draw_text(a*20-20,60+b*20,ds_grid_get(lev_e,a,b))//Debug
	}




}
