function SXMS2_ST_Play(argument0, argument1) {
	return external_call(global._SXMS2_ST_Play,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The channel to play on
	Arg1 = REAL - The index of the stream to play
	Return = REAL - Successful (The channel handle played on) or Failed (-1)
	*/



}
