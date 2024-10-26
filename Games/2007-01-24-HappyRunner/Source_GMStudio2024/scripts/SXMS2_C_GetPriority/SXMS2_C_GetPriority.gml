function SXMS2_C_GetPriority(argument0) {
	return external_call(global._SXMS2_C_GetPriority,argument0);
	/*The Arguments:
	Arg0 = REAL - The channel to get priority
	Return = REAL - The priority of the channel (0 to 255) (256 if Stream)
	*/



}
