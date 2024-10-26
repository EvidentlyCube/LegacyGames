function SXMS2_C_3D_SetAttributes(argument0, argument1, argument2, argument3, argument4) {
	return external_call(global._SXMS2_C_3D_SetAttributes,argument0,argument1,argument2,argument3,argument4);
	/*The Arguments:
	Arg0 = REAL - The channel to set
	Arg1 = REAL - Whether the XYZ Triplet is for position (0) or velocity (1)
	Arg2 = REAL - X component of Triplet
	Arg3 = REAL - Y component of Triplet
	Arg4 = REAL - Z compenent of Triplet
	Return = REAL - Successful (1) or Failed (0)
	*/



}
