function Sc_Player_Sword() {
	/* SWORD ATTACKING SCRIPT */
	/* SWING */
	if sw_type=0{
	 var tmp_a;
	 tmp_a=ds_grid_get(lev_e,p_x+c_movx[sw_dir],p_y+c_movy[sw_dir])
	 if tmp_a>-1{I_En_Hit_Sw()}
	 repeat (sw_range*2+2){
	  sw_dir=I_Var_Loop(sw_dir-sw_turn,7)
	  tmp_a=ds_grid_get(lev_e,p_x+c_movx[sw_dir],p_y+c_movy[sw_dir])
	  if tmp_a>-1{I_En_Hit_Sw()}
	  I_Part_A(p_x+c_movx[I_Var_Loop(sw_dir,7)],p_y+c_movy[I_Var_Loop(sw_dir,7)])
	 }
	 sw_turn*=-1
	 I_Part_A(p_x+c_movx[I_Var_Loop(sw_dir,7)],p_y+c_movy[I_Var_Loop(sw_dir,7)])
	 sw_x=p_x+c_movx[I_Var_Loop(p_dir+((sw_range+1)*sw_turn),7)]
	 sw_y=p_y+c_movy[I_Var_Loop(p_dir+((sw_range+1)*sw_turn),7)]
	}

	else
	/* STAB and CHOP*/
	{
	 tmp_a=ds_grid_get(lev_e,p_x+c_movx[sw_dir],p_y+c_movy[sw_dir])
	 if tmp_a>-1{I_En_Hit_Sw()}
	}



}
