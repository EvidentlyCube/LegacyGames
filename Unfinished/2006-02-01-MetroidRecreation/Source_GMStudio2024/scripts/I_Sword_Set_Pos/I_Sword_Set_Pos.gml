function I_Sword_Set_Pos() {
	/* This script is responsible for Sword's movement */
	/* CUT */
	if sw_type=0{
	 sw_dir=I_Var_Loop(p_dir+((sw_range+1)*sw_turn),7)
	 sw_x=p_x+c_movx[I_Var_Loop(p_dir+((sw_range+1)*sw_turn),7)]
	 sw_y=p_y+c_movy[I_Var_Loop(p_dir+((sw_range+1)*sw_turn),7)]
	} 
	else
	/* STAB and CHOP*/
	{
	 sw_dir=I_Var_Loop(p_dir+((sw_range+1)*sw_turn),7)

	}



}
