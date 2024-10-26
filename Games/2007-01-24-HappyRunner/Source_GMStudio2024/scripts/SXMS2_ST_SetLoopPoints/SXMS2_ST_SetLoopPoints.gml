function SXMS2_ST_SetLoopPoints(argument0, argument1, argument2) {
	return external_call(global._SXMS2_ST_SetLoopPoints,argument0,argument1,argument2);
	/*The Arguments:
	Arg0 = REAL - The index of a loaded stream
	Arg1 = REAL - The starting loop point in PCM SAMPLES
	Arg2 = REAL - The ending loop point in PCM SAMPLES
	Return = REAL - Successful (1) or Failed (0)
	*/



}
