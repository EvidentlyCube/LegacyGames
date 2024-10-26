function SXMS2_CD_GetTrackTime(argument0, argument1) {
	return external_call(global._SXMS2_CD_GetTrackTime,argument0,argument1);
	/*The Arguments:
	Arg0 = STRING - The character of the drive to check
	Arg1 = REAL - The track to check
	Return = REAL - The current track time (in milliseconds)
	*/



}
