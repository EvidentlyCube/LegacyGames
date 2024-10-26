function SXMS2_C_SetCurrentPosition(argument0, argument1) {
	return external_call(global._SXMS2_C_SetCurrentPosition,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The channel to set position
	Arg1 = REAL - The position to jump to in SAMPLES
	Return = REAL - Successful (1) or Failed (0)
	*/



}
