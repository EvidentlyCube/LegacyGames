function Passwording() {
	if keyboard_check_pressed(vk_anykey) {
		if password_a=0 && keyboard_check_pressed(ord("L")){password_a=1;}
		else if password_a=1 && keyboard_check_pressed(ord("I")){password_a=2;}
		else if password_a=2 && keyboard_check_pressed(ord("F")){password_a=3;}
		else if password_a=3 && keyboard_check_pressed(ord("E")){password_a=0;global.liv+=1;}
		else { password_a=0 }
		
		if password_b=0 && keyboard_check_pressed(ord("C")){password_b=1;}
		else if password_b=1 && keyboard_check_pressed(ord("L")){password_b=2;}
		else if password_b=2 && keyboard_check_pressed(ord("E")){password_b=3;}
		else if password_b=3 && keyboard_check_pressed(ord("A")){password_b=4;}
		else if password_b=4 && keyboard_check_pressed(ord("R")){
			password_b=0;
			with(DiamondA) { instance_destroy()  }
			with(DiamondB) { instance_destroy() }
			with(SmallBlack) { instance_destroy() }
			with(SmallBlue) { instance_destroy() }
			with(SmallCyan) { instance_destroy() }
			with(SmallGold) { instance_destroy() }
			with(SmallGreen) { instance_destroy() }
			with(SmallRed) { instance_destroy() }
			with(SmallViolet) { instance_destroy() }
			with(SmallWhite) { instance_destroy() }
			with(SmallYellow) { instance_destroy() }
		} else {
			password_b = 0;
		}
		
		if password_c=0 && keyboard_check_pressed(ord("S")){password_c=1;}
		else if password_c=1 && keyboard_check_pressed(ord("A")){password_c=2;}
		else if password_c=2 && keyboard_check_pressed(ord("F")){password_c=3;}
		else if password_c=3 && keyboard_check_pressed(ord("E")){
			password_c=0;
			with(SpikerURDL) { instance_destroy()  }
			with(SpikerU_D_) { instance_destroy() }
			with(Spiker_R_L) { instance_destroy() }
			with(SpikerU___) { instance_destroy() }
			with(Spiker_R__) { instance_destroy() }
			with(Spiker__D_) { instance_destroy() }
			with(Spiker___L) { instance_destroy() }
			with(BatH) { instance_destroy() }
			with(BatV) { instance_destroy() }
			with(Blyk) { instance_destroy() }
			with(Cannon) { instance_destroy() }
			with(EyerL) { instance_destroy() }
			with(EyerR) { instance_destroy() }
			with(Pit) { instance_destroy() }
			with(RotterL) { instance_destroy() }
			with(RotterR) { instance_destroy() }
			with(Shot) { instance_destroy() }
			with(Thorner) { instance_destroy() }
			with(Barrel) { instance_destroy() }
			with(Crate) { instance_destroy() }
			with(StellCrate) { instance_destroy() }
		} else {
			password_c = 0;
		}
		
		
		
		if password_d=0 && keyboard_check_pressed(ord("T")){password_d=1;}
		else if password_d=1 && keyboard_check_pressed(ord("E")){password_d=2;}
		else if password_d=2 && keyboard_check_pressed(ord("L")){password_d=3;}
		else if password_d=3 && keyboard_check_pressed(ord("E")){password_d=4;}
		else if password_d=4 && keyboard_check_pressed(ord("P")){password_d=5;}
		else if password_d=5 && keyboard_check_pressed(ord("O")){password_d=6;}
		else if password_d=6 && keyboard_check_pressed(ord("R")){password_d=7;}
		else if password_d=7 && keyboard_check_pressed(ord("T")){
			password_d=0;
			var _x = 0;
			var _y = 0;
			with (Exit) {
				_x = x;
				_y = y;
			}
			with (Exit_Active) {
				_x = x;
				_y = y;
			}
			if (_x != 0 && _y != 0) {			
				with(Body) { 
					x = _x;
					y = _y;
				}
			}
		} else {
			password_d = 0;
		}
	}
}
