function SXMS2_SA_GetLoopPoints(argument0, argument1) {
	return external_call(global._SXMS2_SA_GetLoopPoints,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The index ID of the sample
	Arg1 = REAL - The type of information to return (0 or 1)
	Return = REAL -

	(Depending on argument1)
	0: The loop end point
	1: The loop start point
	*/



}
