function SXMS2_GI_GetNumHWChannels(argument0) {
	return external_call(global._SXMS2_GI_GetNumHWChannels,argument0);
	/*The Arguments:
	Arg0 = REAL - The type of information to return (0 to 2)
	Return = REAL - 

	(Depending on Argument0)
	0: Total available hardware channels (2D + 3D)
	1: Available 2D hardware mixed channels
	2: Available 3D hardware mixed channels
	*/



}
