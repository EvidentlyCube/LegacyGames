function SXMS2_C_GetPan(argument0) {
	return external_call(global._SXMS2_C_GetPan,argument0);
	/*The Arguments:
	Arg0 = REAL - The channel to get panning
	Return = REAL - The panning (0 to 255) (-1 if STEREO PAN)
	*/



}
