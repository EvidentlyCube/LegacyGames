function SXMS2_GI_GetMemoryStats(argument0) {
	return external_call(global._SXMS2_GI_GetMemoryStats,argument0);
	/*The Arguments:
	Arg0 = REAL - The type of information to return (0 or 1)
	Return = REAL - Current used memory or the max available memory
	*/



}
