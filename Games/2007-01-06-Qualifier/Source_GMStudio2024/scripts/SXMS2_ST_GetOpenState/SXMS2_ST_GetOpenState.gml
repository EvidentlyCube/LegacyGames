function SXMS2_ST_GetOpenState(argument0) {
	return external_call(global._SXMS2_ST_GetOpenState,argument0);
	/*The Arguments:
	Arg0 = REAL - The index of the loaded stream
	Return = REAL - The state of the opened file (-5 to 0)
	*/



}
