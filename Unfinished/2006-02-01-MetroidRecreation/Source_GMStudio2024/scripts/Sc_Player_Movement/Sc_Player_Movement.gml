function Sc_Player_Movement() {
	if mouse_check_button_pressed(mb_left){Sc_Mouse_Select()} //Wybieranie opcji myszk�

	if keyboard_check_pressed(global.key_rt) && p_shave[15]{p_move=0;p_dmov=17;if option_moving_a=1{start=1}} 
	if keyboard_check_pressed(global.key_ur) && p_shave[15]{p_move=1;p_dmov=18;if option_moving_a=1{start=1}}
	if keyboard_check_pressed(global.key_up) && p_shave[15]{p_move=2;p_dmov=19;if option_moving_a=1{start=1}}
	if keyboard_check_pressed(global.key_ul) && p_shave[15]{p_move=3;p_dmov=20;if option_moving_a=1{start=1}}
	if keyboard_check_pressed(global.key_lt) && p_shave[15]{p_move=4;p_dmov=21;if option_moving_a=1{start=1}}
	if keyboard_check_pressed(global.key_dl) && p_shave[15]{p_move=5;p_dmov=22;if option_moving_a=1{start=1}}
	if keyboard_check_pressed(global.key_dn) && p_shave[15]{p_move=6;p_dmov=23;if option_moving_a=1{start=1}}
	if keyboard_check_pressed(global.key_dr) && p_shave[15]=2{p_move=7;p_dmov=24;if option_moving_a=1{start=1}}
	if keyboard_check_pressed(global.key_wait){p_move=8;p_dmov=25;if option_moving_a=1{start=1}}
	if keyboard_check_pressed(global.key_trnl) && p_shave[16]=2{p_move=9;p_dmov=15;if option_moving_a=1{start=1}}
	if keyboard_check_pressed(global.key_trnr) && p_shave[16]=2{p_move=10;p_dmov=16;if option_moving_a=1{start=1}}
	if keyboard_check_pressed(global.key_jump) && p_shave[7]=2{p_move=14;p_dmov=7;if option_moving_a=1{start=1}} //Jump
	if keyboard_check_pressed(global.key_jump) && p_shave[8]=2{p_move=15;p_dmov=8;if option_moving_a=1{start=1}} //Wall Jump
	if keyboard_check_pressed(global.key_land) && p_shave[9]=2{p_move=16;p_dmov=9;if option_moving_a=1{start=1}} //Landing
	if keyboard_check_pressed(global.key_atka) && p_shave[12]=2{p_atk=6;p_datk=12;if option_moving_b=1{start=1}} //Swing Sword
	if keyboard_check_pressed(global.key_atkb) && p_shave[13]=2{p_atk=7;p_datk=13;if option_moving_b=1{start=1}} //Fire Beam
	if keyboard_check_pressed(global.key_atkc) && p_shave[14]=2{p_atk=8;p_datk=14;if option_moving_b=1{start=1}} //Both Attacks

	if option_moving_a=2 && p_move!=-1 && p_atk!=-1{start=1}

	if keyboard_check_pressed(global.key_start){start=1}
	if start=1{
	Sc_Turn_Start()
	}



}
