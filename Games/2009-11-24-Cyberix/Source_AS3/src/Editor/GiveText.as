package Editor{
	public function GiveText(id:uint):String{
		if (id == 0){return " - FLOOR-\nEmpty / Delete"}
		if (id < 70){return " - FLOOR-\nID: " + id.toString();}
		if (id == 70){return " - ITEM-\nEmpty / Delete"}
		if (id < 140){return " - ITEM-\nWall ID: " + (id - 70).toString();}
		switch (id){
			case(140):return " - ITEM-\nCollectible:\nCherry";
			case(141):return " - ITEM-\nCollectible:\nGreen Apple";
			case(142):return " - ITEM-\nCollectible:\nLemon";
			case(143):return " - ITEM-\nCollectible:\nBananas";
			case(144):return " - ITEM-\nCollectible:\nStrawberry";
			case(145):return " - ITEM-\nCollectible:\nPlum";
			case(146):return " - ITEM-\nCollectible:\nWatermelon";
			case(147):return " - ITEM-\nCollectible:\nGreen Lemon";
			case(148):return " - ITEM-\nCollectible:\nRed Apple";
			case(149):return " - ITEM-\nCollectible:\nOrange";
			case(150):return " - ITEM-\nCollectible:\nCube";
			case(151):return " - ITEM-\nCollectible:\nSpike";
			case(152):return " - ITEM-\nCollectible:\nSphere";
			case(153):return " - ITEM-\nCollectible:\nOctahedron";
			case(154):return " - ITEM-\nCollectible:\nProcessor Unit";
			case(155):return " - ITEM-\nCollectible:\nCondenser";
			case(156):return " - ITEM-\nCollectible:\nChip";
			case(157):return " - ITEM-\nCollectible:\nFloppy Disc";
			case(158):return " - ITEM-\nCollectible:\nBattery";
			case(159):return " - ITEM-\nCollectible:\nCompact Disk";
			case(160):return " - ITEM-\nLevel Exit";
			case(161):return " - ITEM-\nStopper";
			case(162):return " - ITEM-\nBouncer Horizontal Left";
			case(163):return " - ITEM-\nBouncer Horizontal Right";
			case(164):return " - ITEM-\nBouncer Vertical Top";
			case(165):return " - ITEM-\nBouncer Vertical Bottom";
			case(166):return " - ITEM-\nBouncer Diagonal NW / SE";
			case(167):return " - ITEM-\nBouncer Diagonal NE / SW";
			case(168):return " - ITEM-\nCannon Right";
			case(169):return " - ITEM-\nCannon Down";
			case(170):return " - ITEM-\nCannon Left";
			case(171):return " - ITEM-\nCannon Up";
			case(172):return " - ITEM-\nMine";
			case(173):return " - ITEM-\nTeleporter";
			case(174):return " - ITEM-\nCannon Shoot\nButton";
			case(175):return " - ITEM-\nItem Toggle\nButton";
			case(176):return " - ITEM-\nArrow East";
			case(177):return " - ITEM-\nArrow South";
			case(178):return " - ITEM-\nArrow West";
			case(179):return " - ITEM-\nArrow North";
			case(180):return " - ITEM-\nArrow South - East";
			case(181):return " - ITEM-\nArrow South - West";
			case(182):return " - ITEM-\nArrow North - West";
			case(183):return " - ITEM-\nArrow North - East";
			case(184):return " - ITEM-\nArrow Horizontal";
			case(185):return " - ITEM-\nArrow Vertical";
			case(186):return " - ITEM-\nStarting Position";
			case(187):return " - ITEM-\nPierced Wall\nHorizontally";
			case(188):return " - ITEM-\nPierced Wall\nVertically";
			case(189):return " - ITEM-\nPierced Wall\nOrthogonally";
			case(190):return " - ITEM-\nTurn Wall\nCounter - Clockwise";
			case(191):return " - ITEM-\nTurn Wall\nClockwise";
			case(192):return " - ITEM-\nA Hole\nCan be filled with Crate";

			case(200):return " - OBJECT-\nEmpty / Delete";
			case(201):return " - OBJECT-\nWooden Crate\nPushable";
			case(202):return " - OBJECT-\nSteel Crate\nPushable Indestructible";
			case(203):return " - OBJECT-\nIce Crate\nPushable Slides";
			case(204):return " - OBJECT-\nIce Crate\nPushable Slides\nIndestructible";
			case(205):return " - OBJECT-\nWaller\nTurns into wall\nwhen something slides over";
			case(206):return " - OBJECT-\nStarting Position";
			case(207):return " - OBJECT-\nOrtho - East";
			case(208):return " - OBJECT-\nOrtho - South";
			case(209):return " - OBJECT-\nOrtho - West";
			case(210):return " - OBJECT-\nOrtho - North";
			case(211):return " - OBJECT-\nTurner Clockwise\nEast";
			case(212):return " - OBJECT-\nTurner Clockwise\nSouth";
			case(213):return " - OBJECT-\nTurner Clockwise\nWest";
			case(214):return " - OBJECT-\nTurner Clockwise\nNorth";
			case(215):return " - OBJECT-\nTurner Counter Clockwise\nEast";
			case(216):return " - OBJECT-\nTurner Counter Clockwise\nSouth";
			case(217):return " - OBJECT-\nTurner Counter Clockwise\nWest";
			case(218):return " - OBJECT-\nTurner Counter Clockwise\nNorth";
			case(219):return " - OBJECT-\nWaller Clockwise\nEast";
			case(220):return " - OBJECT-\nWaller Clockwise\nSouth";
			case(221):return " - OBJECT-\nWaller Clockwise\nWest";
			case(222):return " - OBJECT-\nWaller Clockwise\nNorth";
			case(223):return " - OBJECT-\nWaller Counter Clockwise\nEast";
			case(224):return " - OBJECT-\nWaller Counter Clockwise\nSouth";
			case(225):return " - OBJECT-\nWaller Counter Clockwise\nWest";
			case(226):return " - OBJECT-\nWaller Counter Clockwise\nNorth";
			case(227):return " - OBJECT-\nMimic";



			case(500):return " - BACKGROUND-\nChange Background";
			case(501):return " - BACKGROUND-\nChange Background";
			case(502):return " - BACKGROUND-\nChange Background";
			case(503):return " - BACKGROUND-\nChange Background";
			case(504):return " - BACKGROUND-\nChange Background";
			case(505):return " - BACKGROUND-\nChange Background";
			case(506):return " - BACKGROUND-\nChange Background";
			case(507):return " - BACKGROUND-\nChange Background";
			case(508):return " - BACKGROUND-\nChange Background";
		}
		return "";
	}
}