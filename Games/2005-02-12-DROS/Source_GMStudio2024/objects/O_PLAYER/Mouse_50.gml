/// @description Insert description here
// You can write your code in this editor

if (global.debug) {
	var targetX = floor(mouse_x / 16) * 16;
	var targetY = floor(mouse_y / 16) * 16;

	if place_free(targetX, targetY) {
		x = targetX;
		y = targetY;
	}
}