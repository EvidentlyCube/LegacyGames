function SXMS2_R_StartSample(argument0, argument1) {
	return external_call(global._SXMS2_R_StartSample,argument0,argument1);
	/*The Arguments:
	Arg0 = REAL - The index id number for the sample
	Arg1 = REAL - whether to have looping recording (1) or not (0)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
