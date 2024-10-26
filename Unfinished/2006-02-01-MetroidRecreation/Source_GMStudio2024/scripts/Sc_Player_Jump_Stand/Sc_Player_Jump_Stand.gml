function Sc_Player_Jump_Stand() {
	if p_move=14{p_stat=p_jumppow;
	/* Setting skills after jumping*/
	Sc_ISOf(4); //Setting Stand Up skill to OFF
	Sc_ISOf(5); //Setting Morph Ball skill to OFF
	Sc_ISOf(6); //Setting Morph Ball SKill OFF
	Sc_ISOf(7); //Setting the Jump skill to OF
	Sc_ISOf(8); //Setting the Wall Jump skill to off
	Sc_ISOn(9); //Setting the land skill to ON
	Sc_ISOf(10) //Setting the Place Bomb skill to OFF
	p_move=-1}



}
