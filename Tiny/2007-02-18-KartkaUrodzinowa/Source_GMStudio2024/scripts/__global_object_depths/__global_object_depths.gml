function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = 2; // object0
	global.__objectDepths[1] = 0; // object1
	global.__objectDepths[2] = 2; // object2
	global.__objectDepths[3] = 0; // object3
	global.__objectDepths[4] = 2; // object4
	global.__objectDepths[5] = 0; // object5
	global.__objectDepths[6] = 1; // object6
	global.__objectDepths[7] = 1; // object7
	global.__objectDepths[8] = 0; // object8
	global.__objectDepths[9] = 0; // object10
	global.__objectDepths[10] = 0; // object9


	global.__objectNames[0] = "object0";
	global.__objectNames[1] = "object1";
	global.__objectNames[2] = "object2";
	global.__objectNames[3] = "object3";
	global.__objectNames[4] = "object4";
	global.__objectNames[5] = "object5";
	global.__objectNames[6] = "object6";
	global.__objectNames[7] = "object7";
	global.__objectNames[8] = "object8";
	global.__objectNames[9] = "object10";
	global.__objectNames[10] = "object9";


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
