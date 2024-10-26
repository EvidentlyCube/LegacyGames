function SXMS2_C_3D_GetAttributes(argument0, argument1) {
	return external_call(global._SXMS2_C_3D_GetAttributes,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The channel to get 3D Attributes
	Arg1 = REAL - Whether to return position (0) or velocity (1) vector
	Return = STRING - The XYZ triplet as a string

	Example Return = "X|Y|Z" or "1.3|4.5|0.4"
	*/



}
