function SXMS2_SA_SetLoopPoints(argument0, argument1, argument2) {
	return external_call(global._SXMS2_SA_SetLoopPoints,argument0,argument1,argument2);
	/*The Arguments:
	Arg0 = REAL - The index ID of the sample
	Arg1 = REAL - The start loop point (in SAMPLES)
	Arg2 = REAL - The end loop point (in SAMPLES)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
