function SXMS2_MC_SetMasterSpeed(argument0, argument1) {
	return external_call(global._SXMS2_MC_SetMasterSpeed,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The mod index
	Arg1 = REAL - The speed of playback (0.0 to 10.0)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
