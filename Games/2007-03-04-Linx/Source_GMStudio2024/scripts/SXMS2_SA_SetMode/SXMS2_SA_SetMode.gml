function SXMS2_SA_SetMode(argument0, argument1) {
	return external_call(global._SXMS2_SA_SetMode,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The index ID of the sample
	Arg1 = REAL - The mode to set (0 to 3)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
