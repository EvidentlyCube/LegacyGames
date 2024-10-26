function SXMS2_DSP_GetSpectrum(argument0) {
	return external_call(global._SXMS2_DSP_GetSpectrum,argument0);
	/*The Arguments:
	Arg0 = REAL - The spectrum section to return data from. (0 to 511)
	Return = REAL - The percent of sound in that section.
	*/



}
