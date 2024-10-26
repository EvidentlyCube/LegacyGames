function SXMS2_SA_Load(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8) {
	external_call(global._SXMS2_SA_LoadName,argument0); //Loads in the name
	return external_call(global._SXMS2_SA_Load,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8);
	/*The Arguments:
	Arg0 = STRING - The name of the file to load
	Arg1 = REAL - The index ID to store the loaded sample
	Arg2 = REAL - The seek offset value (optional) (greater than 0 to set)
	Arg3 = REAL - The length of the sample (only use if Arg2 is used)
	Arg4 = REAL - The looping mode (0 to 2)
	Arg5 = REAL - Mono or Stereo (1 or 2) (0 to ignore)
	Arg6 = REAL - 8Bit or 16Bit (1 or 2) (0 to ignore)
	Arg7 = REAL - Enable FX effects (0 or 1)
	Arg8 = REAL - Whether to load into 2D Hardware (1), 3D Hardware (2) or not (0)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
