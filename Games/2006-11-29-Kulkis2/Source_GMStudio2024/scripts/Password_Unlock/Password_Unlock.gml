function PasswordingLevelUnlock() {
	if !keyboard_check_pressed(vk_anykey) {
		return;
	}
	
	     if pass_unlock=0 && keyboard_check_pressed(ord("K")) { pass_unlock = 1 }
	else if pass_unlock=1 && keyboard_check_pressed(ord("U")) { pass_unlock = 2 }
	else if pass_unlock=2 && keyboard_check_pressed(ord("L")) { pass_unlock = 3 }
	else if pass_unlock=3 && keyboard_check_pressed(ord("K")) { pass_unlock = 4 }
	else if pass_unlock=4 && keyboard_check_pressed(ord("I")) { pass_unlock = 5 }
	else if pass_unlock=5 && keyboard_check_pressed(ord("S")) {
		for (var _i = 0; _i < array_length(global.fin); _i++) {
			if (global.fin[_i] = 0) {
				global.fin[_i] = 1;
			}
		}
		pass_unlock=0;
		SaveState();
		
	} else {
		pass_unlock=0
	}



}
