function SXMS2_CD_GetTrackLength(argument0, argument1) {
	return external_call(global._SXMS2_CD_GetTrackLength,argument0,argument1);
	/*The Arguments:
	Arg0 = STRING - The character of the drive to check
	Arg1 = REAL - The track to check
	Return = REAL - The length of the track selected (in milliseconds)
	*/



}
