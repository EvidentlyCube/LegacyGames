package Editor{
	public function GiveText(id: uint): String{
		switch (id){
			case(0): return "Empty / Pit";
			case(1): return "Tile";
			case(2): return "Strong Tile";
			case(3): return "Steel Tile";
			case(4): return "Walkable Floor";
			case(5): return "Level Exit";
			case(6): return "Bomb Tile";
			case(7): return "Ortho Tile";
			case(8): return "Diago Tile";
			case(9): return "Dirty Tile";
			case(10): return "Dirty Walkable Floor";
			case(11): return "Green Gate Closed";
			case(12): return "Green Gate Opened";
			case(13): return "Yellow Gate Closed";
			case(14): return "Yelow Gate Opened";
			case(15): return "Blue Gate Closed";
			case(16): return "Blue Gate Opened";
			case(17): return "Brown Gate Closed";
			case(18): return "Brown Gate Opened";
			case(19): return "Violet Gate Closed";
			case(20): return "Violet Gate Opened";
			case(21): return "White Gate Closed";
			case(22): return "White Gate Opened";
			case(23): return "Green Button Unpressed";
			case(24): return "Green Button Pressed";
			case(25): return "Yellow Button Unpressed";
			case(26): return "Yelow Button Pressed";
			case(27): return "Blue Button Unpressed";
			case(28): return "Blue Button Pressed";
			case(29): return "Brown Button Unpressed";
			case(30): return "Brown Button Pressed";
			case(31): return "Violet Button Unpressed";
			case(32): return "Violet Button Pressed";
			case(33): return "White Button Unpressed";
			case(34): return "White Button Pressed";
			case(35): return "Stronger Tile";
			case(36): return "Direction Tile";
			case(37): return "Fragile Green Button Unpressed";
			case(38): return "Fragile Green Button Pressed";
			case(39): return "Fragile Yellow Button Unpressed";
			case(40): return "Fragile Yelow Button Pressed";
			case(41): return "Fragile Blue Button Unpressed";
			case(42): return "Fragile Blue Button Pressed";
			case(43): return "Fragile Brown Button Unpressed";
			case(44): return "Fragile Brown Button Pressed";
			case(45): return "Fragile Violet Button Unpressed";
			case(46): return "Fragile Violet Button Pressed";
			case(47): return "Fragile White Button Unpressed";
			case(48): return "Fragile White Button Pressed";
		}
		return "";
	}
}

