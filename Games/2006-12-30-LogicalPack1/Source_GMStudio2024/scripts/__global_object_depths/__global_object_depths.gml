function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = 0; // i_toggler
	global.__objectDepths[1] = -999; // i_master
	global.__objectDepths[2] = 0; // i_rlg
	global.__objectDepths[3] = 0; // i_wall
	global.__objectDepths[4] = 0; // i_creator
	global.__objectDepths[5] = 0; // i_disp
	global.__objectDepths[6] = -999; // ii_master
	global.__objectDepths[7] = 0; // ii_block
	global.__objectDepths[8] = 0; // ii_objectivers
	global.__objectDepths[9] = 1; // ii_objplaces
	global.__objectDepths[10] = 0; // ii_rlg
	global.__objectDepths[11] = -100; // menur
	global.__objectDepths[12] = -100; // intrer
	global.__objectDepths[13] = 0; // mainmi
	global.__objectDepths[14] = 0; // mainmii
	global.__objectDepths[15] = 0; // mainmiii
	global.__objectDepths[16] = 0; // mainmiiii
	global.__objectDepths[17] = 0; // attentioner
	global.__objectDepths[18] = 0; // mainmiiiii
	global.__objectDepths[19] = 0; // togmen
	global.__objectDepths[20] = 0; // cardmen
	global.__objectDepths[21] = 0; // ende
	global.__objectDepths[22] = 0; // endex


	global.__objectNames[0] = "i_toggler";
	global.__objectNames[1] = "i_master";
	global.__objectNames[2] = "i_rlg";
	global.__objectNames[3] = "i_wall";
	global.__objectNames[4] = "i_creator";
	global.__objectNames[5] = "i_disp";
	global.__objectNames[6] = "ii_master";
	global.__objectNames[7] = "ii_block";
	global.__objectNames[8] = "ii_objectivers";
	global.__objectNames[9] = "ii_objplaces";
	global.__objectNames[10] = "ii_rlg";
	global.__objectNames[11] = "menur";
	global.__objectNames[12] = "intrer";
	global.__objectNames[13] = "mainmi";
	global.__objectNames[14] = "mainmii";
	global.__objectNames[15] = "mainmiii";
	global.__objectNames[16] = "mainmiiii";
	global.__objectNames[17] = "attentioner";
	global.__objectNames[18] = "mainmiiiii";
	global.__objectNames[19] = "togmen";
	global.__objectNames[20] = "cardmen";
	global.__objectNames[21] = "ende";
	global.__objectNames[22] = "endex";


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
