function SXMS2_ST_Net_SetBufferProperties(argument0, argument1, argument2) {
	return external_call(global._SXMS2_ST_Net_SetBufferProperties,argument0,argument1,argument2);
	/*The Arguments:
	Arg0 = REAL - The buffersize (in bytes)
	Arg1 = REAL - The Pre-buffer percent (1 to 99)
	Arg2 = REAL - The Re-buffer percent (1 to 99)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
