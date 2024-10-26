function SXMS2_C_PlaySoundEx(argument0, argument1, argument2) {
	return external_call(global._SXMS2_C_PlaySoundEx,argument0,argument1,argument2);
	/*The Arguments:
	Arg0 = REAL - The channel to play in
	Arg1 = REAL - The sample index ID to play
	Arg2 = REAL - Whether to start paused (0 or 1)
	Return = REAL - Successful, Channel handle (>0) or Failed (-1)
	*/



}
