function SXMS2_W_Init() {
	// @FIXME - SXMS2 is not supported
	//dll = "SXMS2.dll" /*Name of DLL to use*/

	/*Setup of the WinAmp Plugin Support Functions (20)
	global._SXMS2_W_Init = external_define(dll,"SXMS2_W_Init",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_W_RemovePlugIn = external_define(dll,"SXMS2_W_RemovePlugIn",dll_cdecl,ty_real,0);
	global._SXMS2_W_RemovePlugOut = external_define(dll,"SXMS2_W_RemovePlugOut",dll_cdecl,ty_real,0);
	global._SXMS2_W_Close = external_define(dll,"SXMS2_W_Close",dll_cdecl,ty_real,0);
	global._SXMS2_W_LoadPlugIn = external_define(dll,"SXMS2_W_LoadPlugIn",dll_cdecl,ty_real,1,ty_string);
	global._SXMS2_W_LoadPlugOut = external_define(dll,"SXMS2_W_LoadPlugOut",dll_cdecl,ty_real,1,ty_string);
	global._SXMS2_W_Stop = external_define(dll,"SXMS2_W_Stop",dll_cdecl,ty_real,0);
	global._SXMS2_W_Play = external_define(dll,"SXMS2_W_Play",dll_cdecl,ty_real,1,ty_string);
	global._SXMS2_W_IsPlaying = external_define(dll,"SXMS2_W_IsPlaying",dll_cdecl,ty_real,0);
	global._SXMS2_W_SetPaused = external_define(dll,"SXMS2_W_SetPaused",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_W_GetPaused = external_define(dll,"SXMS2_W_GetPaused",dll_cdecl,ty_real,0);
	global._SXMS2_W_GetLength = external_define(dll,"SXMS2_W_GetLength",dll_cdecl,ty_real,0);
	global._SXMS2_W_GetOutputTime = external_define(dll,"SXMS2_W_GetOutputTime",dll_cdecl,ty_real,0);
	global._SXMS2_W_SetOutputTime = external_define(dll,"SXMS2_W_SetOutputTime",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_W_SetVolume = external_define(dll,"SXMS2_W_SetVolume",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_W_GetVolume = external_define(dll,"SXMS2_W_GetVolume",dll_cdecl,ty_real,0);
	global._SXMS2_W_SetPan = external_define(dll,"SXMS2_W_SetPan",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_W_Configure = external_define(dll,"SXMS2_W_Configure",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_W_About = external_define(dll,"SXMS2_W_About",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_W_GetExtentions = external_define(dll,"SXMS2_W_GetExtentions",dll_cdecl,ty_string,0);

	/*The Initializing of the SXMS WinAmp Plugin Support
	return external_call(global._SXMS2_W_Init,window_handle());
	/*The Arguments:
	-Arg0- (Not filled by user) The handle of the GM window
	Return = NULL
	*/



}
