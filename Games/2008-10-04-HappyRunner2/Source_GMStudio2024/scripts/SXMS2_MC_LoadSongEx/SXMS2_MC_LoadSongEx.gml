function SXMS2_MC_LoadSongEx(argument0, argument1, argument2, argument3, argument4, argument5) {z
	external_call(global._SXMS2_MC_LoadSongExName,argument0);
	return external_call(global._SXMS2_MC_LoadSongEx,argument1,argument2,argument3,argument4,argument5);
	/*The Arguments:
	Arg0 = STRING - The filename (and path) of the song to load
	Arg1 = REAL - The index (slot) to load into
	Arg2 = REAL - The starting offset
	Arg3 = REAL - The total length of the file
	Arg4 = REAL - Whether to use nonblocking or not
	Arg5 = REAL - The style for looping
	Return = REAL - Successful (1) or Not (0)
	*/



}
