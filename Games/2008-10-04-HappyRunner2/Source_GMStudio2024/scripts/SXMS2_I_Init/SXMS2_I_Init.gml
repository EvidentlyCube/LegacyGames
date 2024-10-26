function SXMS2_I_Init(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {
	dll = "SXMS2.dll" //Name of DLL to use

	/*Initialize Functions (2)*/
	global._SXMS2_I_Init = external_define(dll,"SXMS2_I_Init",dll_cdecl,ty_real,7,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real);
	global._SXMS2_I_Close = external_define(dll,"SXMS2_I_Close",dll_cdecl,ty_real,0);
	/*Pre-Initialize Functions are initialized in SXMS2_P_Init()*/

	/*Global Update Functions (4)*/
	global._SXMS2_GU_SetPanSeperation = external_define(dll,"SXMS2_GU_SetPanSeperation",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_GU_SetSFXMasterVolume = external_define(dll,"SXMS2_GU_SetSFXMasterVolume",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_GU_SetSpeakerMode = external_define(dll,"SXMS2_GU_SetSpeakerMode",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_GU_Update = external_define(dll,"SXMS2_GU_Update",dll_cdecl,ty_real,0);

	/*Global Information Functions (13)*/
	global._SXMS2_GI_GetCPUUsage = external_define(dll,"SXMS2_GI_GetCPUUsage",dll_cdecl,ty_real,0);
	global._SXMS2_GI_GetChannelsPlaying = external_define(dll,"SXMS2_GI_GetChannelsPlaying",dll_cdecl,ty_real,0);
	global._SXMS2_GI_GetDriver = external_define(dll,"SXMS2_GI_GetDriver",dll_cdecl,ty_real,0);
	global._SXMS2_GI_GetDriverName = external_define(dll,"SXMS2_GI_GetDriverName",dll_cdecl,ty_string,1,ty_real);
	global._SXMS2_GI_GetMaxSamples = external_define(dll,"SXMS2_GI_GetMaxSamples",dll_cdecl,ty_real,0);
	global._SXMS2_GI_GetMaxChannels = external_define(dll,"SXMS2_GI_GetMaxChannels",dll_cdecl,ty_real,0);
	global._SXMS2_GI_GetMemoryStats = external_define(dll,"SXMS2_GI_GetMemoryStats",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_GI_GetNumDrivers = external_define(dll,"SXMS2_GI_GetNumDrivers",dll_cdecl,ty_real,0);
	global._SXMS2_GI_GetNumHWChannels = external_define(dll,"SXMS2_GI_GetNumHWChannels",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_GI_GetOutput = external_define(dll,"SXMS2_GI_GetOutput",dll_cdecl,ty_real,0);
	global._SXMS2_GI_GetOutputRate = external_define(dll,"SXMS2_GI_GetOutputRate",dll_cdecl,ty_real,0);
	global._SXMS2_GI_GetSFXMasterVolume = external_define(dll,"SXMS2_GI_GetSFXMasterVolume",dll_cdecl,ty_real,0);
	global._SXMS2_GI_GetVersion = external_define(dll,"SXMS2_GI_GetVersion",dll_cdecl,ty_real,0);

	/*Sample Functions (13 - 1)*/
	global._SXMS2_SA_Alloc = external_define(dll,"SXMS2_SA_Alloc",dll_cdecl,ty_real,10,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real);
	global._SXMS2_SA_Free = external_define(dll,"SXMS2_SA_Free",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_SA_GetDefaults = external_define(dll,"SXMS2_SA_GetDefaults",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_SA_GetLength = external_define(dll,"SXMS2_SA_GetLength",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_SA_GetLoopPoints = external_define(dll,"SXMS2_SA_GetLoopPoints",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_SA_GetMinMaxDistance = external_define(dll,"SXMS2_SA_GetMinMaxDistance",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_SA_GetName = external_define(dll,"SXMS2_SA_GetName",dll_cdecl,ty_string,1,ty_real);
	   /*These must work together*/
	   global._SXMS2_SA_LoadName = external_define(dll,"SXMS2_SA_LoadName",dll_cdecl,ty_real,1,ty_string);
	   global._SXMS2_SA_Load = external_define(dll,"SXMS2_SA_Load",dll_cdecl,ty_real,8,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real);
	   /**/
	global._SXMS2_SA_SetDefaults = external_define(dll,"SXMS2_SA_SetDefaults",dll_cdecl,ty_real,5,ty_real,ty_real,ty_real,ty_real,ty_real);
	global._SXMS2_SA_SetMinMaxDistance = external_define(dll,"SXMS2_SA_SetMinMaxDistance",dll_cdecl,ty_real,3,ty_real,ty_real,ty_real);
	global._SXMS2_SA_SetMode = external_define(dll,"SXMS2_SA_SetMode",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_SA_SetLoopPoints = external_define(dll,"SXMS2_SA_SetLoopPoints",dll_cdecl,ty_real,3,ty_real,ty_real,ty_real);

	/*Channel Functions (28)*/
	global._SXMS2_C_PlaySoundEx = external_define(dll,"SXMS2_C_PlaySoundEx",dll_cdecl,ty_real,3,ty_real,ty_real,ty_real);
	global._SXMS2_C_StopSound = external_define(dll,"SXMS2_C_StopSound",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_C_SetFrequency = external_define(dll,"SXMS2_C_SetFrequency",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_C_SetLoopMode = external_define(dll,"SXMS2_C_SetLoopMode",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_C_SetMute = external_define(dll,"SXMS2_C_SetMute",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_C_SetPan = external_define(dll,"SXMS2_C_SetPan",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_C_SetPaused = external_define(dll,"SXMS2_C_SetPaused",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_C_SetPriority = external_define(dll,"SXMS2_C_SetPriority",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_C_SetReserved = external_define(dll,"SXMS2_C_SetReserved",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_C_SetSurround = external_define(dll,"SXMS2_C_SetSurround",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_C_SetVolume = external_define(dll,"SXMS2_C_SetVolume",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_C_SetVolumeAbsolute = external_define(dll,"SXMS2_C_SetVolumeAbsolute",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_C_GetVolume = external_define(dll,"SXMS2_C_GetVolume",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_C_3D_SetAttributes = external_define(dll,"SXMS2_C_3D_SetAttributes",dll_cdecl,ty_real,5,ty_real,ty_real,ty_real,ty_real,ty_real);
	global._SXMS2_C_3D_SetMinMaxDistance = external_define(dll,"SXMS2_C_3D_SetMinMaxDistance",dll_cdecl,ty_real,3,ty_real,ty_real,ty_real);
	global._SXMS2_C_SetCurrentPosition = external_define(dll,"SXMS2_C_SetCurrentPosition",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_C_GetCurrentPosition = external_define(dll,"SXMS2_C_GetCurrentPosition",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_C_GetCurrentLevels = external_define(dll,"SXMS2_C_GetCurrentLevels",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_C_GetFrequency = external_define(dll,"SXMS2_C_GetFrequency",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_C_GetMute = external_define(dll,"SXMS2_C_GetMute",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_C_GetPan = external_define(dll,"SXMS2_C_GetPan",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_C_GetPaused = external_define(dll,"SXMS2_C_GetPaused",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_C_GetPriority = external_define(dll,"SXMS2_C_GetPriority",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_C_GetReserved = external_define(dll,"SXMS2_C_GetReserved",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_C_GetSurround = external_define(dll,"SXMS2_C_GetSurround",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_C_IsPlaying = external_define(dll,"SXMS2_C_IsPlaying",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_C_3D_GetAttributes = external_define(dll,"SXMS2_C_3D_GetAttributes",dll_cdecl,ty_string,2,ty_real,ty_real);
	global._SXMS2_C_3D_GetMinMaxDistance = external_define(dll,"SXMS2_C_3D_GetMinMaxDistance",dll_cdecl,ty_real,2,ty_real,ty_real);

	/*3D Functions (6)*/
	global._SXMS2_3D_Listener_GetAttributes = external_define(dll,"SXMS2_3D_Listener_GetAttributes",dll_cdecl,ty_string,1,ty_real);
	global._SXMS2_3D_Listener_SetAttributes = external_define(dll,"SXMS2_3D_Listener_SetAttributes",dll_cdecl,ty_real,10,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real);
	global._SXMS2_3D_Listener_SetCurrent = external_define(dll,"SXMS2_3D_Listener_SetCurrent",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_3D_SetDistanceFactor = external_define(dll,"SXMS2_3D_SetDistanceFactor",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_3D_SetDopplerFactor = external_define(dll,"SXMS2_3D_SetDopplerFactor",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_3D_SetRolloffFactor = external_define(dll,"SXMS2_3D_SetRolloffFactor",dll_cdecl,ty_real,1,ty_real);

	/*Stream Functions (24 - 1)*/
	global._SXMS2_ST_Close = external_define(dll,"SXMS2_ST_Close",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_ST_GetLength = external_define(dll,"SXMS2_ST_GetLength",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_ST_GetLengthMs = external_define(dll,"SXMS2_ST_GetLengthMs",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_ST_GetNumSubStreams = external_define(dll,"SXMS2_ST_GetNumSubStreams",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_ST_GetNumTagFields = external_define(dll,"SXMS2_ST_GetNumTagFields",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_ST_GetOpenState = external_define(dll,"SXMS2_ST_GetOpenState",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_ST_GetPosition = external_define(dll,"SXMS2_ST_GetPosition",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_ST_GetTagField = external_define(dll,"SXMS2_ST_GetTagField",dll_cdecl,ty_string,3,ty_real,ty_real,ty_real);
	global._SXMS2_ST_GetTime = external_define(dll,"SXMS2_ST_GetTime",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_ST_Net_GetBufferProperties = external_define(dll,"SXMS2_ST_Net_GetBufferProperties",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_ST_Net_GetLastServerStatus = external_define(dll,"SXMS2_ST_Net_GetLastServerStatus",dll_cdecl,ty_string,0);
	global._SXMS2_ST_Net_GetStatus = external_define(dll,"SXMS2_ST_Net_GetStatus",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_ST_Net_SetBufferProperties = external_define(dll,"SXMS2_ST_Net_SetBufferProperties",dll_cdecl,ty_real,3,ty_real,ty_real,ty_real);
	global._SXMS2_ST_Net_SetProxy = external_define(dll,"SXMS2_ST_Net_SetProxy",dll_cdecl,ty_real,1,ty_string);
	   /*These must work together*/
	   global._SXMS2_ST_OpenName = external_define(dll,"SXMS2_ST_OpenName",dll_cdecl,ty_real,1,ty_string);
	   global._SXMS2_ST_Open = external_define(dll,"SXMS2_ST_Open",dll_cdecl,ty_real,8,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real);
	   /**/
	global._SXMS2_ST_Play = external_define(dll,"SXMS2_ST_Play",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_ST_SetBufferSize = external_define(dll,"SXMS2_ST_SetBufferSize",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_ST_SetLoopCount = external_define(dll,"SXMS2_ST_SetLoopCount",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_ST_SetLoopPoints = external_define(dll,"SXMS2_ST_SetLoopPoints",dll_cdecl,ty_real,3,ty_real,ty_real,ty_real);
	global._SXMS2_ST_SetPosition = external_define(dll,"SXMS2_ST_SetPosition",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_ST_SetSubStream = external_define(dll,"SXMS2_ST_SetSubStream",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_ST_SetTime = external_define(dll,"SXMS2_ST_SetTime",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_ST_Stop = external_define(dll,"SXMS2_ST_Stop",dll_cdecl,ty_real,1,ty_real);

	/*Compact Disk Functions (12)*/
	global._SXMS2_CD_OpenTray = external_define(dll,"SXMS2_CD_OpenTray",dll_cdecl,ty_real,2,ty_string,ty_real);
	global._SXMS2_CD_GetNumTracks = external_define(dll,"SXMS2_CD_GetNumTracks",dll_cdecl,ty_real,1,ty_string);
	global._SXMS2_CD_GetPaused = external_define(dll,"SXMS2_CD_GetPaused",dll_cdecl,ty_real,1,ty_string);
	global._SXMS2_CD_GetTrack = external_define(dll,"SXMS2_CD_GetTrack",dll_cdecl,ty_real,1,ty_string);
	global._SXMS2_CD_GetTrackLength = external_define(dll,"SXMS2_CD_GetTrackLength",dll_cdecl,ty_real,2,ty_string,ty_real);
	global._SXMS2_CD_GetTrackTime = external_define(dll,"SXMS2_CD_GetTrackTime",dll_cdecl,ty_real,1,ty_string);
	global._SXMS2_CD_Play = external_define(dll,"SXMS2_CD_Play",dll_cdecl,ty_real,2,ty_string,ty_real);
	global._SXMS2_CD_SetPaused = external_define(dll,"SXMS2_CD_SetPaused",dll_cdecl,ty_real,2,ty_string,ty_real);
	global._SXMS2_CD_SetPlayMode = external_define(dll,"SXMS2_CD_SetPlayMode",dll_cdecl,ty_real,2,ty_string,ty_real);
	global._SXMS2_CD_SetTrackTime = external_define(dll,"SXMS2_CD_SetTrackTime",dll_cdecl,ty_real,2,ty_string,ty_real);
	global._SXMS2_CD_SetVolume = external_define(dll,"SXMS2_CD_SetVolume",dll_cdecl,ty_real,2,ty_string,ty_real);
	global._SXMS2_CD_Stop = external_define(dll,"SXMS2_CD_Stop",dll_cdecl,ty_real,1,ty_string);

	/*DSP Functions (7)*/
	global._SXMS2_DSP_ClearMixBuffer = external_define(dll,"SXMS2_DSP_ClearMixBuffer",dll_cdecl,ty_real,0);
	global._SXMS2_DSP_SetActive = external_define(dll,"SXMS2_DSP_SetActive",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_DSP_GetActive = external_define(dll,"SXMS2_DSP_GetActive",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_DSP_GetBufferLengthTotal = external_define(dll,"SXMS2_DSP_GetBufferLengthTotal",dll_cdecl,ty_real,0);
	global._SXMS2_DSP_SetPriority = external_define(dll,"SXMS2_DSP_SetPriority",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_DSP_GetPriority = external_define(dll,"SXMS2_DSP_GetPriority",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_DSP_GetSpectrum = external_define(dll,"SXMS2_DSP_GetSpectrum",dll_cdecl,ty_real,1,ty_real);

	/*DirectX 8.1 FX Functions (12)*/
	global._SXMS2_FX_Disable = external_define(dll,"SXMS2_FX_Disable",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_FX_Enable = external_define(dll,"SXMS2_FX_Enable",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_FX_SetChorus = external_define(dll,"SXMS2_FX_SetChorus",dll_cdecl,ty_real,8,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real);
	global._SXMS2_FX_SetCompressor = external_define(dll,"SXMS2_FX_SetCompressor",dll_cdecl,ty_real,7,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real);
	global._SXMS2_FX_SetDistortion = external_define(dll,"SXMS2_FX_SetDistortion",dll_cdecl,ty_real,6,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real);
	global._SXMS2_FX_SetEcho = external_define(dll,"SXMS2_FX_SetEcho",dll_cdecl,ty_real,6,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real);
	global._SXMS2_FX_SetFlanger = external_define(dll,"SXMS2_FX_SetFlanger",dll_cdecl,ty_real,8,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real);
	global._SXMS2_FX_SetGargle = external_define(dll,"SXMS2_FX_SetGargle",dll_cdecl,ty_real,3,ty_real,ty_real,ty_real);
	   /*These must work together*/
	   global._SXMS2_FX_SetI3DL2Reverb1 = external_define(dll,"SXMS2_FX_SetI3DL2Reverb1",dll_cdecl,ty_real,4,ty_real,ty_real,ty_real,ty_real);
	   global._SXMS2_FX_SetI3DL2Reverb2 = external_define(dll,"SXMS2_FX_SetI3DL2Reverb2",dll_cdecl,ty_real,9,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real);
	   /**/
	global._SXMS2_FX_SetParamEQ = external_define(dll,"SXMS2_FX_SetParamEQ",dll_cdecl,ty_real,4,ty_real,ty_real,ty_real,ty_real);
	global._SXMS2_FX_SetWavesReverb = external_define(dll,"SXMS2_FX_SetWavesReverb",dll_cdecl,ty_real,5,ty_real,ty_real,ty_real,ty_real,ty_real);

	/*Recording Functions (7)*/
	global._SXMS2_R_GetDriver = external_define(dll,"SXMS2_R_GetDriver",dll_cdecl,ty_real,0);
	global._SXMS2_R_GetDriverName = external_define(dll,"SXMS2_R_GetDriverName",dll_cdecl,ty_string,1,ty_real);
	global._SXMS2_R_GetNumDrivers = external_define(dll,"SXMS2_R_GetNumDrivers",dll_cdecl,ty_real,0);
	global._SXMS2_R_GetPosition = external_define(dll,"SXMS2_R_GetPosition",dll_cdecl,ty_real,0);
	global._SXMS2_R_SetDriver = external_define(dll,"SXMS2_R_SetDriver",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_R_StartSample = external_define(dll,"SXMS2_R_StartSample",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_R_Stop = external_define(dll,"SXMS2_R_Stop",dll_cdecl,ty_real,0);

	/*FMUSIC Control Functions (15)*/
	global._SXMS2_MC_FreeSong = external_define(dll,"SXMS2_MC_FreeSong",dll_cdecl,ty_real,1,ty_real);
	   /*These must work together*/
	   global._SXMS2_MC_LoadSongExName = external_define(dll,"SXMS2_MC_LoadSongExName",dll_cdecl,ty_real,1,ty_string);
	   global._SXMS2_MC_LoadSongEx = external_define(dll,"SXMS2_MC_LoadSongEx",dll_cdecl,ty_real,5,ty_real,ty_real,ty_real,ty_real,ty_real);
	   /**/
	global._SXMS2_MC_OptimizeChannels = external_define(dll,"SXMS2_MC_OptimizeChannels",dll_cdecl,ty_real,3,ty_real,ty_real,ty_real);
	global._SXMS2_MC_PlaySong = external_define(dll,"SXMS2_MC_PlaySong",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MC_SetLooping = external_define(dll,"SXMS2_MC_SetLooping",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_MC_SetMasterSpeed = external_define(dll,"SXMS2_MC_SetMasterSpeed",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_MC_SetMasterVolume = external_define(dll,"SXMS2_MC_SetMasterVolume",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_MC_SetOrder = external_define(dll,"SXMS2_MC_SetOrder",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_MC_SetPanSeperation = external_define(dll,"SXMS2_MC_SetPanSeperation",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_MC_SetPaused = external_define(dll,"SXMS2_MC_SetPaused",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_MC_SetReverb = external_define(dll,"SXMS2_MC_SetReverb",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MC_SetSample = external_define(dll,"SXMS2_MC_SetSample",dll_cdecl,ty_real,3,ty_string,ty_real,ty_real);
	global._SXMS2_MC_StopAllSongs = external_define(dll,"SXMS2_MC_StopAllSongs",dll_cdecl,ty_real,0);
	global._SXMS2_MC_StopSong = external_define(dll,"SXMS2_MC_StopSong",dll_cdecl,ty_real,1,ty_real);

	/*FMUSIC Information Functions (21)*/
	global._SXMS2_MI_GetBPM = external_define(dll,"SXMS2_MI_GetBPM",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_GetGlobalVolume = external_define(dll,"SXMS2_MI_GetGlobalVolume",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_GetMasterVolume = external_define(dll,"SXMS2_MI_GetMasterVolume",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_GetName = external_define(dll,"SXMS2_MI_GetName",dll_cdecl,ty_string,1,ty_real);
	global._SXMS2_MI_GetNumChannels = external_define(dll,"SXMS2_MI_GetNumChannels",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_GetNumInstruments = external_define(dll,"SXMS2_MI_GetNumInstruments",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_GetNumOrders = external_define(dll,"SXMS2_MI_GetNumOrders",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_GetNumPatterns = external_define(dll,"SXMS2_MI_GetNumPatterns",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_GetNumSamples = external_define(dll,"SXMS2_MI_GetNumSamples",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_GetOpenState = external_define(dll,"SXMS2_MI_GetOpenState",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_GetOrder = external_define(dll,"SXMS2_MI_GetOrder",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_GetPattern = external_define(dll,"SXMS2_MI_GetPattern",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_GetPatternLength = external_define(dll,"SXMS2_MI_GetPatternLength",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_MI_GetPaused = external_define(dll,"SXMS2_MI_GetPaused",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_GetRealChannel = external_define(dll,"SXMS2_MI_GetRealChannel",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_MI_GetRow = external_define(dll,"SXMS2_MI_GetRow",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_ExportSample = external_define(dll,"SXMS2_MI_ExportSample",dll_cdecl,ty_real,3,ty_string,ty_real,ty_real);
	global._SXMS2_MI_GetSpeed = external_define(dll,"SXMS2_MI_GetSpeed",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_GetTime = external_define(dll,"SXMS2_MI_GetTime",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_IsFinished = external_define(dll,"SXMS2_MI_IsFinished",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_MI_IsPlaying = external_define(dll,"SXMS2_MI_IsPlaying",dll_cdecl,ty_real,1,ty_real);

	/*WinAmp Plugin Support Functions are initialized in SXMS2_W_Init()*/

	/*Shaltif's Additional Functions (4)*/
	global._SXMS2_S_BitRate = external_define(dll,"SXMS2_S_BitRate",dll_cdecl,ty_real,1,ty_real);
	global._SXMS2_S_ModRows = external_define(dll,"SXMS2_S_ModRows",dll_cdecl,ty_real,2,ty_real,ty_real);
	global._SXMS2_S_PercentComplete = external_define(dll,"SXMS2_S_PercentComplete",dll_cdecl,ty_real,4,ty_real,ty_real,ty_real,ty_string);
	global._SXMS2_S_SaveToWav = external_define(dll,"SXMS2_S_SaveToWav",dll_cdecl,ty_real,2,ty_string,ty_real);

	/*The actual initalizing of the fmod.dll*/
	return external_call(global._SXMS2_I_Init,argument0,argument1,argument2,argument3,argument4,argument5,argument6);
	/*The Arguments:
	Arg0 = REAL - Mix Rate in Hz (4000 to 65535)
	Arg1 = REAL - Max Initialized Software Channels (0 to 1024)
	Arg2 = REAL - Use Default Midi Synth (TRUE or FALSE)
	Arg3 = REAL - Use Global Focus (TRUE or FALSE)
	Arg4 = REAL - Enable System Channel FX (TRUE or FALSE)
	Arg5 = REAL - Accurate VU Levels (TRUE or FALSE)
	Arg6 = REAL - Don't Latancy Adjust Return Information (TRUE or FALSE)
	Return = REAL - Successful (1) or Failed (0)
	*/



}
