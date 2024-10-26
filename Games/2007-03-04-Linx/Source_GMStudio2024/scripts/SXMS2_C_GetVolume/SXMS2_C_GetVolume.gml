function SXMS2_C_GetVolume(argument0) {
	return external_call(global._SXMS2_C_GetVolume,argument0);
	/*The Arguments:
	Arg0 = REAL - The channel to get volume of
	Return = REAL - The volume of the channel (0 to 255)
	*/



}
