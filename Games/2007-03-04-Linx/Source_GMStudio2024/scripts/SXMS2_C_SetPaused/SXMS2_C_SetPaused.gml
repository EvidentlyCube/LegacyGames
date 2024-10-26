function SXMS2_C_SetPaused(argument0, argument1) {
	return external_call(global._SXMS2_C_SetPaused,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The channel to effect
	Arg1 = REAL - Whether to pause (0 or 1)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
