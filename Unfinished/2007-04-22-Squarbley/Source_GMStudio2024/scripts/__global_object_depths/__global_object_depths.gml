function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = -999; // Player
	global.__objectDepths[1] = -100; // Look2
	global.__objectDepths[2] = -100; // Look
	global.__objectDepths[3] = 0; // Wall
	global.__objectDepths[4] = 0; // Spike1
	global.__objectDepths[5] = 0; // Spike2
	global.__objectDepths[6] = 0; // Spike3
	global.__objectDepths[7] = 0; // Spike4
	global.__objectDepths[8] = 0; // Wallo
	global.__objectDepths[9] = -1; // Teeth


	global.__objectNames[0] = "Player";
	global.__objectNames[1] = "Look2";
	global.__objectNames[2] = "Look";
	global.__objectNames[3] = "Wall";
	global.__objectNames[4] = "Spike1";
	global.__objectNames[5] = "Spike2";
	global.__objectNames[6] = "Spike3";
	global.__objectNames[7] = "Spike4";
	global.__objectNames[8] = "Wallo";
	global.__objectNames[9] = "Teeth";


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
