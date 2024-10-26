function Sc_Turn_End() {
	/* Setting skills after landing*/
	if p_stat>0 && p_stat<5{p_stat-=1; p_move=-1; p_dmov=26
	if p_stat=0 {
	I_After_Jump_Skills()
	}
	}
	/* Wall Jumping */
	if p_stat>0 && p_mode=0{
	if ds_grid_get(level,p_x+c_movx[p_dir],p_y+c_movy[p_dir])="x"{Sc_ISOn(8)} else {Sc_ISOf(8)}
	}
	/* Stop attack actions*/
	if option_moving_c=1{
	p_atk=-1
	p_datk=26
	}
	/* Stop movement actions */
	if option_moving_d=1{
	p_move=-1
	p_dmov=26
	}

	if p_stat=0 && ds_grid_get(level,p_x,p_y)="o"{game_restart()}
	/* Setting basic stuff */
	turn=0 // End the turn and begin the movement selection
	start=0
	turns+=1



}
