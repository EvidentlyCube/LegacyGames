function SXMS2_CD_OpenTray(argument0, argument1) {
	return external_call(global._SXMS2_CD_OpenTray,argument0,argument1);
	/*The Arguments:
	Arg0 = STRING - The character of the drive to open/close (0 for default)
	Arg1 = REAL - 1 to open, 0 to close.
	Return = REAL - Successful (1) or Failed (0)
	*/



}
