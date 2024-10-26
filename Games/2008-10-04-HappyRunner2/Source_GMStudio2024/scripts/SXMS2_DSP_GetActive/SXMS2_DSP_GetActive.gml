function SXMS2_DSP_GetActive(argument0) {
	return external_call(global._SXMS2_DSP_GetActive,argument0);
	/*The Arguments:
	Arg0 = REAL - The unit to check active state (0 to 4)
	Return = REAL - Active (1), Not Active (0), Error (-1)
	*/



}
