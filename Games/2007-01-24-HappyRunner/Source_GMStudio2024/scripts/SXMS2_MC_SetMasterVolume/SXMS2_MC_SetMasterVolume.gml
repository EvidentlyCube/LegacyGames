function SXMS2_MC_SetMasterVolume(argument0, argument1) {
	return external_call(global._SXMS2_MC_SetMasterVolume,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The mod index
	Arg1 = REAL - Volume (0 to 256)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
