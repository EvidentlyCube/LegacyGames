function SXMS2_MC_SetSample(argument0, argument1, argument2) {
	return external_call(global._SXMS2_MC_SetSample,argument0,argument1,argument2);
	/*The Arguments:
	Arg0 = REAL - The mod index
	Arg1 = REAL - slot number of sample spot inside mod
	Arg2 = REAL - Sample index number to set
	Return = REAL - Successful (1) or Failed (0)
	*/



}
