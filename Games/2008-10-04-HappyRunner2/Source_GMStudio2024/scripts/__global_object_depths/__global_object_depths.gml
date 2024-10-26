function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = -1; // Player
	global.__objectDepths[1] = 0; // Wall
	global.__objectDepths[2] = 0; // Bonus
	global.__objectDepths[3] = 0; // Bonus_Pa
	global.__objectDepths[4] = 0; // Blejbor
	global.__objectDepths[5] = 0; // Triangler_1
	global.__objectDepths[6] = 0; // Follower_1
	global.__objectDepths[7] = 0; // Hihol_1
	global.__objectDepths[8] = 0; // Triangler_2
	global.__objectDepths[9] = 0; // Follower_2
	global.__objectDepths[10] = 0; // Hihol_2
	global.__objectDepths[11] = 0; // Triangler_3
	global.__objectDepths[12] = 0; // Follower_3
	global.__objectDepths[13] = 0; // Hihol_3
	global.__objectDepths[14] = 0; // Triangler_4
	global.__objectDepths[15] = 0; // Follower_4
	global.__objectDepths[16] = 0; // Hihol_4
	global.__objectDepths[17] = 0; // Triangler_5
	global.__objectDepths[18] = 0; // Follower_5
	global.__objectDepths[19] = 0; // Hihol_5
	global.__objectDepths[20] = 0; // Spike_Down
	global.__objectDepths[21] = 0; // Spike_Up
	global.__objectDepths[22] = 0; // Direr
	global.__objectDepths[23] = 0; // Xit
	global.__objectDepths[24] = 0; // Level_Elector
	global.__objectDepths[25] = 0; // Plaster
	global.__objectDepths[26] = 0; // saver


	global.__objectNames[0] = "Player";
	global.__objectNames[1] = "Wall";
	global.__objectNames[2] = "Bonus";
	global.__objectNames[3] = "Bonus_Pa";
	global.__objectNames[4] = "Blejbor";
	global.__objectNames[5] = "Triangler_1";
	global.__objectNames[6] = "Follower_1";
	global.__objectNames[7] = "Hihol_1";
	global.__objectNames[8] = "Triangler_2";
	global.__objectNames[9] = "Follower_2";
	global.__objectNames[10] = "Hihol_2";
	global.__objectNames[11] = "Triangler_3";
	global.__objectNames[12] = "Follower_3";
	global.__objectNames[13] = "Hihol_3";
	global.__objectNames[14] = "Triangler_4";
	global.__objectNames[15] = "Follower_4";
	global.__objectNames[16] = "Hihol_4";
	global.__objectNames[17] = "Triangler_5";
	global.__objectNames[18] = "Follower_5";
	global.__objectNames[19] = "Hihol_5";
	global.__objectNames[20] = "Spike_Down";
	global.__objectNames[21] = "Spike_Up";
	global.__objectNames[22] = "Direr";
	global.__objectNames[23] = "Xit";
	global.__objectNames[24] = "Level_Elector";
	global.__objectNames[25] = "Plaster";
	global.__objectNames[26] = "saver";


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
