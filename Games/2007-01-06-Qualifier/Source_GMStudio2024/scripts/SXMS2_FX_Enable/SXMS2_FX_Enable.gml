function SXMS2_FX_Enable(argument0, argument1) {
	return external_call(global._SXMS2_FX_Enable,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The channel to set effects on
	Arg1 = REAL - The effect to add (0 to 8)
	Return = REAL - The FX id or Failed (-1)
	*/



}
