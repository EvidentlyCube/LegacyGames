function SXMS2_ST_SetLoopCount(argument0, argument1) {
	return external_call(global._SXMS2_ST_SetLoopCount,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The index of a loaded stream
	Arg1 = REAL - The number of times to loop ( <0 is infinity)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
