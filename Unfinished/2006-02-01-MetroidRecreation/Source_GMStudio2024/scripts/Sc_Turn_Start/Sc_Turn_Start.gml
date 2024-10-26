function Sc_Turn_Start() {
	with (Effect_B){instance_destroy()}
	I_Msys_Add("-----START TURN "+string(turns)+": -----")
	Sc_Player_Movement_Started()
	Sc_Player_Attack()
	Sc_Player_Beam_Move()
	Sc_E_Moving()
	Sc_Turn_End()



}
