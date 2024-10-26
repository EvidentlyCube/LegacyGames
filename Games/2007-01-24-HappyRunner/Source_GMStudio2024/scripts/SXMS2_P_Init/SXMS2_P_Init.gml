function SXMS2_P_Init() {
	dll = "SXMS2.dll" //Name of DLL to use

	/*Pre-Initialize Functions (7)*/
	global._SXMS2_P_SetBufferSize = external_define(dll,"SXMS2_P_SetBufferSize",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_P_SetDriver = external_define(dll,"SXMS2_P_SetDriver",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_P_SetHWND = external_define(dll,"SXMS2_P_SetHWND",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_P_SetMaxHardwareChannels = external_define(dll,"SXMS2_P_SetMaxHardwareChannels",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_P_SetMinHardwareChannels = external_define(dll,"SXMS2_P_SetMinHardwareChannels",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_P_SetMixer = external_define(dll,"SXMS2_P_SetMixer",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_P_SetOutput = external_define(dll,"SXMS2_P_SetOutput",dll_cdecl,ty_real,1,ty_real);
	return 0;
	/*The Arguments:
	Return = NULL
	*/



}
