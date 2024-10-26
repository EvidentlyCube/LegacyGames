function SXMS2_MC_SetLooping(argument0, argument1) {
	return external_call(global._SXMS2_MC_SetLooping,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The mod index
	Arg1 = REAL - Loop Forever (1) or just play once (0)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
