function SXMS2_SA_GetDefaults(argument0, argument1) {
	return external_call(global._SXMS2_SA_GetDefaults,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The index ID of the sample
	Arg1 = REAL - The type of information to return (0 to 3)
	Return = REAL - 

	(Depending on argument1)
	0: Default frequency
	1: Default volume
	2: Default panning
	3: Default priority
	*/



}
