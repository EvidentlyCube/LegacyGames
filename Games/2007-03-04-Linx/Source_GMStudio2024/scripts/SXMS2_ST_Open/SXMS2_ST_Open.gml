function SXMS2_ST_Open(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8) {
	external_call(global._SXMS2_ST_OpenName,argument0);
	return external_call(global._SXMS2_ST_Open,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8);
	/*The Arguments:
	Arg0 = STRING - The name of the file to open
	Arg1 = REAL - The index to assign the loaded file
	Arg2 = REAL - The starting offset (optional)
	Arg3 = REAL - The length of the file (only use if Arg2 is > 0)
	Arg4 = REAL - The looping method (0 to 2)
	Arg5 = REAL - Whether to use hardware (1) or not (0)
	Arg6 = REAL - Whether to be MPEG Accurate (1) or not (0)
	Arg7 = REAL - Whether to open with NON-Blocking (1) or not (0)
	Arg8 = REAL - Whether to enable DirectX 8.1 FX (1) or not (0)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
