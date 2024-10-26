function debug() {
	if keyboard_check_pressed(vk_add){engine+=1}
	if keyboard_check_pressed(vk_subtract){engine-=1}
	if keyboard_check_pressed(vk_numpad1){ship+=1}
	if keyboard_check_pressed(vk_numpad2){ship-=1}
	if keyboard_check_pressed(vk_numpad4){w_mode+=1}
	if keyboard_check_pressed(vk_numpad5){w_mode-=1}



}
