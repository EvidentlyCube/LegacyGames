function SXMS2_C_SetFrequency(argument0, argument1) {
	return external_call(global._SXMS2_C_SetFrequency,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The channel to effect
	Arg1 = REAL - The frequency (100 to 705600 or -100 to -705600)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
