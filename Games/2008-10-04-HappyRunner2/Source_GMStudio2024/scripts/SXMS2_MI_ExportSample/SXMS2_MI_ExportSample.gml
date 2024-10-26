function SXMS2_MI_ExportSample(argument0, argument1, argument2) {
	return external_call(global._SXMS2_MI_ExportSample,argument0,argument1,argument2);
	/*The Arguments:
	Arg0 = STRING - The filename (and path) to save sample into (wav format)
	Arg1 = REAL - The mod index
	Arg2 = REAL - The sample number to export
	Return = REAL - Successful (1) or Failed (0)
	*/



}
