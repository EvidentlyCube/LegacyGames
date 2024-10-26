function I_After_Jump_Skills() {
	if p_mode=1{Sc_ISOn(4);} //Setting Stand Up skill to ON but only if you are jumping in ball form
	if p_mode=0{Sc_ISOn(5);} //Setting Morph Ball skill to ON but only if you are jumping in standing form
	Sc_ISOn(6); //Setting Morph Ball SKill on regardless of your jumping MODE
	Sc_ISOn(7); //Setting the Jump skill to ON
	Sc_ISOf(8); //Setting the Wall Jump skill to off
	Sc_ISOf(9); //Setting the land skill to off
	if p_mode=1{Sc_ISOn(10);} //Setting the Place Bomb skill to on but only if you are in ball form



}
