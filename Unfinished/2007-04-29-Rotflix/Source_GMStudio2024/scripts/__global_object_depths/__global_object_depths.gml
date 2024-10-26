function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = -5; // Player
	global.__objectDepths[1] = 0; // Wall
	global.__objectDepths[2] = 0; // Exit
	global.__objectDepths[3] = 1; // Bonus
	global.__objectDepths[4] = 0; // Arrows
	global.__objectDepths[5] = 0; // Crate
	global.__objectDepths[6] = 0; // Trapdoor
	global.__objectDepths[7] = 0; // Enemyone
	global.__objectDepths[8] = 0; // Enemytwo
	global.__objectDepths[9] = 0; // Enemytrheel
	global.__objectDepths[10] = 0; // Enemythreer
	global.__objectDepths[11] = 0; // Enemyfour
	global.__objectDepths[12] = 0; // Enemyfive
	global.__objectDepths[13] = 0; // Enemysix
	global.__objectDepths[14] = 0; // DoorCl
	global.__objectDepths[15] = 0; // DoorOp
	global.__objectDepths[16] = 0; // Orb
	global.__objectDepths[17] = 0; // Trapdoordie
	global.__objectDepths[18] = 0; // Solid
	global.__objectDepths[19] = 10000; // Main
	global.__objectDepths[20] = 0; // Pit
	global.__objectDepths[21] = 0; // OrbFlash


	global.__objectNames[0] = "Player";
	global.__objectNames[1] = "Wall";
	global.__objectNames[2] = "Exit";
	global.__objectNames[3] = "Bonus";
	global.__objectNames[4] = "Arrows";
	global.__objectNames[5] = "Crate";
	global.__objectNames[6] = "Trapdoor";
	global.__objectNames[7] = "Enemyone";
	global.__objectNames[8] = "Enemytwo";
	global.__objectNames[9] = "Enemytrheel";
	global.__objectNames[10] = "Enemythreer";
	global.__objectNames[11] = "Enemyfour";
	global.__objectNames[12] = "Enemyfive";
	global.__objectNames[13] = "Enemysix";
	global.__objectNames[14] = "DoorCl";
	global.__objectNames[15] = "DoorOp";
	global.__objectNames[16] = "Orb";
	global.__objectNames[17] = "Trapdoordie";
	global.__objectNames[18] = "Solid";
	global.__objectNames[19] = "Main";
	global.__objectNames[20] = "Pit";
	global.__objectNames[21] = "OrbFlash";


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
