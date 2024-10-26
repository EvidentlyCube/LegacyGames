function SXMS2_ST_Net_GetBufferProperties(argument0) {
	return external_call(global._SXMS2_ST_Net_GetBufferProperties,argument0);
	/*The Arguments:
	Arg0 = REAL - The type of return value (0 - 2)
	Return = REAL -

	(Depends on argument0)
	0: Buffersize
	1: Pre-Buffer Percent
	2: Re-Buffer Percent
	*/



}
