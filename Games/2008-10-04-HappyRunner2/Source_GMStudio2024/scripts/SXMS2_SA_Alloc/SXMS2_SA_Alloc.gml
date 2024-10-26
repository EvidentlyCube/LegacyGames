function SXMS2_SA_Alloc(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9) {
	return external_call(global._SXMS2_SA_Alloc,argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9);
	/*The Arguments:
	Arg0 = REAL - The index ID to create the sample in
	Arg1 = REAL - Length of the sample buffer in SAMPLES
	Arg2 = REAL - The default frequency (4000 to 65535) (-1 to ignore)
	Arg3 = REAL - The default volume (0 to 255) (-1 to ignore)
	Arg4 = REAL - The default panning (0 to 255) (-1 for special STEREO PAN)
	Arg5 = REAL - The default priority (0 to 255) (-1 to ignore)
	Arg6 = REAL - The looping mode (0 to 2)
	Arg7 = REAL - Mono or Stereo Sample (1 or 2) (0 to ignore)
	Arg8 = REAL - 8Bit or 16Bit Sample (1 or 2) (0 to ignore)
	Arg9 = REAL - Enable FX functions (0 or 1)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
