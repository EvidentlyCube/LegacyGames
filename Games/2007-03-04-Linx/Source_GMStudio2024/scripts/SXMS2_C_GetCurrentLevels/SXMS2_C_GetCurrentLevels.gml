function SXMS2_C_GetCurrentLevels(argument0, argument1) {
	return external_call(global._SXMS2_C_GetCurrentLevels,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The channel to get the left/right levels from
	Arg1 = REAL - The type of information to return
	Return = REAL -

	(Depends on argument1)
	0: left audio level
	1: right audio level
	*/



}
