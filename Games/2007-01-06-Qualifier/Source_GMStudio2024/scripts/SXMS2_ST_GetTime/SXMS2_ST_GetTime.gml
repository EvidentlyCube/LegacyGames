function SXMS2_ST_GetTime(argument0) {
	return external_call(global._SXMS2_ST_GetTime,argument0);
	/*The Arguments:
	Arg0 = REAL - The index of a loaded stream
	Return = REAL - The current position (in milliseconds)
	*/



}
