package Editor{
	import Classes.GFX;
	import Classes.Items.*;
	import Classes.Interactivers.*;
	public function GiveClass(id:uint):Class{
		if (id === 999) {
			var itemClass: Class;
			while (!itemClass) {
				id = Math.floor(Math.random() * 206);
				if (id === 186) {
					continue;
				}

				itemClass = Editor.GiveClass(id);
			}

			return itemClass;
		}

		switch (id){
			case(0): return null;
			case(1): return GFX.f_00;
			case(2): return GFX.f_01;
			case(3): return GFX.f_02;
			case(4): return GFX.f_03;
			case(5): return GFX.f_04;
			case(6): return GFX.f_05;
			case(7): return GFX.f_06;
			case(8): return GFX.f_07;
			case(9): return GFX.f_08;
			case(10): return GFX.f_09;
			case(11): return GFX.f_10;
			case(12): return GFX.f_11;
			case(13): return GFX.f_12;
			case(14): return GFX.f_13;
			case(15): return GFX.f_14;
			case(16): return GFX.f_15;
			case(17): return GFX.f_16;
			case(18): return GFX.f_17;
			case(19): return GFX.f_18;
			case(20): return GFX.f_19;
			case(21): return GFX.f_20;
			case(22): return GFX.f_21;
			case(23): return GFX.f_22;
			case(24): return GFX.f_23;
			case(25): return GFX.f_24;
			case(26): return GFX.f_25;
			case(27): return GFX.f_26;
			case(28): return GFX.f_27;
			case(29): return GFX.f_28;
			case(30): return GFX.f_29;
			case(31): return GFX.f_30;
			case(32): return GFX.f_31;
			case(33): return GFX.f_32;
			case(34): return GFX.f_33;
			case(35): return GFX.f_34;
			case(36): return GFX.f_35;
			case(37): return GFX.f_36;
			case(38): return GFX.f_37;
			case(39): return GFX.f_38;
			case(40): return GFX.f_39;
			case(41): return GFX.f_40;
			case(42): return GFX.f_41;
			case(43): return GFX.f_42;
			case(44): return GFX.f_43;
			case(45): return GFX.f_44;
			case(46): return GFX.f_45;
			case(47): return GFX.f_46;
			case(48): return GFX.f_47;
			case(49): return GFX.f_48;
			case(50): return GFX.f_49;
			case(51): return GFX.f_50;
			case(52): return GFX.f_51;
			case(53): return GFX.f_52;
			case(54): return GFX.f_53;
			case(55): return GFX.f_54;
			case(56): return GFX.f_55;
			case(57): return GFX.f_56;
			case(58): return GFX.f_57;
			case(59): return GFX.f_58;
			case(60): return GFX.f_59;
			case(61): return GFX.f_60;
			case(62): return GFX.f_61;
			case(63): return GFX.f_62;
			case(64): return GFX.f_63;
			case(65): return GFX.f_64;
			case(66): return GFX.f_65;
			case(67): return GFX.f_66;
			case(68): return GFX.f_67;
			case(69): return GFX.f_68;


			case(70): return null;
			case(71): return TWall.g_00;
			case(72): return TWall.g_01;
			case(73): return TWall.g_02;
			case(74): return TWall.g_03;
			case(75): return TWall.g_04;
			case(76): return TWall.g_05;
			case(77): return TWall.g_06;
			case(78): return TWall.g_07;
			case(79): return TWall.g_08;
			case(80): return TWall.g_09;
			case(81): return TWall.g_10;
			case(82): return TWall.g_11;
			case(83): return TWall.g_12;
			case(84): return TWall.g_13;
			case(85): return TWall.g_14;
			case(86): return TWall.g_15;
			case(87): return TWall.g_16;
			case(88): return TWall.g_17;
			case(89): return TWall.g_18;
			case(90): return TWall.g_19;
			case(91): return TWall.g_20;
			case(92): return TWall.g_21;
			case(93): return TWall.g_22;
			case(94): return TWall.g_23;
			case(95): return TWall.g_24;
			case(96): return TWall.g_25;
			case(97): return TWall.g_26;
			case(98): return TWall.g_27;
			case(99): return TWall.g_28;
			case(100): return TWall.g_29;
			case(101): return TWall.g_30;
			case(102): return TWall.g_31;
			case(103): return TWall.g_32;
			case(104): return TWall.g_33;
			case(105): return TWall.g_34;
			case(106): return TWall.g_35;
			case(107): return TWall.g_36;
			case(108): return TWall.g_37;
			case(109): return TWall.g_38;
			case(110): return TWall.g_39;
			case(111): return TWall.g_40;
			case(112): return TWall.g_41;
			case(113): return TWall.g_42;
			case(114): return TWall.g_43;
			case(115): return TWall.g_44;
			case(116): return TWall.g_45;
			case(117): return TWall.g_46;
			case(118): return TWall.g_47;
			case(119): return TWall.g_48;
			case(120): return TWall.g_49;
			case(121): return TWall.g_50;
			case(122): return TWall.g_51;
			case(123): return TWall.g_52;
			case(124): return TWall.g_53;
			case(125): return TWall.g_54;
			case(126): return TWall.g_55;
			case(127): return TWall.g_56;
			case(128): return TWall.g_57;
			case(129): return TWall.g_58;
			case(130): return TWall.g_59;
			case(131): return TWall.g_60;
			case(132): return TWall.g_61;
			case(133): return TWall.g_62;
			case(134): return TWall.g_63;
			case(135): return TWall.g_64;
			case(136): return TWall.g_65;
			case(137): return TWall.g_66;
			case(138): return TWall.g_67;
			case(139): return TWall.g_68;

			case(140): return TBonus.g_00;
			case(141): return TBonus.g_01;
			case(142): return TBonus.g_02;
			case(143): return TBonus.g_03;
			case(144): return TBonus.g_04;
			case(145): return TBonus.g_05;
			case(146): return TBonus.g_06;
			case(147): return TBonus.g_07;
			case(148): return TBonus.g_08;
			case(149): return TBonus.g_09;
			case(150): return TBonus.g_10;
			case(151): return TBonus.g_11;
			case(152): return TBonus.g_12;
			case(153): return TBonus.g_13;
			case(154): return TBonus.g_14;
			case(155): return TBonus.g_15;
			case(156): return TBonus.g_16;
			case(157): return TBonus.g_17;
			case(158): return TBonus.g_18;
			case(159): return TBonus.g_19;

			case(160): return TExit.g_00;
			case(161): return TStopper.g_0;
			case(162): return TBouncerH.g_0;
			case(163): return TBouncerH.g_1;
			case(164): return TBouncerV.g_0;
			case(165): return TBouncerV.g_1;
			case(166): return TBouncerD.g_0;
			case(167): return TBouncerD.g_1;
			case(168): return TCannon.g_0;
			case(169): return TCannon.g_1;
			case(170): return TCannon.g_2;
			case(171): return TCannon.g_3;
			case(172): return TMine.g0;
			case(173): return TTeleport.g_0;
			case(174): return TButtonShot.g_0;
			case(175): return TButtonShot.g_0;
			case(176): return TArrow.g0;
			case(177): return TArrow.g1;
			case(178): return TArrow.g2;
			case(179): return TArrow.g3;
			case(180): return TArrow.g4;
			case(181): return TArrow.g5;
			case(182): return TArrow.g6;
			case(183): return TArrow.g7;
			case(184): return TArrow.g8;
			case(185): return TArrow.g9;
			case(186): return GFX.sp;
			case(187): return TWallPierced.g_00;
			case(188): return TWallPierced.g_01;
			case(189): return TWallPierced.g_02;
			case(190): return TRounder.gcw;
			case(191): return TRounder.gccw;
			case(192): return TDropper.g_0;

			case(200): return null;
			case(201): return TCrate.g_0;
			case(202): return TCrateSteel.g_0;
			case(203): return TIceCrate.g_0;
			case(204): return TIceCrateSteel.g_0;
			case(205): return TWaller.g_0;
			case(206): return GFX.sp;
			case(207): return TEnOrtho.g_1;
			case(208): return TEnOrtho.g_2;
			case(209): return TEnOrtho.g_3;
			case(210): return TEnOrtho.g_4;
			case(211): return TEnTurner.g_2;
			case(212): return TEnTurner.g_3;
			case(213): return TEnTurner.g_4;
			case(214): return TEnTurner.g_5;
			case(215): return TEnTurner.g_6;
			case(216): return TEnTurner.g_7;
			case(217): return TEnTurner.g_8;
			case(218): return TEnTurner.g_9;
			case(219): return TEnWaller.g_a;
			case(220): return TEnWaller.g_b;
			case(221): return TEnWaller.g_c;
			case(222): return TEnWaller.g_d;
			case(223): return TEnWaller.g_e;
			case(224): return TEnWaller.g_f;
			case(225): return TEnWaller.g_g;
			case(226): return TEnWaller.g_h;
			case(227): return TEnMimic.g_0;


			case(500): return GFX.bg0;
			case(501): return GFX.bg1;
			case(502): return GFX.bg2;
			case(503): return GFX.bg3;
			case(504): return GFX.bg4;
			case(505): return GFX.bg5;
			case(506): return GFX.bg6;
			case(507): return GFX.bg7;
			case(508): return GFX.bg8;
		}
		return null;
	}
}