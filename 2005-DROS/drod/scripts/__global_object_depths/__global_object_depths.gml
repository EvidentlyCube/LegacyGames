function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = -1000; // O_ENEMYA
	global.__objectDepths[1] = -1000; // O_ENEMYB
	global.__objectDepths[2] = -1000; // O_ENEMYD
	global.__objectDepths[3] = -1000; // O_ENEMYE
	global.__objectDepths[4] = -1000; // O_ENEMYF
	global.__objectDepths[5] = -1000; // O_ENEMYG
	global.__objectDepths[6] = -1000; // O_ENEMYH
	global.__objectDepths[7] = -1000; // O_ENEMYI
	global.__objectDepths[8] = -1000; // O_ENEMYJ
	global.__objectDepths[9] = 0; // O_ENEMYK
	global.__objectDepths[10] = 0; // O_MAIN
	global.__objectDepths[11] = -10000; // O_MAINB
	global.__objectDepths[12] = 0; // O_MISCA
	global.__objectDepths[13] = 0; // O_MISCB
	global.__objectDepths[14] = 0; // O_MISCC
	global.__objectDepths[15] = -100; // O_MISCD
	global.__objectDepths[16] = 0; // O_MISCE
	global.__objectDepths[17] = -100; // O_MISCG
	global.__objectDepths[18] = 0; // O_MISCH
	global.__objectDepths[19] = 0; // O_MISCI
	global.__objectDepths[20] = 0; // O_MISCJ
	global.__objectDepths[21] = 0; // O_MISCK
	global.__objectDepths[22] = -1000; // O_PLAYER
	global.__objectDepths[23] = -1000; // O_WEAPON
	global.__objectDepths[24] = 100; // O_WALL
	global.__objectDepths[25] = 0; // O_PIT
	global.__objectDepths[26] = 0; // O_ENEMY
	global.__objectDepths[27] = 0; // O_MA_EYEUP
	global.__objectDepths[28] = 0; // O_MA_EYEUR
	global.__objectDepths[29] = 0; // O_MA_EYERI
	global.__objectDepths[30] = 0; // O_MA_EYEDR
	global.__objectDepths[31] = 0; // O_MA_EYEDO
	global.__objectDepths[32] = 0; // O_MA_EYEDL
	global.__objectDepths[33] = 0; // O_MA_EYELE
	global.__objectDepths[34] = 0; // O_MA_EYEUL
	global.__objectDepths[35] = 0; // O_MA_WALL
	global.__objectDepths[36] = 0; // O_MA_YELD
	global.__objectDepths[37] = 0; // O_MA_YELD2
	global.__objectDepths[38] = -100; // O_EFFECTA
	global.__objectDepths[39] = -100; // O_EFFECTB
	global.__objectDepths[40] = 0; // object47
	global.__objectDepths[41] = 0; // object48


	global.__objectNames[0] = "O_ENEMYA";
	global.__objectNames[1] = "O_ENEMYB";
	global.__objectNames[2] = "O_ENEMYD";
	global.__objectNames[3] = "O_ENEMYE";
	global.__objectNames[4] = "O_ENEMYF";
	global.__objectNames[5] = "O_ENEMYG";
	global.__objectNames[6] = "O_ENEMYH";
	global.__objectNames[7] = "O_ENEMYI";
	global.__objectNames[8] = "O_ENEMYJ";
	global.__objectNames[9] = "O_ENEMYK";
	global.__objectNames[10] = "O_MAIN";
	global.__objectNames[11] = "O_MAINB";
	global.__objectNames[12] = "O_MISCA";
	global.__objectNames[13] = "O_MISCB";
	global.__objectNames[14] = "O_MISCC";
	global.__objectNames[15] = "O_MISCD";
	global.__objectNames[16] = "O_MISCE";
	global.__objectNames[17] = "O_MISCG";
	global.__objectNames[18] = "O_MISCH";
	global.__objectNames[19] = "O_MISCI";
	global.__objectNames[20] = "O_MISCJ";
	global.__objectNames[21] = "O_MISCK";
	global.__objectNames[22] = "O_PLAYER";
	global.__objectNames[23] = "O_WEAPON";
	global.__objectNames[24] = "O_WALL";
	global.__objectNames[25] = "O_PIT";
	global.__objectNames[26] = "O_ENEMY";
	global.__objectNames[27] = "O_MA_EYEUP";
	global.__objectNames[28] = "O_MA_EYEUR";
	global.__objectNames[29] = "O_MA_EYERI";
	global.__objectNames[30] = "O_MA_EYEDR";
	global.__objectNames[31] = "O_MA_EYEDO";
	global.__objectNames[32] = "O_MA_EYEDL";
	global.__objectNames[33] = "O_MA_EYELE";
	global.__objectNames[34] = "O_MA_EYEUL";
	global.__objectNames[35] = "O_MA_WALL";
	global.__objectNames[36] = "O_MA_YELD";
	global.__objectNames[37] = "O_MA_YELD2";
	global.__objectNames[38] = "O_EFFECTA";
	global.__objectNames[39] = "O_EFFECTB";
	global.__objectNames[40] = "object47";
	global.__objectNames[41] = "object48";


	// create another array that has the correct entries
	var len = array_length_1d(global.__objectDepths);
	global.__objectID2Depth = [];
	for( var i=0; i<len; ++i ) {
		var objID = asset_get_index( global.__objectNames[i] );
		if (objID >= 0) {
			global.__objectID2Depth[ objID ] = global.__objectDepths[i];
		} // end if
	} // end for


}
