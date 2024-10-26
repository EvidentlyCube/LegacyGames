function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = 0; // flame
	global.__objectDepths[1] = 0; // Enemies
	global.__objectDepths[2] = 0; // Enemy_1
	global.__objectDepths[3] = 0; // Enemy_2
	global.__objectDepths[4] = 0; // Enemy_3
	global.__objectDepths[5] = 0; // Enemy_4
	global.__objectDepths[6] = 1; // Enemy_Wall
	global.__objectDepths[7] = 0; // Main
	global.__objectDepths[8] = -1; // Player
	global.__objectDepths[9] = 0; // Shot_1
	global.__objectDepths[10] = 0; // Shot_2
	global.__objectDepths[11] = 0; // Shot_6
	global.__objectDepths[12] = 0; // Shot_3
	global.__objectDepths[13] = 0; // Shot_4
	global.__objectDepths[14] = 0; // Shot_5


	global.__objectNames[0] = "flame";
	global.__objectNames[1] = "Enemies";
	global.__objectNames[2] = "Enemy_1";
	global.__objectNames[3] = "Enemy_2";
	global.__objectNames[4] = "Enemy_3";
	global.__objectNames[5] = "Enemy_4";
	global.__objectNames[6] = "Enemy_Wall";
	global.__objectNames[7] = "Main";
	global.__objectNames[8] = "Player";
	global.__objectNames[9] = "Shot_1";
	global.__objectNames[10] = "Shot_2";
	global.__objectNames[11] = "Shot_6";
	global.__objectNames[12] = "Shot_3";
	global.__objectNames[13] = "Shot_4";
	global.__objectNames[14] = "Shot_5";


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
