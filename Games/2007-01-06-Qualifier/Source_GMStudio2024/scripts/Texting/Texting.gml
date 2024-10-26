function Texting() {
	if keyboard_key=8{return("back");exit}
	if !keyboard_check(vk_shift){
	switch (keyboard_key){
	case(48):return("0");exit;
	case(49):return("1");exit;
	case(50):return("2");exit;
	case(51):return("3");exit;
	case(52):return("4");exit;
	case(53):return("5");exit;
	case(54):return("6");exit;
	case(55):return("7");exit;
	case(56):return("8");exit;
	case(57):return("9");exit;
	case(65):return("a");exit;
	case(66):return("b");exit;
	case(67):return("c");exit;
	case(68):return("d");exit;
	case(69):return("e");exit;
	case(70):return("f");exit;
	case(71):return("g");exit;
	case(72):return("h");exit;
	case(73):return("i");exit;
	case(74):return("j");exit;
	case(75):return("k");exit;
	case(76):return("l");exit;
	case(77):return("m");exit;
	case(78):return("n");exit;
	case(79):return("o");exit;
	case(80):return("p");exit;
	case(81):return("q");exit;
	case(82):return("r");exit;
	case(83):return("s");exit;
	case(84):return("t");exit;
	case(85):return("u");exit;
	case(86):return("v");exit;
	case(87):return("w");exit;
	case(88):return("x");exit;
	case(89):return("y");exit;
	case(90):return("z");exit;
	case(190):return(".");exit;
	case(191):return("/");exit;
	case(189):return("-");exit;
	case(187):return("=");exit;
	case(220):return("\\");exit;
	case(32):return(" ");exit;
	}
	} else {
	switch (keyboard_key){
	case(48):return(")");exit;
	case(49):return("!");exit;
	case(50):return("@");exit;
	case(53):return("%");exit;
	case(55):return("&");exit;
	case(56):return("*");exit;
	case(57):return("(");exit;
	case(65):return("A");exit;
	case(66):return("B");exit;
	case(67):return("C");exit;
	case(68):return("D");exit;
	case(69):return("E");exit;
	case(70):return("F");exit;
	case(71):return("G");exit;
	case(72):return("H");exit;
	case(73):return("I");exit;
	case(74):return("J");exit;
	case(75):return("K");exit;
	case(76):return("L");exit;
	case(77):return("M");exit;
	case(78):return("N");exit;
	case(79):return("O");exit;
	case(80):return("P");exit;
	case(81):return("Q");exit;
	case(82):return("R");exit;
	case(83):return("S");exit;
	case(84):return("T");exit;
	case(85):return("U");exit;
	case(86):return("V");exit;
	case(87):return("W");exit;
	case(88):return("X");exit;
	case(89):return("Y");exit;
	case(90):return("Z");exit;
	case(191):return("?");exit;
	case(186):return(":");exit;
	case(189):return("_");exit;
	case(192):return("~");exit;
	}
	}
	return("")



}
