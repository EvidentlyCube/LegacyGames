function SXMS2_MC_OptimizeChannels(argument0, argument1, argument2) {
	return external_call(global._SXMS2_MC_OptimizeChannels,argument0,argument1,argument2);
	/*The Arguments:
	Arg0 = REAL - The mod index
	Arg1 = REAL - Max channels before dropping occurs
	Arg2 = REAL - Minimum volume (0 to 64)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
