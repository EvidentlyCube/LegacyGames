function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = -1; // Master
	global.__objectDepths[1] = 0; // Base_Wht
	global.__objectDepths[2] = 0; // Base_Blk
	global.__objectDepths[3] = 0; // Base_Red
	global.__objectDepths[4] = 0; // Base_Orn
	global.__objectDepths[5] = 0; // Base_Yll
	global.__objectDepths[6] = 0; // Base_Grn
	global.__objectDepths[7] = 0; // Base_Trq
	global.__objectDepths[8] = 0; // Base_Blu
	global.__objectDepths[9] = 0; // Base_Vlt
	global.__objectDepths[10] = 0; // Path_Wht
	global.__objectDepths[11] = 0; // Path_Blk
	global.__objectDepths[12] = 0; // Path_Red
	global.__objectDepths[13] = 0; // Path_Orn
	global.__objectDepths[14] = 0; // Path_Yll
	global.__objectDepths[15] = 0; // Path_Grn
	global.__objectDepths[16] = 0; // Path_Trq
	global.__objectDepths[17] = 0; // Path_Blu
	global.__objectDepths[18] = 0; // Path_Vlt
	global.__objectDepths[19] = 0; // Base
	global.__objectDepths[20] = 0; // Path
	global.__objectDepths[21] = 0; // Objects
	global.__objectDepths[22] = 0; // Block
	global.__objectDepths[23] = -666; // L_Starter
	global.__objectDepths[24] = -666; // L_Ender
	global.__objectDepths[25] = -100; // L_Ed_Infer
	global.__objectDepths[26] = -100; // LB_Note
	global.__objectDepths[27] = 0; // Level_Browser
	global.__objectDepths[28] = 0; // Titler
	global.__objectDepths[29] = -100; // O_Intrer
	global.__objectDepths[30] = -666; // O_Intrer2
	global.__objectDepths[31] = -666; // O_Intrer3
	global.__objectDepths[32] = -666666; // Cursor
	global.__objectDepths[33] = 0; // Gamendorer
	global.__objectDepths[34] = -666666; // Faderiner
	global.__objectDepths[35] = 0; // Trophy


	global.__objectNames[0] = "Master";
	global.__objectNames[1] = "Base_Wht";
	global.__objectNames[2] = "Base_Blk";
	global.__objectNames[3] = "Base_Red";
	global.__objectNames[4] = "Base_Orn";
	global.__objectNames[5] = "Base_Yll";
	global.__objectNames[6] = "Base_Grn";
	global.__objectNames[7] = "Base_Trq";
	global.__objectNames[8] = "Base_Blu";
	global.__objectNames[9] = "Base_Vlt";
	global.__objectNames[10] = "Path_Wht";
	global.__objectNames[11] = "Path_Blk";
	global.__objectNames[12] = "Path_Red";
	global.__objectNames[13] = "Path_Orn";
	global.__objectNames[14] = "Path_Yll";
	global.__objectNames[15] = "Path_Grn";
	global.__objectNames[16] = "Path_Trq";
	global.__objectNames[17] = "Path_Blu";
	global.__objectNames[18] = "Path_Vlt";
	global.__objectNames[19] = "Base";
	global.__objectNames[20] = "Path";
	global.__objectNames[21] = "Objects";
	global.__objectNames[22] = "Block";
	global.__objectNames[23] = "L_Starter";
	global.__objectNames[24] = "L_Ender";
	global.__objectNames[25] = "L_Ed_Infer";
	global.__objectNames[26] = "LB_Note";
	global.__objectNames[27] = "Level_Browser";
	global.__objectNames[28] = "Titler";
	global.__objectNames[29] = "O_Intrer";
	global.__objectNames[30] = "O_Intrer2";
	global.__objectNames[31] = "O_Intrer3";
	global.__objectNames[32] = "Cursor";
	global.__objectNames[33] = "Gamendorer";
	global.__objectNames[34] = "Faderiner";
	global.__objectNames[35] = "Trophy";


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
