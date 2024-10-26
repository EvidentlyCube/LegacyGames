function SXMS2_C_SetPan(argument0, argument1) {
	return external_call(global._SXMS2_C_SetPan,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The channel to effect
	Arg1 = REAL - The panning (0 to 255) (-1 for special STEREO PAN)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
