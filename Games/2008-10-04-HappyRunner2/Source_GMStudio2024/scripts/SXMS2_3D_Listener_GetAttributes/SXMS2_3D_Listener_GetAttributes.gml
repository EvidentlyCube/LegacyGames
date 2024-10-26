function SXMS2_3D_Listener_GetAttributes(argument0) {
	return external_call(global._SXMS2_3D_Listener_GetAttributes,argument0);
	/*The Arguments:
	Arg0 = REAL - The type of returned information (0 or 1)
	Return = STRING - XYZ triplet, XYZ of forward unit length, XYZ of top unit length

	(Depending on argument0)
	0: Position Vector
	1: Velocity Vector

	Example Return = "X|Y|Z|FX|FY|FZ|TX|TY|TZ"
	The first set (XYZ) is either the position or velocity
	*/



}
