function SXMS2_C_SetVolumeAbsolute(argument0, argument1) {
	return external_call(global._SXMS2_C_SetVolumeAbsolute,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The channel to effect
	Arg1 = REAL - The volume (0 to 255)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
