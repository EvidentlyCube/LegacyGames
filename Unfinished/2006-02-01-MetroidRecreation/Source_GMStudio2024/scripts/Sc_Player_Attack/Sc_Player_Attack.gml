function Sc_Player_Attack() {
	/*
	5-Beam Charge
	6-Swing sword
	7-Shot Beam
	8-Swing & Shot
	*/

	if p_atk=5{}
	if p_atk=6{Sc_Player_Sword()}
	if p_atk=7{Sc_Player_Beam()}
	if p_atk=8{Sc_Player_Sword();Sc_Player_Beam()}



}
