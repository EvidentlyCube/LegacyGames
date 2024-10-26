function SXMS2_FX_SetI3DL2Reverb(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10, argument11, argument12) {
	external_call(global._SXMS2_FX_SetI3DL2Reverb1,argument1,argument2,argument6,argument8);
	return external_call(global._SXMS2_FX_SetI3DL2Reverb2,argument0,argument3,argument4,argument5,argument7,argument9,argument10,argument11,argument12);
	/*The Arguments:
	Arg0 = REAL - The FX id
	Arg1 = REAL - Room
	Arg2 = REAL - Room HF
	Arg3 = REAL - Room Rolloff Factor
	Arg4 = REAL - Decay Time
	Arg5 = REAL - Decay HF Ratio
	Arg6 = REAL - Reflections
	Arg7 = REAL - Reflections Delay
	Arg8 = REAL - Reverb
	Arg9 = REAL - Reverb Delay
	Arg10 = REAL - Diffusion
	Arg11 = REAL - Density
	Arg12 = REAL - HF Reference
	Return = REAL - Successful (1) or Failed (0)
	*/

	//Check documentation for full info



}
