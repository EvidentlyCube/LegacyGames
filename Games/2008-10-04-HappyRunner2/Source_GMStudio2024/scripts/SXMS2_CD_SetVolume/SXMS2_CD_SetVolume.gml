function SXMS2_CD_SetVolume(argument0, argument1) {
	return external_call(global._SXMS2_CD_SetVolume,argument0,argument1);
	/*The Arguments:
	Arg0 = STRING - The character of the drive to set
	Arg1 = REAL - The volume to set (0 to 255)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
