package Editor{
	import Classes.GFX;
	import Classes.Items.*;
	import Classes.Interactivers.*;
	public function GiveClass(id: uint): Class{
		switch (id){
			case(0): return null;
			case(1): return TNormal.g_normal;
			case(2): return TStrong.g_strong;
			case(3): return TSteel.g_steel;
			case(4): return TBlank.g_blank;
			case(5): return TExit.g;
			case(6): return TBoom.g;
			case(7): return THori.g;
			case(8): return TDiag.g;
			case(9): return TDirt.g;
			case(10): return TDirtBlank.g;
			case(11): return TGate.g_00;
			case(12): return TGate.g_01;
			case(13): return TGate.g_10;
			case(14): return TGate.g_11;
			case(15): return TGate.g_20;
			case(16): return TGate.g_21;
			case(17): return TGate.g_30;
			case(18): return TGate.g_31;
			case(19): return TGate.g_40;
			case(20): return TGate.g_41;
			case(21): return TGate.g_50;
			case(22): return TGate.g_51;
			case(23): return TButton.g_00;
			case(24): return TButton.g_01;
			case(25): return TButton.g_10;
			case(26): return TButton.g_11;
			case(27): return TButton.g_20;
			case(28): return TButton.g_21;
			case(29): return TButton.g_30;
			case(30): return TButton.g_31;
			case(31): return TButton.g_40;
			case(32): return TButton.g_41;
			case(33): return TButton.g_50;
			case(34): return TButton.g_51;
			case(35): return TStronger.g;
			case(36): return TDire.g;
			case(37): return TFragileButton.g_00;
			case(38): return TFragileButton.g_01;
			case(39): return TFragileButton.g_10;
			case(40): return TFragileButton.g_11;
			case(41): return TFragileButton.g_20;
			case(42): return TFragileButton.g_21;
			case(43): return TFragileButton.g_30;
			case(44): return TFragileButton.g_31;
			case(45): return TFragileButton.g_40;
			case(46): return TFragileButton.g_41;
			case(47): return TFragileButton.g_50;
			case(48): return TFragileButton.g_51;
		}
		return null;
	}
}

