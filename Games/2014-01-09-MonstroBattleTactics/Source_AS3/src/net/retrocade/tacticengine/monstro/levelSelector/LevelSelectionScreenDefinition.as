package net.retrocade.tacticengine.monstro.levelSelector {
	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;

	public class LevelSelectionScreenDefinition {
		public var backgroundId:uint;
		public var islands:Vector.<LevelSelectionIslandDefinition>;

		public function LevelSelectionScreenDefinition(backgroundId:uint, island:Vector.<LevelSelectionIslandDefinition>) {
			this.backgroundId = backgroundId;
			this.islands = island;
		}

		public static function generate(campaignType:EnumCampaignType):Vector.<LevelSelectionScreenDefinition>{
			switch(campaignType){
				case(EnumCampaignType.INTRODUCTION):
					return new <LevelSelectionScreenDefinition>[
						new LevelSelectionScreenDefinition(0, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(59, 352, 0, 5),
							new LevelSelectionIslandDefinition(323, 484, 1, 3),
							new LevelSelectionIslandDefinition(554, 270, 2, 6),
							new LevelSelectionIslandDefinition(792, 352, 3, 10)
						]),
						new LevelSelectionScreenDefinition(1, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(36, 279, 4, 4),
							new LevelSelectionIslandDefinition(363, 319, 5, 12),
							new LevelSelectionIslandDefinition(552, 468, 6, 13),
							new LevelSelectionIslandDefinition(783, 455, 7, 17)
						])
					];

				case(EnumCampaignType.HUMAN):
					return new <LevelSelectionScreenDefinition>[
						new LevelSelectionScreenDefinition(2, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(58, 253, 0, 0),
							new LevelSelectionIslandDefinition(248, 524, 1, 6),
							new LevelSelectionIslandDefinition(451, 374, 2, 14),
							new LevelSelectionIslandDefinition(702, 238, 3, 12),
							new LevelSelectionIslandDefinition(826, 487, 4, 8)
						]),
						new LevelSelectionScreenDefinition(3, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(65, 483, 5, 7),
							new LevelSelectionIslandDefinition(266, 465, 6, 2),
							new LevelSelectionIslandDefinition(455, 307, 7, 10),
							new LevelSelectionIslandDefinition(738, 307, 8, 5),
							new LevelSelectionIslandDefinition(908, 483, 9, 7)
						]),
						new LevelSelectionScreenDefinition(4, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(53, 299, 10, 17),
							new LevelSelectionIslandDefinition(271, 486, 11, 16),
							new LevelSelectionIslandDefinition(501, 288, 12, 1),
							new LevelSelectionIslandDefinition(629, 481, 13, 3),
							new LevelSelectionIslandDefinition(792, 281, 14, 4)
						]),
						new LevelSelectionScreenDefinition(5, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(87, 266, 15, 0),
							new LevelSelectionIslandDefinition(56, 501, 16, 8),
							new LevelSelectionIslandDefinition(333, 285, 17, 11),
							new LevelSelectionIslandDefinition(353, 493, 18, 16),
							new LevelSelectionIslandDefinition(744, 353, 19, 17)
						])
					];
				case(EnumCampaignType.HUMAN_HARD):
					return new <LevelSelectionScreenDefinition>[
						new LevelSelectionScreenDefinition(6, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(57, 245, 0, 6),
							new LevelSelectionIslandDefinition(224, 295, 1, 15),
							new LevelSelectionIslandDefinition(455, 367, 2, 9),
							new LevelSelectionIslandDefinition(672, 420, 3, 12),
							new LevelSelectionIslandDefinition(797, 480, 4, 4)
						]),
						new LevelSelectionScreenDefinition(7, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(55, 470, 5, 17),
							new LevelSelectionIslandDefinition(239, 255, 6, 2),
							new LevelSelectionIslandDefinition(519, 256, 7, 2),
							new LevelSelectionIslandDefinition(683, 521, 8, 13),
							new LevelSelectionIslandDefinition(808, 264, 9, 11)
						]),
						new LevelSelectionScreenDefinition(8, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(63, 295, 10, 7),
							new LevelSelectionIslandDefinition(243, 283, 11, 10),
							new LevelSelectionIslandDefinition(389, 507, 12, 0),
							new LevelSelectionIslandDefinition(614, 476, 13, 4),
							new LevelSelectionIslandDefinition(819, 286, 14, 14)
						]),
						new LevelSelectionScreenDefinition(9, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(54, 284, 15, 1),
							new LevelSelectionIslandDefinition(116, 467, 16, 10),
							new LevelSelectionIslandDefinition(396, 469, 17, 16),
							new LevelSelectionIslandDefinition(624, 285, 18, 3),
							new LevelSelectionIslandDefinition(791, 471, 19, 17)
						])
					];
				case(EnumCampaignType.MONSTER):
					return new <LevelSelectionScreenDefinition>[
						new LevelSelectionScreenDefinition(10, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(44, 359, 0, 6),
							new LevelSelectionIslandDefinition(224, 343, 1, 15),
							new LevelSelectionIslandDefinition(466, 357, 2, 7),
							new LevelSelectionIslandDefinition(643, 360, 3, 0),
							new LevelSelectionIslandDefinition(823, 345, 4, 9)
						]),
						new LevelSelectionScreenDefinition(11, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(41, 474, 5, 11),
							new LevelSelectionIslandDefinition(313, 380, 6, 12),
							new LevelSelectionIslandDefinition(498, 326, 7, 13),
							new LevelSelectionIslandDefinition(644, 262, 8, 4),
							new LevelSelectionIslandDefinition(812, 474, 9, 14)
						]),
						new LevelSelectionScreenDefinition(12, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(52, 262, 10, 8),
							new LevelSelectionIslandDefinition(219, 480, 11, 17),
							new LevelSelectionIslandDefinition(445, 271, 12, 10),
							new LevelSelectionIslandDefinition(643, 480, 13, 16),
							new LevelSelectionIslandDefinition(871, 279, 14, 12)
						]),
						new LevelSelectionScreenDefinition(13, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(52, 260, 15, 3),
							new LevelSelectionIslandDefinition(175, 478, 16, 5),
							new LevelSelectionIslandDefinition(421, 299, 17, 10),
							new LevelSelectionIslandDefinition(650, 479, 18, 3),
							new LevelSelectionIslandDefinition(810, 277, 19, 4)
						])
					];
				case(EnumCampaignType.MONSTER_HARD):
					return new <LevelSelectionScreenDefinition>[
						new LevelSelectionScreenDefinition(14, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(54, 530, 0, 12),
							new LevelSelectionIslandDefinition(151, 264, 1, 15),
							new LevelSelectionIslandDefinition(417, 345, 2, 8),
							new LevelSelectionIslandDefinition(660, 294, 3, 17),
							new LevelSelectionIslandDefinition(905, 530, 4, 6)
						]),
						new LevelSelectionScreenDefinition(15, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(62, 382, 5, 14),
							new LevelSelectionIslandDefinition(308, 527, 6, 1),
							new LevelSelectionIslandDefinition(424, 271, 7, 4),
							new LevelSelectionIslandDefinition(714, 273, 8, 3),
							new LevelSelectionIslandDefinition(828, 491, 9, 2)
						]),
						new LevelSelectionScreenDefinition(16, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(61, 491, 10, 8),
							new LevelSelectionIslandDefinition(255, 341, 11, 11),
							new LevelSelectionIslandDefinition(549, 357, 12, 9),
							new LevelSelectionIslandDefinition(791, 251, 13, 3),
							new LevelSelectionIslandDefinition(791, 487, 14, 15)
						]),
						new LevelSelectionScreenDefinition(17, new <LevelSelectionIslandDefinition>[
							new LevelSelectionIslandDefinition(48, 320, 15, 10),
							new LevelSelectionIslandDefinition(243, 504, 16, 14),
							new LevelSelectionIslandDefinition(424, 320, 17, 5),
							new LevelSelectionIslandDefinition(656, 523, 18, 1),
							new LevelSelectionIslandDefinition(799, 320, 19, 11)
						])
					];
			}

			throw new Error("Invalid campaign");
		}
	}
}
