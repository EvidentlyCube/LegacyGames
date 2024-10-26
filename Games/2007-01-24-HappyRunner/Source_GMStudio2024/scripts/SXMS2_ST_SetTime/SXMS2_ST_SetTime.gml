function SXMS2_ST_SetTime(argument0, argument1) {
	return external_call(global._SXMS2_ST_SetTime,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The index of a loaded stream
	Arg1 = REAL - The position to set (in milliseconds)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
