function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = -1000; // Master
	global.__objectDepths[1] = -1; // Master_Wall
	global.__objectDepths[2] = 0; // Wall
	global.__objectDepths[3] = -999999; // Mushroom
	global.__objectDepths[4] = -20; // Player
	global.__objectDepths[5] = -20; // Player_Stop
	global.__objectDepths[6] = 0; // Colourer
	global.__objectDepths[7] = 0; // Blocker
	global.__objectDepths[8] = 0; // Button
	global.__objectDepths[9] = 0; // Switch
	global.__objectDepths[10] = 0; // Door
	global.__objectDepths[11] = -5; // Door_Base
	global.__objectDepths[12] = 0; // Crate
	global.__objectDepths[13] = 0; // Arrow
	global.__objectDepths[14] = 0; // Bouncer_H
	global.__objectDepths[15] = 0; // Bouncer_V
	global.__objectDepths[16] = 0; // Rotter_R
	global.__objectDepths[17] = 0; // Rotter_L
	global.__objectDepths[18] = 0; // Spikes
	global.__objectDepths[19] = 0; // Thorner_Orth
	global.__objectDepths[20] = 0; // Thorner_Diag
	global.__objectDepths[21] = 0; // mc_Color
	global.__objectDepths[22] = 0; // mc_Red
	global.__objectDepths[23] = 0; // mc_Orn
	global.__objectDepths[24] = 0; // mc_Yll
	global.__objectDepths[25] = 0; // mc_Grn
	global.__objectDepths[26] = 0; // mc_Trq
	global.__objectDepths[27] = 0; // mc_Blu
	global.__objectDepths[28] = 0; // mc_Vio
	global.__objectDepths[29] = 0; // mc_Wht
	global.__objectDepths[30] = 0; // mc_Blk
	global.__objectDepths[31] = 0; // m_Increm
	global.__objectDepths[32] = 0; // Par_Walls
	global.__objectDepths[33] = 0; // Par_GFX_Walls
	global.__objectDepths[34] = 0; // Par_Enemies
	global.__objectDepths[35] = -99999; // Blinker
	global.__objectDepths[36] = -99999; // Blinker_Static
	global.__objectDepths[37] = 0; // Acid
	global.__objectDepths[38] = 0; // Blocker_Diss
	global.__objectDepths[39] = 0; // Cracks
	global.__objectDepths[40] = 0; // Grass
	global.__objectDepths[41] = -6666; // Talker
	global.__objectDepths[42] = 0; // Talk_Act
	global.__objectDepths[43] = 0; // Waiten


	global.__objectNames[0] = "Master";
	global.__objectNames[1] = "Master_Wall";
	global.__objectNames[2] = "Wall";
	global.__objectNames[3] = "Mushroom";
	global.__objectNames[4] = "Player";
	global.__objectNames[5] = "Player_Stop";
	global.__objectNames[6] = "Colourer";
	global.__objectNames[7] = "Blocker";
	global.__objectNames[8] = "Button";
	global.__objectNames[9] = "Switch";
	global.__objectNames[10] = "Door";
	global.__objectNames[11] = "Door_Base";
	global.__objectNames[12] = "Crate";
	global.__objectNames[13] = "Arrow";
	global.__objectNames[14] = "Bouncer_H";
	global.__objectNames[15] = "Bouncer_V";
	global.__objectNames[16] = "Rotter_R";
	global.__objectNames[17] = "Rotter_L";
	global.__objectNames[18] = "Spikes";
	global.__objectNames[19] = "Thorner_Orth";
	global.__objectNames[20] = "Thorner_Diag";
	global.__objectNames[21] = "mc_Color";
	global.__objectNames[22] = "mc_Red";
	global.__objectNames[23] = "mc_Orn";
	global.__objectNames[24] = "mc_Yll";
	global.__objectNames[25] = "mc_Grn";
	global.__objectNames[26] = "mc_Trq";
	global.__objectNames[27] = "mc_Blu";
	global.__objectNames[28] = "mc_Vio";
	global.__objectNames[29] = "mc_Wht";
	global.__objectNames[30] = "mc_Blk";
	global.__objectNames[31] = "m_Increm";
	global.__objectNames[32] = "Par_Walls";
	global.__objectNames[33] = "Par_GFX_Walls";
	global.__objectNames[34] = "Par_Enemies";
	global.__objectNames[35] = "Blinker";
	global.__objectNames[36] = "Blinker_Static";
	global.__objectNames[37] = "Acid";
	global.__objectNames[38] = "Blocker_Diss";
	global.__objectNames[39] = "Cracks";
	global.__objectNames[40] = "Grass";
	global.__objectNames[41] = "Talker";
	global.__objectNames[42] = "Talk_Act";
	global.__objectNames[43] = "Waiten";


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
