function SXMS2_CD_SetTrackTime(argument0, argument1) {
	return external_call(global._SXMS2_CD_SetTrackTime,argument0,argument1);
	/*The Arguments:
	Arg0 = STRING - The character of the drive to set
	Arg1 = REAL - The time to set (in milliseconds)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
