function SXMS2_ST_Net_GetStatus(argument0, argument1) {
	return external_call(global._SXMS2_ST_Net_GetStatus,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The type of information returned (0 to 3)
	Arg1 = REAL - The index to a loaded stream
	Return = REAL -

	(Depends on argument0)
	0: The status (0 to 4)
	1: The amount of buffer used
	2: The bitrate
	3: The protocol used (0 to 4)
	*/



}
