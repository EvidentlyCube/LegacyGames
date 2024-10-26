function SXMS2_DSP_GetPriority(argument0) {
	return external_call(global._SXMS2_DSP_GetPriority,argument0);
	/*The Arguments:
	Arg0 = REAL - The DSP unit to get the priority (0 to 4)
	Return = REAL - The number of the priority (0 to 1000)
	*/



}
