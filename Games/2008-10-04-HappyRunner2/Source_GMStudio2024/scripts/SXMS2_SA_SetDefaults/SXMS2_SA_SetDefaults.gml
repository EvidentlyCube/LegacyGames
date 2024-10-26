function SXMS2_SA_SetDefaults(argument0, argument1, argument2, argument3, argument4) {
	return external_call(global._SXMS2_SA_SetDefaults,argument0,argument1,argument2,argument3,argument4);
	/*The Arguments:
	Arg0 = REAL - The index ID of the sample
	Arg1 = REAL - The default frequency (4000 to 65535) (-1 to ignore)
	Arg2 = REAL - The default volume (0 to 255) (-1 to ignore)
	Arg3 = REAL - The default panning (0 to 255) (-1 for special STEREO PAN)
	Arg4 = REAL - The default priority (0 to 255) (-1 to ignore)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
