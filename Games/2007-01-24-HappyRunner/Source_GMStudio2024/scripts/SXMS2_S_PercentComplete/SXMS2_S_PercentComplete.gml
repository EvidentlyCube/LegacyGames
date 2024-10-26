function SXMS2_S_PercentComplete(argument0, argument1, argument2, argument3) {
	return external_call(global._SXMS2_S_PercentComplete,argument0,argument1,argument2,argument3);
	/*The Arguments:
	Arg0 = REAL - System (0 = Stream, 1 = Mod, 2 = Sample, 3 = CD Player, 4 = WinPlugs)
	Arg1 = REAL - The stream, mod, or sample index
	Arg2 = REAL - The channel being played in (used for Sample system)
	Arg3 = STRING - Drive letter (Used for CD Player system)
	Return = REAL - The current percent complete (as decimal 0.00 to 1.00)
	*/



}
