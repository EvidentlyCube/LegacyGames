function SXMS2_MC_SetPanSeperation(argument0, argument1) {
	return external_call(global._SXMS2_MC_SetPanSeperation,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The mod index
	Arg1 = REAL - The seperation (mono 0.0 - 1.0 full stereo)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
