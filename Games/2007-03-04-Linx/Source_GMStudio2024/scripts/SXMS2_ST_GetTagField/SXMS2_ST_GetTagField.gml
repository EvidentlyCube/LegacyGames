function SXMS2_ST_GetTagField(argument0, argument1, argument2) {
	return external_call(global._SXMS2_ST_GetTagField,argument0,argument1,argument2);
	/*The Arguments:
	Arg0 = REAL - The tag to read
	Arg1 = REAL - The type of information to return
	Arg2 = REAL - The index of a loaded stream
	Return = STRING -

	(Depending on argument1)
	0: Type of Tag
	1: Title of Tag
	2: Value in Tag
	3: Size of Tag in Bytes
	*/



}
