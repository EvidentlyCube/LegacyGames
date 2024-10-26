function SXMS2_DSP_SetPriority(argument0, argument1) {
	return external_call(global._SXMS2_DSP_SetPriority,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The DSP unit to set the priority (0 to 4)
	Arg1 = REAL - The priority for the selected unit (0 to 1000)
	Return = NULL
	*/



}
