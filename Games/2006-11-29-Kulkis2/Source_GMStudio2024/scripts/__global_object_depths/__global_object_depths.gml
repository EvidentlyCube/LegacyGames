function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = 5; // Main
	global.__objectDepths[1] = 5; // Main2
	global.__objectDepths[2] = 0; // Magician
	global.__objectDepths[3] = 0; // Master_Wall
	global.__objectDepths[4] = 0; // Blocker
	global.__objectDepths[5] = -500; // Land
	global.__objectDepths[6] = -500; // Rugged
	global.__objectDepths[7] = -500; // Ice
	global.__objectDepths[8] = 0; // SolidWalls
	global.__objectDepths[9] = 0; // Left
	global.__objectDepths[10] = 0; // Right
	global.__objectDepths[11] = 0; // Up
	global.__objectDepths[12] = 0; // Down
	global.__objectDepths[13] = -5000; // WallDeleter
	global.__objectDepths[14] = 0; // Waller
	global.__objectDepths[15] = -50; // Body
	global.__objectDepths[16] = -60; // Acid
	global.__objectDepths[17] = 0; // SmallBlack
	global.__objectDepths[18] = 0; // SmallRed
	global.__objectDepths[19] = 0; // SmallGold
	global.__objectDepths[20] = 0; // SmallYellow
	global.__objectDepths[21] = 0; // SmallGreen
	global.__objectDepths[22] = 0; // SmallCyan
	global.__objectDepths[23] = 0; // SmallBlue
	global.__objectDepths[24] = 0; // SmallViolet
	global.__objectDepths[25] = 0; // SmallWhite
	global.__objectDepths[26] = -950; // SmallExploder
	global.__objectDepths[27] = -950; // BodyDie
	global.__objectDepths[28] = -950; // EyesDie
	global.__objectDepths[29] = 0; // BombFlame
	global.__objectDepths[30] = 0; // Bomber
	global.__objectDepths[31] = 0; // Explosion
	global.__objectDepths[32] = 0; // GrayExplosion
	global.__objectDepths[33] = 0; // ColourerBlack
	global.__objectDepths[34] = 0; // ColourerRed
	global.__objectDepths[35] = 0; // ColourerGold
	global.__objectDepths[36] = 0; // ColourerYellow
	global.__objectDepths[37] = 0; // ColourerGreen
	global.__objectDepths[38] = 0; // ColourerCyan
	global.__objectDepths[39] = 0; // ColourerBlue
	global.__objectDepths[40] = 0; // ColourerViolet
	global.__objectDepths[41] = 0; // ColourerWhite
	global.__objectDepths[42] = -500; // WallA
	global.__objectDepths[43] = -500; // WallB
	global.__objectDepths[44] = -500; // WallC
	global.__objectDepths[45] = -500; // WallD_A
	global.__objectDepths[46] = -500; // WallD_B
	global.__objectDepths[47] = -500; // WallD_C
	global.__objectDepths[48] = -500; // WallD_D
	global.__objectDepths[49] = -500; // WallE
	global.__objectDepths[50] = -10; // Barrel
	global.__objectDepths[51] = -10; // Crate
	global.__objectDepths[52] = -10; // StellCrate
	global.__objectDepths[53] = 0; // Bomb
	global.__objectDepths[54] = -9999; // MoverR
	global.__objectDepths[55] = -9999; // MoverD
	global.__objectDepths[56] = -9999; // MoverL
	global.__objectDepths[57] = -9999; // MoverU
	global.__objectDepths[58] = 3; // Button
	global.__objectDepths[59] = -1000; // Exit
	global.__objectDepths[60] = -1000; // Exit2
	global.__objectDepths[61] = -1000; // Exit_Active
	global.__objectDepths[62] = -1000; // Exit2_Active
	global.__objectDepths[63] = 1; // BombBonus
	global.__objectDepths[64] = 1; // CheckPoint
	global.__objectDepths[65] = 1; // DiamondA
	global.__objectDepths[66] = 1; // DiamondB
	global.__objectDepths[67] = 0; // BatH
	global.__objectDepths[68] = 0; // BatV
	global.__objectDepths[69] = 0; // RotterR
	global.__objectDepths[70] = 0; // RotterL
	global.__objectDepths[71] = 0; // SpikerU___
	global.__objectDepths[72] = 0; // Spiker_R__
	global.__objectDepths[73] = 0; // Spiker__D_
	global.__objectDepths[74] = 0; // Spiker___L
	global.__objectDepths[75] = 0; // SpikerU_D_
	global.__objectDepths[76] = 0; // Spiker_R_L
	global.__objectDepths[77] = 0; // SpikerURDL
	global.__objectDepths[78] = 0; // EyerL
	global.__objectDepths[79] = 0; // EyerR
	global.__objectDepths[80] = 0; // Thorner
	global.__objectDepths[81] = 0; // Pit
	global.__objectDepths[82] = 0; // Blyk
	global.__objectDepths[83] = -10; // Cannon
	global.__objectDepths[84] = 0; // Shot
	global.__objectDepths[85] = -9999; // Died
	global.__objectDepths[86] = 0; // DoorBlack
	global.__objectDepths[87] = 0; // DoorRed
	global.__objectDepths[88] = 0; // DoorGold
	global.__objectDepths[89] = 0; // DoorYellow
	global.__objectDepths[90] = 0; // DoorGreen
	global.__objectDepths[91] = 0; // DoorCyan
	global.__objectDepths[92] = 0; // DoorBlue
	global.__objectDepths[93] = 0; // DoorViolet
	global.__objectDepths[94] = 0; // DoorWhite
	global.__objectDepths[95] = 0; // BreakDoor
	global.__objectDepths[96] = 0; // KeyBlack
	global.__objectDepths[97] = 0; // KeyRed
	global.__objectDepths[98] = 0; // KeyGold
	global.__objectDepths[99] = 0; // KeyYellow
	global.__objectDepths[100] = 0; // KeyGreen
	global.__objectDepths[101] = 0; // KeyCyan
	global.__objectDepths[102] = 0; // KeyBlue
	global.__objectDepths[103] = 0; // KeyViolet
	global.__objectDepths[104] = 0; // KeyWhite
	global.__objectDepths[105] = 0; // Blockers
	global.__objectDepths[106] = 5; // Spidy
	global.__objectDepths[107] = -999999999; // MakingKit
	global.__objectDepths[108] = 0; // Intrer
	global.__objectDepths[109] = 0; // Menuerone
	global.__objectDepths[110] = 0; // Selectator
	global.__objectDepths[111] = 0; // Disclaimerer
	global.__objectDepths[112] = 0; // Gamendor


	global.__objectNames[0] = "Main";
	global.__objectNames[1] = "Main2";
	global.__objectNames[2] = "Magician";
	global.__objectNames[3] = "Master_Wall";
	global.__objectNames[4] = "Blocker";
	global.__objectNames[5] = "Land";
	global.__objectNames[6] = "Rugged";
	global.__objectNames[7] = "Ice";
	global.__objectNames[8] = "SolidWalls";
	global.__objectNames[9] = "Left";
	global.__objectNames[10] = "Right";
	global.__objectNames[11] = "Up";
	global.__objectNames[12] = "Down";
	global.__objectNames[13] = "WallDeleter";
	global.__objectNames[14] = "Waller";
	global.__objectNames[15] = "Body";
	global.__objectNames[16] = "Acid";
	global.__objectNames[17] = "SmallBlack";
	global.__objectNames[18] = "SmallRed";
	global.__objectNames[19] = "SmallGold";
	global.__objectNames[20] = "SmallYellow";
	global.__objectNames[21] = "SmallGreen";
	global.__objectNames[22] = "SmallCyan";
	global.__objectNames[23] = "SmallBlue";
	global.__objectNames[24] = "SmallViolet";
	global.__objectNames[25] = "SmallWhite";
	global.__objectNames[26] = "SmallExploder";
	global.__objectNames[27] = "BodyDie";
	global.__objectNames[28] = "EyesDie";
	global.__objectNames[29] = "BombFlame";
	global.__objectNames[30] = "Bomber";
	global.__objectNames[31] = "Explosion";
	global.__objectNames[32] = "GrayExplosion";
	global.__objectNames[33] = "ColourerBlack";
	global.__objectNames[34] = "ColourerRed";
	global.__objectNames[35] = "ColourerGold";
	global.__objectNames[36] = "ColourerYellow";
	global.__objectNames[37] = "ColourerGreen";
	global.__objectNames[38] = "ColourerCyan";
	global.__objectNames[39] = "ColourerBlue";
	global.__objectNames[40] = "ColourerViolet";
	global.__objectNames[41] = "ColourerWhite";
	global.__objectNames[42] = "WallA";
	global.__objectNames[43] = "WallB";
	global.__objectNames[44] = "WallC";
	global.__objectNames[45] = "WallD_A";
	global.__objectNames[46] = "WallD_B";
	global.__objectNames[47] = "WallD_C";
	global.__objectNames[48] = "WallD_D";
	global.__objectNames[49] = "WallE";
	global.__objectNames[50] = "Barrel";
	global.__objectNames[51] = "Crate";
	global.__objectNames[52] = "StellCrate";
	global.__objectNames[53] = "Bomb";
	global.__objectNames[54] = "MoverR";
	global.__objectNames[55] = "MoverD";
	global.__objectNames[56] = "MoverL";
	global.__objectNames[57] = "MoverU";
	global.__objectNames[58] = "Button";
	global.__objectNames[59] = "Exit";
	global.__objectNames[60] = "Exit2";
	global.__objectNames[61] = "Exit_Active";
	global.__objectNames[62] = "Exit2_Active";
	global.__objectNames[63] = "BombBonus";
	global.__objectNames[64] = "CheckPoint";
	global.__objectNames[65] = "DiamondA";
	global.__objectNames[66] = "DiamondB";
	global.__objectNames[67] = "BatH";
	global.__objectNames[68] = "BatV";
	global.__objectNames[69] = "RotterR";
	global.__objectNames[70] = "RotterL";
	global.__objectNames[71] = "SpikerU___";
	global.__objectNames[72] = "Spiker_R__";
	global.__objectNames[73] = "Spiker__D_";
	global.__objectNames[74] = "Spiker___L";
	global.__objectNames[75] = "SpikerU_D_";
	global.__objectNames[76] = "Spiker_R_L";
	global.__objectNames[77] = "SpikerURDL";
	global.__objectNames[78] = "EyerL";
	global.__objectNames[79] = "EyerR";
	global.__objectNames[80] = "Thorner";
	global.__objectNames[81] = "Pit";
	global.__objectNames[82] = "Blyk";
	global.__objectNames[83] = "Cannon";
	global.__objectNames[84] = "Shot";
	global.__objectNames[85] = "Died";
	global.__objectNames[86] = "DoorBlack";
	global.__objectNames[87] = "DoorRed";
	global.__objectNames[88] = "DoorGold";
	global.__objectNames[89] = "DoorYellow";
	global.__objectNames[90] = "DoorGreen";
	global.__objectNames[91] = "DoorCyan";
	global.__objectNames[92] = "DoorBlue";
	global.__objectNames[93] = "DoorViolet";
	global.__objectNames[94] = "DoorWhite";
	global.__objectNames[95] = "BreakDoor";
	global.__objectNames[96] = "KeyBlack";
	global.__objectNames[97] = "KeyRed";
	global.__objectNames[98] = "KeyGold";
	global.__objectNames[99] = "KeyYellow";
	global.__objectNames[100] = "KeyGreen";
	global.__objectNames[101] = "KeyCyan";
	global.__objectNames[102] = "KeyBlue";
	global.__objectNames[103] = "KeyViolet";
	global.__objectNames[104] = "KeyWhite";
	global.__objectNames[105] = "Blockers";
	global.__objectNames[106] = "Spidy";
	global.__objectNames[107] = "MakingKit";
	global.__objectNames[108] = "Intrer";
	global.__objectNames[109] = "Menuerone";
	global.__objectNames[110] = "Selectator";
	global.__objectNames[111] = "Disclaimerer";
	global.__objectNames[112] = "Gamendor";


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