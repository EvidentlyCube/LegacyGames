function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = -999; // Main
	global.__objectDepths[1] = 0; // Player
	global.__objectDepths[2] = 0; // Enemy1
	global.__objectDepths[3] = 0; // Enemy2
	global.__objectDepths[4] = 0; // Enemy3
	global.__objectDepths[5] = 0; // Enemy4
	global.__objectDepths[6] = 0; // Blyczk
	global.__objectDepths[7] = 1; // Bullet
	global.__objectDepths[8] = 0; // Ender
	global.__objectDepths[9] = -100; // intrer
	global.__objectDepths[10] = 0; // Funder


	global.__objectNames[0] = "Main";
	global.__objectNames[1] = "Player";
	global.__objectNames[2] = "Enemy1";
	global.__objectNames[3] = "Enemy2";
	global.__objectNames[4] = "Enemy3";
	global.__objectNames[5] = "Enemy4";
	global.__objectNames[6] = "Blyczk";
	global.__objectNames[7] = "Bullet";
	global.__objectNames[8] = "Ender";
	global.__objectNames[9] = "intrer";
	global.__objectNames[10] = "Funder";


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
