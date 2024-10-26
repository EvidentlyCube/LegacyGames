package objects
{
	import flash.media.Sound;
	import mx.core.BitmapAsset;

	public function MakeLevel(id:uint):void
	{
		switch (id)
		{
			case 0:
				Mario.levelGenre = 0;
				Mario.musika = 0;
				Mario.generateBackground(0);
				Mario.level[0] = "                                                                                                                                                                                           ";
				Mario.level[1] = "                                                                                                                                                                                           ";
				Mario.level[2] = "                                                                                                                                                                                           ";
				Mario.level[3] = "                                                                                                                                                                                           ";
				Mario.level[4] = "                                                                                                                                                                                           ";
				Mario.level[5] = "                                                                                                                                                                                           ";
				Mario.level[6] = "                                                                                                                                                                                           ";
				Mario.level[7] = "                                                                                                                                                                                           ";
				Mario.level[8] = "                                                                                                                                                                                           ";
				Mario.level[9] = "                                                                                                                                               MM                                          ";
				Mario.level[10] = "                                01     01                                                       M  cdddddddde  M                              MMM                                          ";
				Mario.level[11] = "                     01         23     23                                                      MM  fggggggggh  MM          01                MMMM                                          ";
				Mario.level[12] = "                     23         23     23                                                     MMM  MMMMMMMMMM  MMM         23               MMMMM                                          ";
				Mario.level[13] = "                     23         23     23                                                    MMMM              MMMM        23              MMMMMM                                          ";
				Mario.level[14] = "cddddddddddddddddddddddddddddddddddddddddddddddde   cdddddddddde      cddddddddddddddddddddddddde              cdddddddddddddddddddddde  cdddddddddddddddddddddddddddddddddddddddddddddddde";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Player.ResetPlayer(75, 325);

				Mario.instEffects.push(new Background(325, 175, 'back_clouds_8', 0.57));
				Mario.instEffects.push(new Background(-300, 125, 'back_clouds_7', 0.5));
				Mario.instEffects.push(new Background(1700, 100, 'back_clouds_3', 0.43));
				Mario.instEffects.push(new Background(2425, 225, 'back_clouds_4', 0.5));
				Mario.instEffects.push(new Background(3500, 100, 'back_clouds_1', 0.4));
				Mario.instEffects.push(new Background(3475, 100, 'back_hill_big', 0.9));
				Mario.instEffects.push(new Background(1500, 175, 'back_hill_big', 0.75));
				Mario.instEffects.push(new Background(100, 300, 'back_hill', 0.2));
				Mario.instEffects.push(new Background(1000, 300, 'back_hill', 0.1));
				Mario.instEffects.push(new Background(1875, 325, 'back_hill', 0.05));
				Mario.instEffects.push(new Cloud(325, 150));

				Mario.instEffects.push(new Cloud(1000, 150));

				Mario.instEffects.push(new Cloud(1475, 50));

				Mario.instEffects.push(new Cloud(4125, 50));

				Mario.instEffects.push(new Cloud(3875, 125));

				Mario.instEffects.push(new Cloud(3575, 50));

				Mario.instEffects.push(new Cloud(3150, 125));

				Mario.instEffects.push(new Cloud(2650, 125));

				Mario.instEffects.push(new Cloud(2825, 50));

				Mario.instEffects.push(new Cloud(2350, 150));

				Mario.instEffects.push(new Cloud(2275, 50));

				Mario.instEffects.push(new Cloud(1925, 150));

				Mario.instEffects.push(new Cloud(1100, 25));

				Mario.instEffects.push(new Cloud(500, 100));

				Mario.instEffects.push(new Cloud(100, 50));

				Mario.layerWall.addChild(AddGraphic(3625, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(3775, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(3750, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3725, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3700, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3675, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3650, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3275, 250, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(3275, 275, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(3275, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(3275, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(3050, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(3025, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3000, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(2950, 300, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(2950, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2200, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(2175, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2150, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2125, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2100, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2075, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2050, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1375, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1575, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(1550, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1525, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1500, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1475, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1450, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1425, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1400, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1375, 275, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1375, 250, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1375, 225, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(1375, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(1375, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(625, 300, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(625, 325, 'back_tree_1'));

				Mario.instObjects.push(new Coin(2950, 200));

				Mario.instObjects.push(new Coin(3225, 200));

				Mario.instObjects.push(new Coin(3525, 175));

				Mario.instObjects.push(new Coin(3475, 250));

				Mario.instObjects.push(new Coin(2600, 125));

				Mario.instObjects.push(new Coin(2575, 125));

				Mario.instObjects.push(new Coin(2625, 150));

				Mario.instObjects.push(new Coin(2550, 150));

				Mario.instObjects.push(new Coin(2575, 150));

				Mario.instObjects.push(new Coin(2600, 150));

				Mario.instObjects.push(new Coin(2150, 200));

				Mario.instObjects.push(new Coin(2075, 200));

				Mario.instObjects.push(new Coin(1725, 100));

				Mario.instObjects.push(new Coin(1600, 100));

				Mario.instObjects.push(new Coin(1750, 100));

				Mario.instObjects.push(new Coin(1775, 100));

				Mario.instObjects.push(new Coin(1575, 100));

				Mario.instObjects.push(new Coin(1550, 100));

				Mario.instObjects.push(new Coin(1475, 175));

				Mario.instObjects.push(new Coin(1675, 200));

				Mario.instObjects.push(new Coin(1650, 200));

				Mario.instObjects.push(new Coin(1725, 250));

				Mario.instObjects.push(new Coin(1700, 225));

				Mario.instObjects.push(new Coin(1625, 225));

				Mario.instObjects.push(new Coin(1600, 250));

				Mario.instObjects.push(new Coin(1850, 175));

				Mario.layerWall.addChild(AddGraphic(125, 275, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(125, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(125, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2250, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2250, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2250, 275, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(1925, 300, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(1925, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2450, 225, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(2725, 225, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(2700, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2675, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2650, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2625, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2600, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2575, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2550, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2525, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2500, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2475, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1000, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1175, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(1150, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1125, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1100, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1075, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1050, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1025, 325, 'back_fence_2'));

				Mario.instObjects.push(new Coin(125, 250));

				Mario.instObjects.push(new Coin(325, 250));

				Mario.instObjects.push(new Coin(225, 250));

				Mario.instBlocks.push(new Brick(150, 250));

				Mario.instBlocks.push(new Brick(175, 250));

				Mario.instBlocks.push(new Brick(275, 250));

				Mario.instBlocks.push(new Brick(300, 250));

				Mario.instBlocks.push(new Bonus(0, 225, 2, true));

				Mario.instBlocks.push(new Bonus(0, 100, 4, true));

				Mario.instBlocks.push(new Bonus(200, 150, 1));

				Mario.instBlocks.push(new Bonus(250, 150, 1));

				Mario.instBlocks.push(new Bonus(275, 150, 1));

				Mario.instBlocks.push(new Bonus(175, 150, 1));

				Mario.instBlocks.push(new Bonus(200, 250, 1));

				Mario.instBlocks.push(new Bonus(200, 50, 1, true));

				Mario.instBlocks.push(new Bonus(175, 50, 1, true));

				Mario.instBlocks.push(new Bonus(250, 50, 1, true));

				Mario.instBlocks.push(new Bonus(275, 50, 1, true));

				Mario.instBlocks.push(new Brick(1500, 250));

				Mario.instBlocks.push(new Brick(1475, 250));

				Mario.instBlocks.push(new Brick(1450, 250));

				Mario.instBlocks.push(new Brick(1850, 250));

				Mario.instBlocks.push(new Brick(1875, 250));

				Mario.instBlocks.push(new Brick(1525, 150));

				Mario.instBlocks.push(new Brick(1550, 150));

				Mario.instBlocks.push(new Brick(1575, 150));

				Mario.instBlocks.push(new Brick(1600, 150));

				Mario.instBlocks.push(new Brick(1625, 150));

				Mario.instBlocks.push(new Brick(1650, 150));

				Mario.instBlocks.push(new Brick(1675, 150));

				Mario.instBlocks.push(new Brick(1700, 150));

				Mario.instBlocks.push(new Brick(1725, 150));

				Mario.instBlocks.push(new Brick(1750, 150));

				Mario.instBlocks.push(new Brick(1775, 150));

				Mario.instBlocks.push(new Brick(1800, 150));

				Mario.instBlocks.push(new Bonus(2025, 250, 1));

				Mario.instBlocks.push(new Bonus(2050, 250, 1));

				Mario.instBlocks.push(new Bonus(2100, 250, 1));

				Mario.instBlocks.push(new Bonus(2125, 250, 1));

				Mario.instBlocks.push(new Brick(2075, 250));

				Mario.instBlocks.push(new Brick(2150, 250));

				Mario.instBlocks.push(new Bonus(2175, 250, 1));

				Mario.instBlocks.push(new Brick(2000, 250));

				Mario.instBlocks.push(new Brick(2225, 250));

				Mario.instBlocks.push(new Bonus(2200, 250, 2));

				Mario.instBlocks.push(new Bonus(250, 250, 2));

				Mario.instBlocks.push(new BrickMulti(1825, 250));

				Mario.instBlocks.push(new Brick(3225, 250));

				Mario.instBlocks.push(new Brick(3250, 250));

				Mario.instBlocks.push(new Bonus(2075, 125, 1, true));

				Mario.instBlocks.push(new Bonus(2150, 125, 1, true));

				Mario.instBlocks.push(new BrickMulti(3200, 250));

				Mario.instBlocks.push(new Brick(2975, 250));

				Mario.instBlocks.push(new Brick(2950, 250));

				Mario.instBlocks.push(new Brick(2925, 250));

				Mario.instObjects.push(new Finish(3775, 325));

				Mario.instEnemies.push(new Goomba(400, 325));

				Mario.instEnemies.push(new Goomba(625, 325));

				Mario.instEnemies.push(new Goomba(1700, 125));

				Mario.instEnemies.push(new Goomba(1625, 125));

				Mario.instEnemies.push(new TroopaGreen(1950, 325));

				Mario.instEnemies.push(new Goomba(2050, 325));

				Mario.instEnemies.push(new Goomba(2150, 325));

				Mario.instEnemies.push(new Goomba(2275, 325));

				Mario.instEnemies.push(new Goomba(3325, 325));

				break;
			case 1:
				Mario.generateBackground(1);

				Mario.levelGenre = 1;

				Mario.musika = 1;

				Mario.level[0] = "N                                                                                                                                                                               23                             NNNNNNNNNNNNNNNN";
				Mario.level[1] = "N                                                                                                                                                                               23                             N 23   NN   23 N";
				Mario.level[2] = "N                                                                                                                                                                               23                             N 45   45   23 N";
				Mario.level[3] = "N                                                                                                                                                                               23                             N           45 N";
				Mario.level[4] = "N                                                                                                                                                                               23                             N              N";
				Mario.level[5] = "N                                                                                                                                                                               23                             N8             N";
				Mario.level[6] = "N                                                                                                                                                                               23                             Nb             N";
				Mario.level[7] = "N                                                       NNNN                                                                                                                    23                             N            67N";
				Mario.level[8] = "N                                                       NNNN                                                                                    6777NN                          23                             N            9aN";
				Mario.level[9] = "N                                                                                                                                               9aaaNN                          23                             N78            N";
				Mario.level[10] = "N                                                                                   01                           qrrrrrs      qrrrrrs   qrrrrrrrrrrrrs                          23                             Nab    01      N";
				Mario.level[11] = "N                      NN    NN                                              01     23                      NN   tuuuuuv      tuuuuuv   tuuuuuuuuuuuuv                          NN                             N      23      N";
				Mario.level[12] = "N                  01  NN    NN  01                                          23     23       01            NNN   NNNNNNN      NNNNNNN   tuuuuuuuuuuuuv                          NN                             N      23      N";
				Mario.level[13] = "N                  23  NN    NN  23                                          23     23     N 23 N         NNNN                          tuuuuuuuuuuuuvqrrrrrrrrrrrrrrrrrrrrrrrrs23                             N      NN   01 N";
				Mario.level[14] = "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrs    qrrrrrrrrrrrrrrrrrrrrrrrrrrs 23 qrrrrrrrrrrrrs                          tuuuuuuuuuuuuvtuuuuuuuuuuuuuuuuuuuuuuuuv23                             NNNNNNNNNNNNNNNN";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Player.ResetPlayer(75, 25);

				Mario.instObjects.push(new Coin(5275, 150));

				Mario.instObjects.push(new Coin(5275, 175));

				Mario.instObjects.push(new Coin(5275, 125));

				Mario.instObjects.push(new Coin(5450, 150));

				Mario.instObjects.push(new Coin(5450, 175));

				Mario.instObjects.push(new Coin(5450, 125));

				Mario.instObjects.push(new Coin(5425, 200));

				Mario.instObjects.push(new Coin(5400, 200));

				Mario.instObjects.push(new Coin(5375, 200));

				Mario.instObjects.push(new Coin(5350, 200));

				Mario.instObjects.push(new Coin(5325, 200));

				Mario.instObjects.push(new Coin(5300, 200));

				Mario.instObjects.push(new Coin(5300, 175));

				Mario.instObjects.push(new Coin(5300, 150));

				Mario.instObjects.push(new Coin(5300, 125));

				Mario.instObjects.push(new Coin(5300, 100));

				Mario.instObjects.push(new Coin(5425, 175));

				Mario.instObjects.push(new Coin(5425, 150));

				Mario.instObjects.push(new Coin(5425, 125));

				Mario.instObjects.push(new Coin(5425, 100));

				Mario.instObjects.push(new Coin(5375, 175));

				Mario.instObjects.push(new Coin(5400, 175));

				Mario.instObjects.push(new Coin(5400, 100));

				Mario.instObjects.push(new Coin(5375, 125));

				Mario.instObjects.push(new Coin(5350, 125));

				Mario.instObjects.push(new Coin(5350, 100));

				Mario.instObjects.push(new Coin(5375, 100));

				Mario.instObjects.push(new Coin(5400, 125));

				Mario.instObjects.push(new Coin(5400, 150));

				Mario.instObjects.push(new Coin(5375, 150));

				Mario.instObjects.push(new Coin(5350, 150));

				Mario.instObjects.push(new Coin(5350, 175));

				Mario.instObjects.push(new Coin(5325, 175));

				Mario.instObjects.push(new Coin(5325, 150));

				Mario.instObjects.push(new Coin(5325, 125));

				Mario.instObjects.push(new Coin(5325, 100));

				Mario.instObjects.push(new Coin(725, 200));

				Mario.instObjects.push(new Coin(600, 200));

				Mario.instObjects.push(new Coin(400, 200));

				Mario.instObjects.push(new Coin(350, 200));

				Mario.instObjects.push(new Coin(325, 200));

				Mario.instObjects.push(new Coin(275, 200));

				Mario.instObjects.push(new Coin(1050, 125));

				Mario.instObjects.push(new Coin(1150, 125));

				Mario.instObjects.push(new Coin(1150, 100));

				Mario.instObjects.push(new Coin(1050, 100));

				Mario.instObjects.push(new Coin(1450, 125));

				Mario.instObjects.push(new Coin(1425, 125));

				Mario.instObjects.push(new Coin(2575, 250));

				Mario.instObjects.push(new Coin(2575, 225));

				Mario.instObjects.push(new Coin(2500, 250));

				Mario.instObjects.push(new Coin(2500, 225));

				Mario.instObjects.push(new Coin(2200, 250));

				Mario.instObjects.push(new Coin(2200, 225));

				Mario.instObjects.push(new Coin(2050, 250));

				Mario.instObjects.push(new Coin(2000, 250));

				Mario.instObjects.push(new Coin(1750, 175));

				Mario.instObjects.push(new Coin(1750, 150));

				Mario.instObjects.push(new Coin(1725, 150));

				Mario.instObjects.push(new Coin(1725, 175));

				Mario.instObjects.push(new Coin(3225, 175));

				Mario.instObjects.push(new Coin(3225, 150));

				Mario.instObjects.push(new Coin(2900, 150));

				Mario.instObjects.push(new Coin(2900, 175));

				Mario.instObjects.push(new Coin(1100, 75));

				Mario.instObjects.push(new Coin(1100, 100));

				Mario.instObjects.push(new Coin(1100, 125));

				Mario.instObjects.push(new Coin(1175, 150));

				Mario.instObjects.push(new Coin(1150, 150));

				Mario.instObjects.push(new Coin(1150, 175));

				Mario.instObjects.push(new Coin(1175, 175));

				Mario.instObjects.push(new Coin(1050, 150));

				Mario.instObjects.push(new Coin(1025, 150));

				Mario.instObjects.push(new Coin(1025, 175));

				Mario.instObjects.push(new Coin(1050, 175));

				Mario.instBlocks.push(new Brick(200, 0));

				Mario.instBlocks.push(new Brick(225, 0));

				Mario.instBlocks.push(new Brick(250, 0));

				Mario.instBlocks.push(new Brick(275, 0));

				Mario.instBlocks.push(new Brick(300, 0));

				Mario.instBlocks.push(new Brick(325, 0));

				Mario.instBlocks.push(new Brick(350, 0));

				Mario.instBlocks.push(new Brick(375, 0));

				Mario.instBlocks.push(new Brick(400, 0));

				Mario.instBlocks.push(new Brick(425, 0));

				Mario.instBlocks.push(new Brick(450, 0));

				Mario.instBlocks.push(new Brick(475, 0));

				Mario.instBlocks.push(new Brick(500, 0));

				Mario.instBlocks.push(new Brick(525, 0));

				Mario.instBlocks.push(new Brick(550, 0));

				Mario.instBlocks.push(new Brick(575, 0));

				Mario.instBlocks.push(new Brick(600, 0));

				Mario.instBlocks.push(new Brick(625, 0));

				Mario.instBlocks.push(new Brick(650, 0));

				Mario.instBlocks.push(new Brick(675, 0));

				Mario.instBlocks.push(new Brick(700, 0));

				Mario.instBlocks.push(new Brick(725, 0));

				Mario.instBlocks.push(new Brick(750, 0));

				Mario.instBlocks.push(new Brick(775, 0));

				Mario.instBlocks.push(new Brick(800, 0));

				Mario.instBlocks.push(new Brick(825, 0));

				Mario.instBlocks.push(new Brick(850, 0));

				Mario.instBlocks.push(new Brick(875, 0));

				Mario.instBlocks.push(new Brick(900, 0));

				Mario.instBlocks.push(new Brick(925, 0));

				Mario.instBlocks.push(new Brick(950, 0));

				Mario.instBlocks.push(new Brick(975, 0));

				Mario.instBlocks.push(new Brick(1000, 0));

				Mario.instBlocks.push(new Brick(1025, 0));

				Mario.instBlocks.push(new Brick(1050, 0));

				Mario.instBlocks.push(new Brick(1075, 0));

				Mario.instBlocks.push(new Brick(1100, 0));

				Mario.instBlocks.push(new Brick(1125, 0));

				Mario.instBlocks.push(new Brick(1150, 0));

				Mario.instBlocks.push(new Brick(1175, 0));

				Mario.instBlocks.push(new Brick(1200, 0));

				Mario.instBlocks.push(new Brick(1225, 0));

				Mario.instBlocks.push(new Brick(1250, 0));

				Mario.instBlocks.push(new Brick(1275, 0));

				Mario.instBlocks.push(new Brick(1300, 0));

				Mario.instBlocks.push(new Brick(1325, 0));

				Mario.instBlocks.push(new Brick(1350, 0));

				Mario.instBlocks.push(new Brick(1375, 0));

				Mario.instBlocks.push(new Brick(1400, 0));

				Mario.instBlocks.push(new Brick(1425, 0));

				Mario.instBlocks.push(new Brick(1450, 0));

				Mario.instBlocks.push(new Brick(1475, 0));

				Mario.instBlocks.push(new Brick(1500, 0));

				Mario.instBlocks.push(new Brick(1525, 0));

				Mario.instBlocks.push(new Brick(1550, 0));

				Mario.instBlocks.push(new Brick(1575, 0));

				Mario.instBlocks.push(new Brick(1600, 0));

				Mario.instBlocks.push(new Brick(1625, 0));

				Mario.instBlocks.push(new Brick(1650, 0));

				Mario.instBlocks.push(new Brick(1675, 0));

				Mario.instBlocks.push(new Brick(1700, 0));

				Mario.instBlocks.push(new Brick(1725, 0));

				Mario.instBlocks.push(new Brick(1750, 0));

				Mario.instBlocks.push(new Brick(1775, 0));

				Mario.instBlocks.push(new Brick(1800, 0));

				Mario.instBlocks.push(new Brick(1825, 0));

				Mario.instBlocks.push(new Brick(1850, 0));

				Mario.instBlocks.push(new Brick(1875, 0));

				Mario.instBlocks.push(new Brick(1900, 0));

				Mario.instBlocks.push(new Brick(1925, 0));

				Mario.instBlocks.push(new Brick(1950, 0));

				Mario.instBlocks.push(new Brick(1975, 0));

				Mario.instBlocks.push(new Brick(2000, 0));

				Mario.instBlocks.push(new Brick(2025, 0));

				Mario.instBlocks.push(new Brick(2050, 0));

				Mario.instBlocks.push(new Brick(2075, 0));

				Mario.instBlocks.push(new Brick(2100, 0));

				Mario.instBlocks.push(new Brick(2125, 0));

				Mario.instBlocks.push(new Brick(2150, 0));

				Mario.instBlocks.push(new Brick(2175, 0));

				Mario.instBlocks.push(new Brick(2200, 0));

				Mario.instBlocks.push(new Brick(2225, 0));

				Mario.instBlocks.push(new Brick(2250, 0));

				Mario.instBlocks.push(new Brick(2275, 0));

				Mario.instBlocks.push(new Brick(2300, 0));

				Mario.instBlocks.push(new Brick(2325, 0));

				Mario.instBlocks.push(new Brick(2350, 0));

				Mario.instBlocks.push(new Brick(2375, 0));

				Mario.instBlocks.push(new Brick(2400, 0));

				Mario.instBlocks.push(new Brick(2425, 0));

				Mario.instBlocks.push(new Brick(2450, 0));

				Mario.instBlocks.push(new Brick(2475, 0));

				Mario.instBlocks.push(new Brick(2500, 0));

				Mario.instBlocks.push(new Brick(2525, 0));

				Mario.instBlocks.push(new Brick(2550, 0));

				Mario.instBlocks.push(new Brick(2575, 0));

				Mario.instBlocks.push(new Brick(2600, 0));

				Mario.instBlocks.push(new Brick(2625, 0));

				Mario.instBlocks.push(new Brick(2650, 0));

				Mario.instBlocks.push(new Brick(2675, 0));

				Mario.instBlocks.push(new Brick(2700, 0));

				Mario.instBlocks.push(new Brick(2725, 0));

				Mario.instBlocks.push(new Brick(2750, 0));

				Mario.instBlocks.push(new Brick(2775, 0));

				Mario.instBlocks.push(new Brick(2800, 0));

				Mario.instBlocks.push(new Brick(2825, 0));

				Mario.instBlocks.push(new Brick(2850, 0));

				Mario.instBlocks.push(new Brick(2875, 0));

				Mario.instBlocks.push(new Brick(2900, 0));

				Mario.instBlocks.push(new Brick(2925, 0));

				Mario.instBlocks.push(new Brick(2950, 0));

				Mario.instBlocks.push(new Brick(2975, 0));

				Mario.instBlocks.push(new Brick(3150, 0));

				Mario.instBlocks.push(new Brick(3175, 0));

				Mario.instBlocks.push(new Brick(3200, 0));

				Mario.instBlocks.push(new Brick(3225, 0));

				Mario.instBlocks.push(new Brick(3250, 0));

				Mario.instBlocks.push(new Brick(3275, 0));

				Mario.instBlocks.push(new Brick(3300, 0));

				Mario.instBlocks.push(new Brick(3325, 0));

				Mario.instBlocks.push(new Brick(3350, 0));

				Mario.instBlocks.push(new Brick(3375, 0));

				Mario.instBlocks.push(new Brick(3400, 0));

				Mario.instBlocks.push(new Brick(3425, 0));

				Mario.instBlocks.push(new Brick(3450, 0));

				Mario.instBlocks.push(new Brick(3475, 0));

				Mario.instBlocks.push(new Brick(3500, 0));

				Mario.instBlocks.push(new Brick(3525, 0));

				Mario.instBlocks.push(new Brick(3550, 0));

				Mario.instBlocks.push(new Brick(3575, 0));

				Mario.instBlocks.push(new Brick(3600, 0));

				Mario.instBlocks.push(new Brick(3625, 0));

				Mario.instBlocks.push(new Brick(3650, 0));

				Mario.instBlocks.push(new Brick(3675, 0));

				Mario.instBlocks.push(new Brick(1000, 50));

				Mario.instBlocks.push(new Brick(1000, 75));

				Mario.instBlocks.push(new Brick(1000, 100));

				Mario.instBlocks.push(new Brick(1000, 125));

				Mario.instBlocks.push(new Brick(1000, 150));

				Mario.instBlocks.push(new Brick(1000, 175));

				Mario.instBlocks.push(new Brick(1000, 200));

				Mario.instBlocks.push(new Brick(1000, 225));

				Mario.instBlocks.push(new Brick(1025, 225));

				Mario.instBlocks.push(new Brick(1050, 225));

				Mario.instBlocks.push(new Brick(1075, 225));

				Mario.instBlocks.push(new Brick(1100, 225));

				Mario.instBlocks.push(new Brick(1125, 225));

				Mario.instBlocks.push(new Brick(1150, 225));

				Mario.instBlocks.push(new Brick(1175, 225));

				Mario.instBlocks.push(new Brick(1200, 225));

				Mario.instBlocks.push(new Brick(1200, 200));

				Mario.instBlocks.push(new Brick(1200, 175));

				Mario.instBlocks.push(new Brick(1200, 125));

				Mario.instBlocks.push(new Brick(1200, 100));

				Mario.instBlocks.push(new Brick(1200, 75));

				Mario.instBlocks.push(new Brick(1075, 150));

				Mario.instBlocks.push(new Brick(1100, 150));

				Mario.instBlocks.push(new Brick(1125, 150));

				Mario.instBlocks.push(new Brick(1075, 125));

				Mario.instBlocks.push(new Brick(1075, 100));

				Mario.instBlocks.push(new Brick(1125, 125));

				Mario.instBlocks.push(new Brick(1125, 100));

				Mario.instBlocks.push(new Brick(1075, 75));

				Mario.instBlocks.push(new Brick(1200, 50));

				Mario.instBlocks.push(new BrickMulti(1075, 0));

				Mario.instBlocks.push(new Brick(1300, 275));

				Mario.instBlocks.push(new Brick(1300, 250));

				Mario.instBlocks.push(new Brick(1325, 250));

				Mario.instBlocks.push(new Brick(1325, 275));

				Mario.instBlocks.push(new Brick(250, 250));

				Mario.instBlocks.push(new Brick(325, 250));

				Mario.instBlocks.push(new Brick(425, 250));

				Mario.instBlocks.push(new Bonus(275, 250, 1));

				Mario.instBlocks.push(new Bonus(300, 250, 1));

				Mario.instBlocks.push(new Bonus(400, 250, 1));

				Mario.instBlocks.push(new BrickMulti(650, 225));

				Mario.instBlocks.push(new BrickMulti(675, 225));

				Mario.instBlocks.push(new Bonus(375, 250, 2));

				Mario.instBlocks.push(new Bonus(1475, 100, 5, true));

				Mario.instBlocks.push(new Brick(1700, 225));

				Mario.instBlocks.push(new Bonus(1700, 200, 1));

				Mario.instBlocks.push(new Bonus(1725, 225, 1));

				Mario.instBlocks.push(new Bonus(1750, 225, 1));

				Mario.instBlocks.push(new Bonus(1775, 200, 1));

				Mario.instBlocks.push(new Brick(1775, 225));

				Mario.instObjects.push(new ElevatorLoop(3025, 50, 100, 'elevator_4', -2));

				Mario.instObjects.push(new ElevatorLoop(3025, 175, 100, 'elevator_4', -2));

				Mario.instObjects.push(new ElevatorLoop(3025, 300, 100, 'elevator_4', -2));

				Mario.instBlocks.push(new Brick(350, 250));

				Mario.instBlocks.push(new Bonus(300, 150, 1, true));

				Mario.instBlocks.push(new Bonus(375, 150, 1, true));

				Mario.instBlocks.push(new Bonus(300, 75, 1, true));

				Mario.instBlocks.push(new Bonus(375, 75, 1, true));

				Mario.instEnemies.push(new TroopaGreen(675, 325));

				Mario.instEnemies.push(new Goomba(425, 325));

				Mario.instEnemies.push(new Goomba(375, 325));

				Mario.instEnemies.push(new Goomba(325, 325));

				Mario.instEnemies.push(new Goomba(1200, 325));

				Mario.instEnemies.push(new Goomba(1400, 150));

				Mario.instEnemies.push(new Goomba(1300, 225));

				Mario.instEnemies.push(new TroopaGreen(1025, 325));

				Mario.instEnemies.push(new TroopaGreen(1000, 325));

				Mario.instEnemies.push(new Goomba(1850, 325));

				Mario.instEnemies.push(new PPlant(1925, 250));

				Mario.instEnemies.push(new PPlant(2100, 225));

				Mario.instEnemies.push(new PPlant(2325, 275));

				Mario.instEnemies.push(new Goomba(2700, 250));

				Mario.instEnemies.push(new TroopaRed(2900, 225));

				Mario.instEnemies.push(new Goomba(3250, 225));

				Mario.instBlocks.push(new Bonus(3675, 50, 4, true));

				Mario.instBlocks.push(new Bonus(3675, 100, 1, true));

				Mario.instBlocks.push(new Brick(3700, 0));

				Mario.instBlocks.push(new Brick(3725, 0));

				Mario.instBlocks.push(new Bonus(5200, 50, 1, true));

				Mario.instBlocks.push(new Bonus(5525, 75, 1, true));

				Mario.instBlocks.push(new Bonus(5400, 275, 1, true));

				Mario.instBlocks.push(new Bonus(5425, 275, 1, true));

				Mario.instBlocks.push(new Bonus(5325, 275, 1, true));

				Mario.instBlocks.push(new Bonus(5300, 275, 1, true));

				Mario.instBlocks.push(new Bonus(5200, 300, 2, true));

				Mario.instBlocks.push(new Brick(3725, 25));

				Mario.instBlocks.push(new Brick(3725, 50));

				Mario.instBlocks.push(new Brick(3700, 50));

				Mario.instBlocks.push(new Brick(3700, 75));

				Mario.instBlocks.push(new Brick(3700, 100));

				Mario.instBlocks.push(new Brick(3725, 100));

				Mario.instBlocks.push(new Brick(3725, 75));

				Mario.instBlocks.push(new Brick(3700, 25));

				Mario.instObjects.push(new Finish(3925, 300));

				Mario.instBlocks.push(new BrickMulti(1125, 75));

				Mario.instBlocks.push(new BrickMulti(1200, 150));

				Mario.instEffects.push(new Back(1));

				break;
			case (2):
				Mario.generateBackground(0);

				Mario.levelGenre = 0;

				Mario.musika = 0;

				Mario.level[0] = "                                                                                                                                                                                           ";
				Mario.level[1] = "                                                                                                                                                                                           ";
				Mario.level[2] = "                                                                                                                                                                                           ";
				Mario.level[3] = "                                                                                            ijlm                                                                                           ";
				Mario.level[4] = "                                             ijkkkkkkkkklm                                   np                                                                                            ";
				Mario.level[5] = "                          ijklm               nooooooooop                                    np                                                                                            ";
				Mario.level[6] = "                           nop                nooooooooop        ijkkkkkklm                  np                                             ijklm   ijlm                                   ";
				Mario.level[7] = "                           nop                nooooooooop         noooooop                   np                                              nop     np                                    ";
				Mario.level[8] = "                           nop     ijkkkklm   nooooooooop         noooooop                   np                                              nop     np                                    ";
				Mario.level[9] = "                           nop      noooop    nooooooooop         noooooop                   np     ijklm                   ijkkklm          nop     np                                    ";
				Mario.level[10] = "                        ijkkkklm    noooop    nooooooooop         noooooop                   np      nop                     nooop           nop     np                                    ";
				Mario.level[11] = "                         noooop     noooop    nooooooooop  ijklm  noooooop    ijkkkklm       np      nop                     nooop           nop     np                                    ";
				Mario.level[12] = "                         noooop     noooop    nooooooooop   nop   noooooop     noooop        np      nop                     nooop           nop     np                                    ";
				Mario.level[13] = "dddddddddddddddddddde    noooop     noooop    nooooooooop   nop   noooooop     noooop       ijklm    nop                     nooop          cddddddddddddddddddddddddddddddddddddddddddddMM";
				Mario.level[14] = "ggggggggggggggggggggh    noooop     noooop    nooooooooop   nop   noooooop     noooop        nop     nop                     nooop          fgggggggggggggggggggggggggggggggggggggggggggggM";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Player.ResetPlayer(25, 300);

				Mario.layerWall.addChild(AddGraphic(275, 300, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(525, 300, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(500, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(475, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(450, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(425, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(400, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(375, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(350, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(325, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(300, 300, 'back_fence_2'));

				Mario.instEffects.push(new Cloud(3450, 25));

				Mario.instEffects.push(new Cloud(2975, 225));

				Mario.instEffects.push(new Cloud(2600, 25));

				Mario.instEffects.push(new Cloud(1875, 50));

				Mario.instEffects.push(new Cloud(2125, 100));

				Mario.instEffects.push(new Cloud(1475, 25));

				Mario.instEffects.push(new Cloud(1075, 150));

				Mario.instEffects.push(new Cloud(25, 50));

				Mario.instEffects.push(new Cloud(575, 25));

				Mario.instEffects.push(new Cloud(225, 75));

				Mario.instObjects.push(new Coin(3550, 50));

				Mario.instObjects.push(new Coin(3550, 75));

				Mario.instObjects.push(new Coin(3050, 125));

				Mario.instObjects.push(new Coin(3025, 125));

				Mario.instObjects.push(new Coin(3000, 125));

				Mario.instObjects.push(new Coin(2700, 125));

				Mario.instObjects.push(new Coin(2675, 125));

				Mario.instObjects.push(new Coin(2650, 125));

				Mario.instObjects.push(new Coin(2325, 25));

				Mario.instObjects.push(new Coin(2350, 25));

				Mario.instObjects.push(new Coin(2400, 125));

				Mario.instObjects.push(new Coin(2400, 150));

				Mario.instObjects.push(new Coin(2075, 150));

				Mario.instObjects.push(new Coin(2075, 125));

				Mario.instObjects.push(new Coin(2000, 125));

				Mario.instObjects.push(new Coin(2000, 150));

				Mario.instObjects.push(new Coin(1575, 125));

				Mario.instObjects.push(new Coin(1475, 125));

				Mario.instObjects.push(new Coin(1325, 25));

				Mario.instObjects.push(new Coin(1400, 25));

				Mario.instObjects.push(new Coin(1225, 25));

				Mario.instObjects.push(new Coin(1150, 25));

				Mario.instObjects.push(new Coin(975, 100));

				Mario.instObjects.push(new Coin(950, 100));

				Mario.instObjects.push(new Coin(725, 50));

				Mario.instObjects.push(new Coin(675, 50));

				Mario.instObjects.push(new Finish(3900, 300));

				Mario.instObjects.push(new ElevatorBounce(2650, 225, 75, 'elevator_3', 1));

				Mario.instBlocks.push(new Brick(600, 125));

				Mario.instBlocks.push(new BrickMulti(625, 125));

				Mario.instBlocks.push(new Brick(900, 100));

				Mario.instBlocks.push(new Brick(1025, 100));

				Mario.instBlocks.push(new Bonus(1000, 100, 1));

				Mario.instBlocks.push(new Bonus(925, 100, 1));

				Mario.instBlocks.push(new Bonus(25, 200, 1, true));

				Mario.instBlocks.push(new Bonus(75, 200, 1, true));

				Mario.instBlocks.push(new Bonus(125, 200, 1, true));

				Mario.instBlocks.push(new Bonus(25, 100, 1, true));

				Mario.instBlocks.push(new Bonus(75, 100, 1, true));

				Mario.instBlocks.push(new Bonus(125, 100, 1, true));

				Mario.instBlocks.push(new Bonus(25, 0, 2, true));

				Mario.instBlocks.push(new Bonus(75, 0, 1, true));

				Mario.instBlocks.push(new Bonus(125, 0, 1, true));

				Mario.instBlocks.push(new Bonus(1475, 200, 1));

				Mario.instBlocks.push(new Bonus(1575, 200, 2));

				Mario.instBlocks.push(new Bonus(2400, 200, 1));

				Mario.instObjects.push(new ElevatorFall(2225, 225, 50, 'elevator_2'));

				Mario.instBlocks.push(new Brick(1975, 175));

				Mario.instBlocks.push(new Brick(2025, 175));

				Mario.instBlocks.push(new Brick(2100, 175));

				Mario.instBlocks.push(new Brick(2050, 175));

				Mario.instBlocks.push(new Bonus(2000, 175, 1));

				Mario.instBlocks.push(new Bonus(2075, 175, 1));

				Mario.instBlocks.push(new Bonus(2800, 125, 1, true));

				Mario.instBlocks.push(new Bonus(2850, 125, 1, true));

				Mario.instBlocks.push(new Bonus(2900, 125, 1, true));

				Mario.instBlocks.push(new Bonus(2825, 125, 1, true));

				Mario.instBlocks.push(new Bonus(2875, 125, 1, true));

				Mario.instBlocks.push(new BrickMulti(2575, 125));

				Mario.instBlocks.push(new Brick(2550, 125));

				Mario.instBlocks.push(new Brick(2525, 125));

				Mario.instBlocks.push(new Brick(3125, 125));

				Mario.instBlocks.push(new Brick(3175, 125));

				Mario.instBlocks.push(new Brick(3225, 125));

				Mario.instBlocks.push(new Bonus(3150, 125, 1));

				Mario.instBlocks.push(new Bonus(3200, 125, 1));

				Mario.instBlocks.push(new Bonus(2300, 0, 4, true));

				Mario.instEnemies.push(new TroopaRed(1000, 175));

				Mario.instEnemies.push(new Goomba(1225, 75));

				Mario.instEnemies.push(new Goomba(1325, 75));

				Mario.instEnemies.push(new TroopaRed(1525, 250));

				Mario.instEnemies.push(new Goomba(1800, 125));

				Mario.instEnemies.push(new TroopaGreen(2100, 250));

				Mario.instEnemies.push(new TroopaGreen(3825, 300));

				Mario.instEnemies.push(new TroopaRed(3175, 200));

				Mario.instBlocks.push(new Bonus(2375, 0, 5, true));

				Mario.instEffects.push(new Back(2));

				break;
			case (3):
				Mario.levelGenre = 3;

				Mario.musika = 2;

				Mario.level[0] = "ABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABA";
				Mario.level[1] = "          CD       AB         CD         ABAB         CD   DCABABABABABABABABABABABABABABABABABABABABD                                          CAB                       CD                  M";
				Mario.level[2] = "          AB        D          C         CAB           C    ABABABABABABABABABABABABABABABABABABABAB                                             CD                        C                  M";
				Mario.level[3] = "          CD                              CD           D    CABABABABABABABABABABABABABABABABABABABD                                             D                         D                  M";
				Mario.level[4] = "           C                              D                                                                UU   UU   UU   UU   UU   UU   UU                                                   M";
				Mario.level[5] = "                                                                                                           UU   UU   UU   UU   UU   UU   UU                           01                      M";
				Mario.level[6] = "                                                                                                                                                            01        23                      M";
				Mario.level[7] = "                         EFFFG                                                                                                                         01   23        23                      M";
				Mario.level[8] = "FG                      EKIIIJ                                                                                                                         23   23   01   23                      M";
				Mario.level[9] = "ILG                     HIIIIJ                              EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFG       UU   UU   UU   UU   UU   UU   UU         EFFFFFFFFFFFFFFFFFFFFFFFFGOOOOOOOOOOOOOOOOM";
				Mario.level[10] = "IILG                    HIIIIJ              EFG    EFFG     HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIJ       UU   UU   UU   UU   UU   UU   UU        EKIIIIIIIIIIIIIIIIIIIIIIIIJ                M";
				Mario.level[11] = "IIILFFFFFFFG    EFFG    HIIIIJ          EFFFKILG   HIIJ     HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIJ                                              EKIIIIIIIIIIIIIIIIIIIIIIIIIJ                M";
				Mario.level[12] = "IIIIIIIIIIIJ    HIIJ    HIIIILFFFFFFFFFFKIIIIIIJ   HIIJ     HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIJ                                             EKIIIIIIIIIIIIIIIIIIIIIIIIIIJ                M";
				Mario.level[13] = "IIIIIIIIIIIJ    HIIJ    HIIIIIIIIIIIIIIIIIIIIIIJ   HIIJ     HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIJ                                            EKIIIIIIIIIIIIIIIIIIIIIIIIIIIJ                M";
				Mario.level[14] = "IIIIIIIIIIIJ    HIIJ    HIIIIIIIIIIIIIIIIIIIIIIJ   HIIJ     HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIILFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFKIIIIIIIIIIIIIIIIIIIIIIIIIIIIJ                M";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Player.ResetPlayer(Mario.checkPoint == 3 ? 3700 : 25, 150);

				Mario.instObjects.push(new Coin(2375, 150));

				Mario.instObjects.push(new Coin(1575, 150));

				Mario.instObjects.push(new Coin(2275, 150));

				Mario.instObjects.push(new Coin(2175, 150));

				Mario.instObjects.push(new Coin(2075, 150));

				Mario.instObjects.push(new Coin(1975, 150));

				Mario.instObjects.push(new Coin(1875, 150));

				Mario.instObjects.push(new Coin(1775, 150));

				Mario.instObjects.push(new Coin(1675, 150));

				Mario.instObjects.push(new Coin(1125, 175));

				Mario.instObjects.push(new Coin(1125, 200));

				Mario.instObjects.push(new Coin(675, 75));

				Mario.instObjects.push(new Coin(3500, 300));

				Mario.instObjects.push(new Coin(3500, 50));

				Mario.instObjects.push(new Coin(2625, 50));

				Mario.instObjects.push(new Coin(2625, 300));

				Mario.instObjects.push(new Coin(3000, 300));

				Mario.instObjects.push(new Coin(2875, 300));

				Mario.instObjects.push(new Coin(2750, 300));

				Mario.instObjects.push(new Coin(2625, 175));

				Mario.instObjects.push(new Coin(2750, 50));

				Mario.instObjects.push(new Coin(2875, 50));

				Mario.instObjects.push(new Coin(3000, 50));

				Mario.instObjects.push(new Coin(3500, 175));

				Mario.instObjects.push(new Coin(3375, 300));

				Mario.instObjects.push(new Coin(3375, 50));

				Mario.instObjects.push(new Coin(3250, 50));

				Mario.instObjects.push(new Coin(3250, 300));

				Mario.instObjects.push(new Coin(3125, 300));

				Mario.instObjects.push(new Coin(3125, 50));

				Mario.instObjects.push(new Coin(3375, 175));

				Mario.instObjects.push(new Coin(3250, 175));

				Mario.instObjects.push(new Coin(3125, 175));

				Mario.instObjects.push(new Coin(3000, 175));

				Mario.instObjects.push(new Coin(2875, 175));

				Mario.instObjects.push(new Coin(2750, 175));

				Mario.instBlocks.push(new Brick(425, 150));

				Mario.instBlocks.push(new Bonus(450, 150, 1));

				Mario.instBlocks.push(new Brick(825, 175));

				Mario.instBlocks.push(new Brick(875, 175));

				Mario.instBlocks.push(new Brick(925, 175));

				Mario.instBlocks.push(new Bonus(900, 175, 1));

				Mario.instBlocks.push(new Bonus(1300, 150, 2));

				Mario.instBlocks.push(new Brick(1325, 150));

				Mario.instBlocks.push(new Bonus(850, 175, 0));

				Mario.instEnemies.push(new PPlant(3775, 150));

				Mario.instEnemies.push(new PPlant(3900, 125));

				Mario.instEnemies.push(new PPlant(4025, 175));

				Mario.instEnemies.push(new PPlant(4150, 100));

				Mario.instEnemies.push(new JumperThrower(537, 350, -10, 0, 150, 1, 0));

				Mario.instEnemies.push(new JumperThrower(1225, 350, -11, 0, 200, 1, 0));

				Mario.instEnemies.push(new JumperThrower(1425, 350, -11, 0, 180, 1, 0));

				Mario.instBlocks.push(new Bonus(4250, 75, 4, true));

				Mario.instBlocks.push(new Bonus(650, 75, 0));

				Mario.instBlocks.push(new Bonus(700, 75, 0));

				Mario.instBlocks.push(new Bonus(1125, 125, 0));

				Mario.instObjects.push(new Mill(1600, 100, 100, 2));

				Mario.instObjects.push(new Mill(1800, 200, 90, 3));

				Mario.instObjects.push(new Mill(2150, 100, 95, 2));
				Mario.instObjects.push(new Mill(2450, 200, 120, 3));

				Mario.instObjects.push(new Mill(2825, 200, 145, 3));

				Mario.instObjects.push(new Mill(3100, 100, 160, 1));

				Mario.instObjects.push(new Mill(3450, 200, 125, 3));

				Mario.instEffects.push(new Back(3));

				Mario.instEnemies.push(new Bowser(180 * 25, 175, 174 * 25, 3, 10, 0, 0, 0));

				break;

			case (4):
				Mario.levelGenre = 0;

				Mario.musika = 0;

				Mario.generateBackground(0);

				Mario.level[0] = "                                                                                                                                                                                                             ";
				Mario.level[1] = "                                                                                                                                                                                                             ";
				Mario.level[2] = "                                                                                                                                                                                                             ";
				Mario.level[3] = "                                                                                                                                                                                                             ";
				Mario.level[4] = "                                                                                                                                                                                                             ";
				Mario.level[5] = "                                                                                                                                                                                                             ";
				Mario.level[6] = "                                                                                                                                                                                                             ";
				Mario.level[7] = "                                                                                                                                                                                                             ";
				Mario.level[8] = "                                                                                                                                                                               MM                            ";
				Mario.level[9] = "                                                                                                                                                                               MM                            ";
				Mario.level[10] = "                M                    01                                                  01                                                                                MM  MM                            ";
				Mario.level[11] = "               MM                    23                                                  23           M                         M                                          MM  MM                            ";
				Mario.level[12] = "              MMM                    23         01                                       23           M                         M           01        01               MM  MM  MM                            ";
				Mario.level[13] = "             MMMM                    23         23                                       23           M                         M           23        23               MM  MM  MM                            ";
				Mario.level[14] = "ddddddddddddddddddddddddddddddddddddddddddddddddddddddddde    cddddddddddde  cdddddde  cdddddddddddddde                         cdddddddddddddde    cddddddddddddddddddde  ce  cddddddddddddddddddddddddddddd";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Player.ResetPlayer(75, 325);

				Mario.Hud.Time = 320;
				Mario.instEffects.push(new Background(-1000, 175, 'back_forest_4', 0.95));

				Mario.instEffects.push(new Background(1150, 125, 'back_clouds_2', 0.72));

				Mario.instEffects.push(new Background(3825, 275, 'back_forest_3', 0.7));

				Mario.instEffects.push(new Background(2775, 150, 'back_clouds_1', 0.6));

				Mario.instEffects.push(new Background(1275, 250, 'back_forest_3', 0.55));

				Mario.instEffects.push(new Background(2025, 225, 'back_forest_1', 0.5));

				Mario.instEffects.push(new Background(4050, 150, 'back_clouds_3', 0.4));

				Mario.instEffects.push(new Cloud(5000, 75));

				Mario.instEffects.push(new Cloud(4850, 175));

				Mario.instEffects.push(new Cloud(4650, 75));

				Mario.instEffects.push(new Cloud(4475, 150));

				Mario.instEffects.push(new Cloud(4175, 100));

				Mario.instEffects.push(new Cloud(3975, 50));

				Mario.instEffects.push(new Cloud(3800, 150));

				Mario.instEffects.push(new Cloud(3525, 75));

				Mario.instEffects.push(new Cloud(3125, 150));

				Mario.instEffects.push(new Cloud(2825, 50));

				Mario.instEffects.push(new Cloud(2675, 125));

				Mario.instEffects.push(new Cloud(2325, 100));

				Mario.instEffects.push(new Cloud(1925, 50));

				Mario.instEffects.push(new Cloud(1750, 150));

				Mario.instEffects.push(new Cloud(1375, 100));

				Mario.instEffects.push(new Cloud(1200, 25));

				Mario.instEffects.push(new Cloud(950, 100));

				Mario.instEffects.push(new Cloud(600, 50));

				Mario.instEffects.push(new Cloud(275, 150));

				Mario.instEffects.push(new Cloud(75, 75));

				Mario.layerWall.addChild(AddGraphic(5125, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(4950, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(5100, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5075, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5050, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5025, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5000, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4975, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4600, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(4825, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(4800, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4775, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4750, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4725, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4700, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4675, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4650, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4625, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4525, 300, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(4525, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(4550, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(4550, 250, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(4550, 275, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(4550, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(4500, 275, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(4500, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(4500, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(4450, 275, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(4450, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(4450, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(4125, 300, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(4125, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(3925, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(3800, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(3900, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3875, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3850, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3825, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3400, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(3475, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(3425, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3450, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2300, 300, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(2300, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2350, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(2525, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2500, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2475, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2450, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2425, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2400, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2375, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2175, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(2225, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(2200, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1975, 100, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(2050, 100, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(2050, 225, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(2050, 200, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(2050, 175, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(2050, 150, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(2050, 125, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1975, 125, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1975, 150, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1975, 175, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1975, 200, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1975, 225, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(2050, 250, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(1975, 250, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(1975, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2050, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2050, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1975, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2050, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1975, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1750, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(1550, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1725, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1700, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1600, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1675, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1650, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1625, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1575, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1300, 200, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(1300, 225, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1300, 250, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1300, 275, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1300, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(1300, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(75, 225, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(100, 275, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(75, 250, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(75, 275, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(100, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(100, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(75, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(75, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1000, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(975, 300, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(975, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1175, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(1150, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1125, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1100, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1075, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1050, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1025, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(625, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(600, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(575, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(550, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(525, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(500, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(475, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(450, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(425, 325, 'back_fence_2'));

				Mario.instObjects.push(new Coin(4175, 250));

				Mario.instObjects.push(new Coin(4200, 250));

				Mario.instObjects.push(new Coin(4275, 200));

				Mario.instObjects.push(new Coin(4300, 200));

				Mario.instObjects.push(new Coin(4400, 150));

				Mario.instObjects.push(new Coin(4375, 150));

				Mario.instObjects.push(new Coin(3350, 175));

				Mario.instObjects.push(new Coin(3325, 175));

				Mario.instObjects.push(new Coin(3300, 175));

				Mario.instObjects.push(new Coin(3200, 150));

				Mario.instObjects.push(new Coin(3200, 125));

				Mario.instObjects.push(new Coin(3200, 25));

				Mario.instObjects.push(new Coin(3200, 50));

				Mario.instObjects.push(new Coin(3200, 100));

				Mario.instObjects.push(new Coin(3200, 75));

				Mario.instObjects.push(new Coin(2375, 200));

				Mario.instObjects.push(new Coin(1950, 300));

				Mario.instObjects.push(new Coin(2350, 200));

				Mario.instObjects.push(new Coin(2325, 200));

				Mario.instObjects.push(new Coin(2075, 300));

				Mario.instObjects.push(new Coin(2050, 300));

				Mario.instObjects.push(new Coin(2025, 300));

				Mario.instObjects.push(new Coin(2000, 300));

				Mario.instObjects.push(new Coin(1975, 300));

				Mario.instObjects.push(new Coin(1575, 150));

				Mario.instObjects.push(new Coin(1575, 125));

				Mario.instObjects.push(new Coin(1575, 100));

				Mario.instObjects.push(new Coin(1575, 50));

				Mario.instObjects.push(new Coin(1575, 75));

				Mario.instObjects.push(new Coin(1550, 125));

				Mario.instObjects.push(new Coin(1550, 100));

				Mario.instObjects.push(new Coin(1550, 75));

				Mario.instObjects.push(new Coin(1550, 50));

				Mario.instObjects.push(new Coin(1550, 150));

				Mario.instObjects.push(new Coin(1075, 175));

				Mario.instObjects.push(new Coin(1050, 175));

				Mario.instObjects.push(new Coin(1025, 175));

				Mario.instObjects.push(new Coin(800, 250));

				Mario.instObjects.push(new Coin(725, 250));

				Mario.instObjects.push(new Coin(650, 250));

				Mario.instObjects.push(new Coin(575, 250));

				Mario.instObjects.push(new Coin(500, 250));

				Mario.instObjects.push(new Coin(400, 200));

				Mario.instObjects.push(new Coin(375, 225));

				Mario.instObjects.push(new Coin(350, 250));

				Mario.instObjects.push(new Coin(325, 275));

				Mario.instObjects.push(new ElevatorFall(2625, 275, 75, 'elevator_3'));

				Mario.instObjects.push(new ElevatorFall(2775, 275, 75, 'elevator_3'));

				Mario.instObjects.push(new ElevatorFall(2925, 275, 75, 'elevator_3'));

				Mario.instObjects.push(new ElevatorFall(3075, 275, 75, 'elevator_3'));

				Mario.instEnemies.push(new PPlant(925, 225));

				Mario.instEnemies.push(new PPlant(1200, 275));

				Mario.instEnemies.push(new PPlant(2225, 225));

				Mario.instEnemies.push(new PPlant(3750, 275));

				Mario.instEnemies.push(new PPlant(3500, 275));

				Mario.instBlocks.push(new Brick(125, 250));

				Mario.instBlocks.push(new Brick(175, 250));

				Mario.instBlocks.push(new Brick(200, 250));

				Mario.instBlocks.push(new Brick(250, 250));

				Mario.instBlocks.push(new Brick(550, 125));

				Mario.instBlocks.push(new Brick(575, 125));

				Mario.instBlocks.push(new Brick(600, 125));

				Mario.instBlocks.push(new Brick(625, 125));

				Mario.instBlocks.push(new Brick(650, 125));

				Mario.instBlocks.push(new Brick(700, 125));

				Mario.instBlocks.push(new Brick(725, 125));

				Mario.instBlocks.push(new Brick(750, 125));

				Mario.instBlocks.push(new Brick(775, 125));

				Mario.instBlocks.push(new Brick(800, 125));

				Mario.instBlocks.push(new Brick(825, 125));

				Mario.instBlocks.push(new Brick(850, 125));

				Mario.instBlocks.push(new Brick(525, 125));

				Mario.instBlocks.push(new Brick(500, 125));

				Mario.instBlocks.push(new Brick(450, 125));

				Mario.instBlocks.push(new Brick(1025, 225));

				Mario.instBlocks.push(new Brick(1050, 225));

				Mario.instBlocks.push(new Brick(1400, 250));

				Mario.instBlocks.push(new Brick(1550, 250));

				Mario.instBlocks.push(new Brick(1575, 250));

				Mario.instBlocks.push(new Brick(1675, 250));

				Mario.instBlocks.push(new Brick(1750, 250));

				Mario.instBlocks.push(new Brick(3300, 225));

				Mario.instBlocks.push(new Brick(3350, 225));

				Mario.instBlocks.push(new Brick(3900, 225));

				Mario.instBlocks.push(new Brick(3925, 225));

				Mario.instBlocks.push(new Brick(3975, 225));

				Mario.instBlocks.push(new Brick(4000, 225));

				Mario.instBlocks.push(new Brick(4025, 225));

				Mario.instBlocks.push(new Brick(4075, 225));

				Mario.instBlocks.push(new Bonus(275, 250, 1));

				Mario.instBlocks.push(new Bonus(225, 250, 1));

				Mario.instBlocks.push(new Bonus(150, 250, 1));

				Mario.instBlocks.push(new Bonus(475, 125, 1));

				Mario.instBlocks.push(new Bonus(675, 125, 1));

				Mario.instBlocks.push(new Bonus(1075, 225, 1));

				Mario.instBlocks.push(new Bonus(1425, 250, 1));

				Mario.instBlocks.push(new Bonus(1700, 250, 1));

				Mario.instBlocks.push(new Bonus(1725, 250, 1));

				Mario.instBlocks.push(new Bonus(2325, 250, 1));

				Mario.instBlocks.push(new Bonus(2375, 250, 1));

				Mario.instBlocks.push(new Bonus(2550, 175, 5, true));

				Mario.instBlocks.push(new Bonus(3200, 175, 3, true));

				Mario.instBlocks.push(new Bonus(3950, 225, 1));

				Mario.instBlocks.push(new Bonus(4050, 225, 1));

				Mario.instBlocks.push(new Bonus(4125, 225, 1));

				Mario.instBlocks.push(new Bonus(3875, 225, 1));

				Mario.instBlocks.push(new Bonus(875, 125, 2));

				Mario.instBlocks.push(new Bonus(1425, 150, 1, true));

				Mario.instBlocks.push(new Bonus(1425, 50, 1, true));

				Mario.instBlocks.push(new Bonus(1975, 250, 1, true));

				Mario.instBlocks.push(new Bonus(2000, 250, 1, true));

				Mario.instBlocks.push(new Bonus(2025, 250, 1, true));

				Mario.instBlocks.push(new Bonus(2050, 250, 1, true));

				Mario.instBlocks.push(new Bonus(1975, 150, 1, true));

				Mario.instBlocks.push(new Bonus(2050, 150, 1, true));

				Mario.instBlocks.push(new Bonus(2025, 150, 1, true));

				Mario.instBlocks.push(new Bonus(2000, 150, 1, true));

				Mario.instBlocks.push(new Bonus(1975, 50, 1, true));

				Mario.instBlocks.push(new Bonus(2025, 50, 1, true));

				Mario.instBlocks.push(new Bonus(2050, 50, 1, true));

				Mario.instBlocks.push(new Bonus(2000, 50, 4, true));

				Mario.instBlocks.push(new BrickMulti(3325, 225));

				Mario.instBlocks.push(new BrickMulti(4100, 225));

				Mario.instBlocks.push(new BrickMulti(2350, 250));

				Mario.instObjects.push(new Finish(4575, 325));

				Mario.instEnemies.push(new Goomba(400, 225));

				Mario.instEnemies.push(new Goomba(350, 275));

				Mario.instEnemies.push(new FlyGreen(850, 300));

				Mario.instEnemies.push(new FlyGreen(700, 300));

				Mario.instEnemies.push(new FlyRed(1475, 225));

				Mario.instEnemies.push(new Goomba(625, 100));

				Mario.instEnemies.push(new Goomba(700, 100));

				Mario.instEnemies.push(new Goomba(1700, 325));

				Mario.instEnemies.push(new Goomba(1750, 325));

				Mario.instEnemies.push(new TroopaRed(1625, 325));

				Mario.instEnemies.push(new Goomba(2550, 250));

				Mario.instEnemies.push(new TroopaGreen(3325, 325));

				Mario.instEnemies.push(new Goomba(3425, 325));

				Mario.instEnemies.push(new Goomba(4175, 275));

				Mario.instEnemies.push(new Goomba(4125, 325));

				Mario.instEnemies.push(new TroopaGreen(4075, 325));

				break;

			case 5:
				Mario.levelGenre = 0;

				Mario.musika = 0;

				Mario.generateBackground(0);

				Mario.level[0] = "                                                                                                                                                                                                                                                                                                  ";
				Mario.level[1] = "                                                                                                                                                                                                  MM                                                                                              ";
				Mario.level[2] = "                                                                                                                                                                                                  23                                                                                              ";
				Mario.level[3] = "                                                                                                                                                                                                  45                                                                                              ";
				Mario.level[4] = "                                                                                                                                                                                                             MQQQQQQQQQQQQQQQM                                                                    ";
				Mario.level[5] = "                                                                                                                                                                                                                                                                                                  ";
				Mario.level[6] = "                                                                      ijkkkkkkkkkkkkkkkkkkkkkklm                                                                                                         MQM                                                                                      ";
				Mario.level[7] = "                                                                       noooooooooooooooooooooop                                                                                                                                                                                                   ";
				Mario.level[8] = "                                       MQQQQQQQQQQQQQQQM               noooooooooooooooooooooop                                                                                                      MQM                                                                                          ";
				Mario.level[9] = "                                                                       noooooooooooooooooooooop                                   MQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQM        MQQQQQQQQQQQQQQQQQQM                                                                                                  ";
				Mario.level[10] = " 01       MQQQQQQQQQQQQQQQQQQQQQQQQM                                   noooooooooooooooooooooop     MQQM    MQQM                                                                                                                                                                        01        ";
				Mario.level[11] = " 23                                                                    noooooooooooooooooooooop                    MQM  MQM  MQM                                                                  01                            cddddddddddddddddddddddd                                23        ";
				Mario.level[12] = "ijkkkklm                                                    MQQQQQQM   noooooooooooooooooooooop                                                                                                   23                            fggggggggggggggggggggggg                               ijkkkklm   ";
				Mario.level[13] = " noooop                                                                noooooooooooooooooooooop                                                                                                   MM                            fggggggggggggggggggggggg                                noooop    ";
				Mario.level[14] = " noooop                                                                noooooooooooooooooooooop                                                                                                                                 fggggggggggggggggggggggg                                noooop    ";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Player.ResetPlayer(25, 125);

				Mario.layerWall.addChild(AddGraphic(6150, 250, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(6125, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6100, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6075, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6050, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6025, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6000, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5975, 250, 'back_fence_1'));

				Mario.instEffects.push(new Background(1700, 25, 'back_clouds_2', 0.32));

				Mario.instEffects.push(new Background(5775, 75, 'back_clouds_3', 0.18));

				Mario.instEffects.push(new Background(3800, 75, 'back_clouds_1', 0.05));

				Mario.instEffects.push(new Cloud(5225, 175));

				Mario.instEffects.push(new Cloud(4100, 25));

				Mario.instEffects.push(new Cloud(2600, 100));

				Mario.instEffects.push(new Cloud(1525, 25));

				Mario.instEffects.push(new Cloud(200, 125));

				Mario.instObjects.push(new Coin(5500, 50));

				Mario.instObjects.push(new Coin(5350, 50));

				Mario.instObjects.push(new Coin(5175, 50));

				Mario.instObjects.push(new Coin(4875, 0));

				Mario.instObjects.push(new Coin(4850, 0));

				Mario.instObjects.push(new Coin(4650, 125));

				Mario.instObjects.push(new Coin(4675, 100));

				Mario.instObjects.push(new Coin(4625, 100));

				Mario.instObjects.push(new Coin(3550, 25));

				Mario.instObjects.push(new Coin(3150, 175));

				Mario.instObjects.push(new Coin(3025, 175));

				Mario.instObjects.push(new Coin(2900, 175));

				Mario.instObjects.push(new Coin(2050, 50));

				Mario.instObjects.push(new Coin(2250, 50));

				Mario.instObjects.push(new Coin(2075, 50));

				Mario.instObjects.push(new Coin(2025, 50));

				Mario.instObjects.push(new Coin(1850, 50));

				Mario.instObjects.push(new Coin(1650, 125));

				Mario.instObjects.push(new Coin(1525, 125));

				Mario.instObjects.push(new Coin(1650, 150));

				Mario.instObjects.push(new Coin(1525, 150));

				Mario.instObjects.push(new Coin(1525, 175));

				Mario.instObjects.push(new Coin(1650, 175));

				Mario.instObjects.push(new Coin(1300, 125));

				Mario.instObjects.push(new Coin(1325, 125));

				Mario.instObjects.push(new Coin(1050, 125));

				Mario.instObjects.push(new Coin(1025, 125));

				Mario.instObjects.push(new Coin(725, 125));

				Mario.instObjects.push(new Coin(650, 125));

				Mario.instObjects.push(new Coin(475, 125));

				Mario.instObjects.push(new Coin(400, 125));

				Mario.layerWall.addChild(AddGraphic(5575, 250, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(5650, 250, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(5625, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5600, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5925, 200, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(5925, 225, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5925, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5725, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5725, 200, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(5725, 225, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(5725, 175, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(5800, 200, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(5800, 225, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(5800, 250, 'back_tree_1'));

				Mario.instObjects.push(new ElevatorFall(2050, 325, 25, 'elevator_1'));

				Mario.instObjects.push(new ElevatorFall(1975, 325, 25, 'elevator_1'));

				Mario.instBlocks.push(new Bonus(2000, 225, 4));

				Mario.instBlocks.push(new Bonus(2025, 225, 2));

				Mario.instObjects.push(new ElevatorFall(1775, 325, 25, 'elevator_1'));

				Mario.instObjects.push(new ElevatorFall(1875, 325, 25, 'elevator_1'));

				Mario.instObjects.push(new Finish(5700, 250));

				Mario.instBlocks.push(new Brick(500, 150));

				Mario.instBlocks.push(new Brick(625, 150));

				Mario.instBlocks.push(new Brick(750, 150));

				Mario.instBlocks.push(new Brick(1150, 75));

				Mario.instBlocks.push(new Brick(1200, 75));

				Mario.instBlocks.push(new Brick(3525, 100));

				Mario.instBlocks.push(new Brick(3550, 100));

				Mario.instBlocks.push(new Brick(2150, 50));

				Mario.instBlocks.push(new Brick(1950, 50));

				Mario.instBlocks.push(new Brick(1925, 50));

				Mario.instBlocks.push(new Brick(4025, 100));

				Mario.instBlocks.push(new Brick(4000, 100));

				Mario.instBlocks.push(new Brick(4350, 100));

				Mario.instBlocks.push(new Brick(4375, 100));

				Mario.instBlocks.push(new Bonus(450, 150, 1));

				Mario.instBlocks.push(new Bonus(425, 150, 1));

				Mario.instBlocks.push(new Bonus(700, 150, 1));

				Mario.instBlocks.push(new Bonus(825, 150, 1));

				Mario.instBlocks.push(new Bonus(300, 150, 1));

				Mario.instBlocks.push(new Bonus(675, 150, 2));

				Mario.instBlocks.push(new Bonus(1100, 75, 1));

				Mario.instBlocks.push(new Bonus(1250, 75, 1));

				Mario.instBlocks.push(new Bonus(1575, 200, 1));

				Mario.instBlocks.push(new Bonus(1600, 200, 1));

				Mario.instBlocks.push(new Bonus(1975, 50, 1, true));

				Mario.instBlocks.push(new Bonus(1900, 50, 1, true));

				Mario.instBlocks.push(new Bonus(2125, 50, 1, true));

				Mario.instBlocks.push(new Bonus(2200, 50, 1, true));

				Mario.instBlocks.push(new BrickMulti(2175, 50));

				Mario.instBlocks.push(new BrickMulti(1175, 75));

				Mario.instBlocks.push(new BrickMulti(375, 150));

				Mario.instBlocks.push(new BrickMulti(3575, 100));

				Mario.instBlocks.push(new Bonus(3625, 100, 1));

				Mario.instBlocks.push(new Bonus(3650, 100, 1));

				Mario.instBlocks.push(new Bonus(3950, 100, 1));

				Mario.instBlocks.push(new Bonus(3925, 100, 1));

				Mario.instBlocks.push(new Bonus(3475, 100, 1));

				Mario.instBlocks.push(new Bonus(3450, 100, 1));

				Mario.instBlocks.push(new Bonus(4425, 100, 1));

				Mario.instBlocks.push(new Bonus(4450, 100, 1));

				Mario.instBlocks.push(new Bonus(4625, 125, 1));

				Mario.instBlocks.push(new Bonus(4675, 125, 1));

				Mario.instBlocks.push(new Bonus(4650, 100, 3, true));

				Mario.instBlocks.push(new Bonus(4900, 75, 5, true));

				Mario.instEnemies.push(new Goomba(625, 225));

				Mario.instEnemies.push(new Goomba(725, 225));

				Mario.instEnemies.push(new Goomba(825, 225));

				Mario.instEnemies.push(new TroopaRed(575, 225));

				Mario.instEnemies.push(new FlyRed(925, 100));

				Mario.instEnemies.push(new FlyRed(2825, 100));

				Mario.instEnemies.push(new FlyRed(4150, 150));

				Mario.instEnemies.push(new FlyRed(4225, 75));

				Mario.instEnemies.push(new FlyGreen(1225, 175));

				Mario.instEnemies.push(new Spiny(2050, 125));

				Mario.instEnemies.push(new Goomba(2000, 125));

				Mario.instEnemies.push(new Goomba(2100, 125));

				Mario.instEnemies.push(new Goomba(3775, 200));

				Mario.instEnemies.push(new Goomba(3525, 200));

				Mario.instEnemies.push(new Goomba(4550, 200));

				Mario.instEnemies.push(new Goomba(4600, 200));

				Mario.instEnemies.push(new Spiny(5325, 75));

				Mario.instEnemies.push(new Spiny(5375, 75));

				Mario.instBlocks.push(new Bonus(7175, 150, 4, true));

				Mario.instBlocks.push(new Bonus(7025, 150, 1, true));

				Mario.instBlocks.push(new Bonus(7025, 50, 2, true));

				Mario.instEffects.push(new Back(2));

				break;

			case 6:
				Mario.levelGenre = 0;

				Mario.musika = 0;

				Mario.generateBackground(0);

				Mario.level[0] = "                                                                                                                           MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                                                      ";
				Mario.level[1] = "                                                                                                                           23           23            23               23             23              23                                                      ";
				Mario.level[2] = "                                                                                                                           23           23            23               23             45              23                                                      ";
				Mario.level[3] = "                                                                                                                           23           23            23               23                             23                                                      ";
				Mario.level[4] = "                                                                                                                           45           23            23               45                             23                                                      ";
				Mario.level[5] = "                                           cddde                                                   cdddeQQQcddde                        23            45                                              23                                                      ";
				Mario.level[6] = "                                           fgggh                                                   fgggh   fgggh                        23                                                            23           cddde                                      ";
				Mario.level[7] = "                                           fgggh                                                   fgggh   fgggh                        23                                                            45           fgggh                                      ";
				Mario.level[8] = "                                   cddde   fgggh                                           cdddeQQQfgggh   fgggh           01           45   01                                                            cdddeQQQfgggh                                      ";
				Mario.level[9] = "           cddde                   fgggh   fgggh           cddde                           fgggh   fgggh   fgggh           23                23                                                            fgggh   fgggh                                      ";
				Mario.level[10] = "           fgggh                   fgggh   fgggh           fgggh           cdddeQQQcdddeQQQfgggh   fgggh   fgggh           23       01       23               01                                           fgggh   fgggh                                      ";
				Mario.level[11] = "           fgggh           cddde   fgggh   fgggh           fgggh           fgggh   fgggh   fgggh   fgggh   fgggh          M23M      23       23               23                                           fgggh   fgggh                                      ";
				Mario.level[12] = "ddddddde   fgggh           fgggh   fgggh   fgggh   cddde   fgggh           fgggh   fgggh   fgggh   fgggh   fgggh   ijkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkklmQQQfgggh   fgggh   cdddddddddddddddddddddddddddddddddd";
				Mario.level[13] = "gggggggh   fgggh   cddde   fgggh   fgggh   fgggh   fgggh   fgggh   cddde   fgggh   fgggh   fgggh   fgggh   fgggh    nooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooop    fgggh   fgggh   fgggggggggggggggggggggggggggggggggg";
				Mario.level[14] = "gggggggh   fgggh   fgggh   fgggh   fgggh   fgggh   fgggh   fgggh   fgggh   fgggh   fgggh   fgggh   fgggh   fgggh    nooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooop    fgggh   fgggh   fgggggggggggggggggggggggggggggggggg";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Player.ResetPlayer(25, 275);

				Mario.instEffects.push(new Background(25, 25, 'back_hill_big', 0.80));

				Mario.instEffects.push(new Background(825, 150, 'back_clouds_8', 0.69));

				Mario.instEffects.push(new Background(4950, 200, 'back_clouds_4', 0.67));

				Mario.instEffects.push(new Background(2125, 175, 'back_clouds_4', 0.61));

				Mario.instEffects.push(new Background(3300, 275, 'back_hill', 0.43));

				Mario.instEffects.push(new Background(4050, 150, 'back_clouds_1', 0.25));

				Mario.instEffects.push(new Background(1775, 100, 'back_clouds_2', 0.17));

				Mario.instEffects.push(new Background(3225, 50, 'back_clouds_2', 0.12));

				Mario.instEffects.push(new Cloud(5975, 50));

				Mario.instEffects.push(new Cloud(5650, 100));

				Mario.instEffects.push(new Cloud(5200, 0));

				Mario.instEffects.push(new Cloud(4825, 75));

				Mario.instEffects.push(new Cloud(4375, 150));

				Mario.instEffects.push(new Cloud(3575, 50));

				Mario.instEffects.push(new Cloud(2875, 150));

				Mario.instEffects.push(new Cloud(2425, 25));

				Mario.instEffects.push(new Cloud(2000, 125));

				Mario.instEffects.push(new Cloud(1650, 50));

				Mario.instEffects.push(new Cloud(1250, 125));

				Mario.instEffects.push(new Cloud(1000, 25));

				Mario.instEffects.push(new Cloud(675, 0));

				Mario.instEffects.push(new Cloud(425, 125));

				Mario.instEffects.push(new Cloud(25, 25));

				Mario.layerWall.addChild(AddGraphic(6025, 275, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(6000, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5975, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5950, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5925, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5900, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5875, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5850, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5825, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5800, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5775, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5750, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5725, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5700, 275, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(5675, 175, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(5675, 200, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(5675, 225, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(5675, 250, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(5675, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5375, 75, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(5300, 100, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(5375, 100, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5375, 125, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5300, 125, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5125, 175, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(5150, 175, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5175, 175, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5200, 175, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5225, 175, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5250, 175, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2475, 100, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(2675, 100, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(2650, 100, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2625, 100, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2600, 100, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2575, 100, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2550, 100, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2525, 100, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2500, 100, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2450, 175, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2425, 175, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2400, 175, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2375, 175, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2350, 175, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1875, 225, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(2250, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2225, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2200, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2175, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2150, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2125, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2100, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2075, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1975, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1950, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1925, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1900, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2050, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2025, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2000, 225, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1575, 175, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(1575, 200, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1500, 150, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(1500, 175, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(1500, 200, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1400, 275, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(1350, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1375, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1275, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1300, 275, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(1325, 275, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1250, 275, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1150, 100, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1200, 100, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(1175, 100, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(925, 175, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1000, 175, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(950, 175, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(975, 175, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(700, 225, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(700, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(450, 300, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(600, 300, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(575, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(550, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(525, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(500, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(475, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(150, 275, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(25, 275, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(50, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(75, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(100, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(125, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(175, 150, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(175, 175, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(175, 200, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(175, 225, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(175, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(175, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(150, 175, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(150, 200, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(150, 225, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(150, 250, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(150, 275, 'back_tree_1'));

				Mario.instObjects.push(new Coin(4050, 200));

				Mario.instObjects.push(new Coin(4150, 200));

				Mario.instObjects.push(new Coin(4250, 200));

				Mario.instObjects.push(new Coin(4850, 200));

				Mario.instObjects.push(new Coin(4750, 200));

				Mario.instObjects.push(new Coin(4650, 200));

				Mario.instObjects.push(new Coin(4550, 200));

				Mario.instObjects.push(new Coin(4450, 200));

				Mario.instObjects.push(new Coin(4350, 200));

				Mario.instObjects.push(new Coin(2725, 75));

				Mario.instObjects.push(new Coin(2525, 75));

				Mario.instObjects.push(new Coin(2325, 150));

				Mario.instObjects.push(new Coin(2125, 200));

				Mario.instObjects.push(new Coin(1925, 200));

				Mario.instObjects.push(new Coin(1725, 275));

				Mario.instObjects.push(new Coin(1525, 175));

				Mario.instObjects.push(new Coin(1325, 250));

				Mario.instObjects.push(new Coin(1125, 75));

				Mario.instObjects.push(new Coin(925, 150));

				Mario.instObjects.push(new Coin(725, 225));

				Mario.instObjects.push(new Coin(525, 275));

				Mario.instObjects.push(new Coin(325, 175));

				Mario.instBlocks.push(new Brick(300, 100));

				Mario.instBlocks.push(new Brick(350, 100));

				Mario.instBlocks.push(new Brick(500, 200));

				Mario.instBlocks.push(new Brick(550, 200));

				Mario.instBlocks.push(new Brick(700, 150));

				Mario.instBlocks.push(new Brick(750, 150));

				Mario.instBlocks.push(new Brick(900, 75));

				Mario.instBlocks.push(new Brick(950, 75));

				Mario.instBlocks.push(new Brick(1100, 0));

				Mario.instBlocks.push(new Brick(1150, 0));

				Mario.instBlocks.push(new Brick(1300, 175));

				Mario.instBlocks.push(new Brick(1350, 175));

				Mario.instBlocks.push(new Brick(1500, 100));

				Mario.instBlocks.push(new Brick(1550, 100));

				Mario.instBlocks.push(new Brick(1700, 200));

				Mario.instBlocks.push(new Brick(1750, 200));

				Mario.instBlocks.push(new Brick(1900, 125));

				Mario.instBlocks.push(new Brick(1950, 125));

				Mario.instBlocks.push(new Brick(2100, 125));

				Mario.instBlocks.push(new Brick(2150, 125));

				Mario.instBlocks.push(new Brick(2300, 75));

				Mario.instBlocks.push(new Brick(2350, 75));

				Mario.instBlocks.push(new Brick(2500, 0));

				Mario.instBlocks.push(new Brick(2550, 0));

				Mario.instBlocks.push(new Brick(2700, 0));

				Mario.instBlocks.push(new Brick(2750, 0));

				Mario.instBlocks.push(new Brick(5100, 75));

				Mario.instBlocks.push(new Brick(5150, 75));

				Mario.instBlocks.push(new Brick(5300, 25));

				Mario.instBlocks.push(new Brick(5350, 25));

				Mario.instBlocks.push(new Bonus(325, 100, 1));

				Mario.instBlocks.push(new Bonus(525, 200, 1));

				Mario.instBlocks.push(new Bonus(725, 150, 1));

				Mario.instBlocks.push(new Bonus(925, 75, 1));

				Mario.instBlocks.push(new Bonus(1125, 0, 1));

				Mario.instBlocks.push(new Bonus(1325, 175, 1));

				Mario.instBlocks.push(new Bonus(1525, 100, 1));

				Mario.instBlocks.push(new Bonus(1725, 200, 1));

				Mario.instBlocks.push(new Bonus(1925, 125, 1));

				Mario.instBlocks.push(new Bonus(2125, 125, 1));

				Mario.instBlocks.push(new Bonus(2325, 75, 1));

				Mario.instBlocks.push(new Bonus(2525, 0, 1));

				Mario.instBlocks.push(new Bonus(2725, 0, 1));

				Mario.instBlocks.push(new Bonus(5325, 25, 1));

				Mario.instBlocks.push(new Bonus(5125, 75, 2));

				Mario.instBlocks.push(new Bonus(1700, 100, 1, true));

				Mario.instBlocks.push(new Bonus(1725, 100, 1, true));

				Mario.instBlocks.push(new Bonus(1300, 75, 1, true));

				Mario.instBlocks.push(new Bonus(1325, 75, 1, true));

				Mario.instBlocks.push(new Bonus(1350, 75, 1, true));

				Mario.instBlocks.push(new Bonus(1500, 0, 1, true));

				Mario.instBlocks.push(new Bonus(1525, 0, 1, true));

				Mario.instBlocks.push(new Bonus(1550, 0, 1, true));

				Mario.instBlocks.push(new Bonus(500, 100, 1, true));

				Mario.instBlocks.push(new Bonus(525, 100, 1, true));

				Mario.instBlocks.push(new Bonus(550, 100, 1, true));

				Mario.instBlocks.push(new Bonus(525, 0, 3, true));

				Mario.instBlocks.push(new Bonus(500, 0, 1, true));

				Mario.instBlocks.push(new Bonus(550, 0, 1, true));

				Mario.instBlocks.push(new Bonus(1700, 0, 1, true));

				Mario.instBlocks.push(new Bonus(1750, 0, 1, true));

				Mario.instBlocks.push(new Bonus(700, 50, 1, true));

				Mario.instBlocks.push(new Bonus(725, 50, 1, true));

				Mario.instBlocks.push(new Bonus(750, 50, 1, true));

				Mario.instBlocks.push(new Bonus(300, 0, 1, true));

				Mario.instBlocks.push(new Bonus(325, 0, 1, true));

				Mario.instBlocks.push(new Bonus(350, 0, 1, true));

				Mario.instBlocks.push(new Bonus(1750, 100, 1, true));

				Mario.instBlocks.push(new Bonus(1900, 25, 1, true));

				Mario.instBlocks.push(new Bonus(1925, 25, 1, true));

				Mario.instBlocks.push(new Bonus(1950, 25, 1, true));

				Mario.instBlocks.push(new Bonus(2100, 25, 1, true));

				Mario.instBlocks.push(new Bonus(2125, 25, 1, true));

				Mario.instBlocks.push(new Bonus(2150, 25, 1, true));

				Mario.instEnemies.push(new FlyRed(425, 75));

				Mario.instEnemies.push(new FlyRed(625, 175));

				Mario.instEnemies.push(new FlyRed(825, 25));

				Mario.instEnemies.push(new FlyRed(1025, 75));

				Mario.instEnemies.push(new FlyRed(1225, 25));

				Mario.instEnemies.push(new FlyRed(1425, 100));

				Mario.instEnemies.push(new FlyRed(1625, 175));

				Mario.instEnemies.push(new FlyRed(1825, 50));

				Mario.instEnemies.push(new FlyRed(2825, 25));

				Mario.instEnemies.push(new PPlant(3075, 175));

				Mario.instEnemies.push(new PPlant(3300, 225));

				Mario.instEnemies.push(new PPlant(3525, 175));

				Mario.instEnemies.push(new PFlame(3950, 225));

				Mario.instEnemies.push(new PPlant(3750, 150, -1));

				Mario.instEnemies.push(new PPlant(3400, 225, -1));

				Mario.instEnemies.push(new PPlant(3075, 125, -1));

				Mario.instEnemies.push(new PPlant(4175, 125, -1));

				Mario.instEnemies.push(new PPlant(4950, 200, -1));

				Mario.instEnemies.push(new PFlame(4550, 75, -1));

				Mario.instEnemies.push(new Goomba(4750, 275));

				Mario.instEnemies.push(new Goomba(4800, 275));

				Mario.instEnemies.push(new Spiny(5050, 275));

				Mario.instEnemies.push(new FlyGreen(4225, 275));

				Mario.instEnemies.push(new Goomba(4400, 275));

				Mario.instEnemies.push(new Goomba(4450, 275));

				Mario.instEnemies.push(new Goomba(4500, 275));

				Mario.instEnemies.push(new Spiny(5000, 275));

				Mario.instObjects.push(new Finish(5600, 275));

				Mario.instEnemies.push(new Goomba(4850, 275));

				Mario.instBlocks.push(new Bonus(1725, 0, 4, true));

				Mario.instEnemies.push(new Spiny(3700, 275));

				Mario.instEnemies.push(new Spiny(3850, 275));

				Mario.instEnemies.push(new Spiny(3250, 275));

				Mario.instEnemies.push(new Spiny(5300, 125));

				Mario.instEnemies.push(new Spiny(5350, 125));

				Mario.instEnemies.push(new Spiny(2725, 100));

				Mario.instEnemies.push(new Spiny(2525, 100));

				Mario.instEnemies.push(new Spiny(2325, 175));

				Mario.instEnemies.push(new Spiny(2125, 225));

				break;

			case 7:
				Mario.levelGenre = 3;

				Mario.musika = 2;

				Mario.level[0] = "ABABABABABABABABABABCABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABA";
				Mario.level[1] = "         AB                           ABABABD                       ABAB                      ABAB                AB                                                                                         A";
				Mario.level[2] = "                                       ABABAB                        ABAB                    ABAB                                                                                                            A";
				Mario.level[3] = "                                                                      AB                      AB                                                                                                             A";
				Mario.level[4] = "                                                                                                                                                                                                             A";
				Mario.level[5] = "                                                                                                                                                                     EG            EFG                       A";
				Mario.level[6] = "                                                                                                                                              EFG                  EFKJ            HIJ                       A";
				Mario.level[7] = "FG                                                                                                                                            HIJ     EFG          HIILG         EFKIJ                       A";
				Mario.level[8] = "ILG                                                                                                                                  EG       HILFG  EKILG         HIIILG        HIIIJ                       A";
				Mario.level[9] = "IILG                                                                                                                                 HLG      HIIILFFKIIIJ         HIIIILG       HIIIJ                       A";
				Mario.level[10] = "IIILFFFFG       EFFFFFFFFFFFG             EG           EG           EG                    01             01                          HILFG    HIIIIIIIIIIJ        EKIIIIIJ       HIIIJ                       A";
				Mario.level[11] = "IIIIIIIILG     EKIIIIIIIIIIILG            HJ           HJ           HJ       01           23             23          01              HIIIJ   EKIIIIIIIIIIJ       EKIIIIIILG    EFKIIILFFFFFFGOOOOOOOOOOOOOOOOA";
				Mario.level[12] = "IIIIIIIIIJ     HIIIIIIIIIIIIIJ            HJ           HJ           HJ   EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFG          HIIILG  HIIIIIIIIIIILFG    EKIIIIIIIILG  EKIIIIIIIIIIIIJ                A";
				Mario.level[13] = "IIIIIIIIIJ     HIIIIIIIIIIIIIJ            HJ           HJ           HJ   HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIILFFFFFFFFFFKIIIILFFKIIIIIIIIIIIIILFFFFKIIIIIIIIIILFFKIIIIIIIIIIIIIJ                A";
				Mario.level[14] = "IIIIIIIIIJ     HIIIIIIIIIIIIIJ            HJ           HJ           HJ   HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIJ                A";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Player.ResetPlayer(Mario.checkPoint == 7 ? 4400 : 25, 150);

				Mario.instObjects.push(new Coin(175, 175));

				Mario.instObjects.push(new Coin(125, 175));

				Mario.instObjects.push(new Coin(3250, 250));

				Mario.instObjects.push(new Coin(3200, 250));

				Mario.instObjects.push(new Coin(3150, 250));

				Mario.instObjects.push(new Coin(3100, 250));

				Mario.instObjects.push(new Coin(3550, 100));

				Mario.instObjects.push(new Coin(3575, 100));

				Mario.instObjects.push(new Coin(3600, 100));

				Mario.instObjects.push(new Coin(3825, 150));

				Mario.instObjects.push(new Coin(3800, 125));

				Mario.instObjects.push(new Coin(3750, 125));

				Mario.instObjects.push(new Coin(3775, 125));

				Mario.instObjects.push(new Coin(4525, 75));

				Mario.instObjects.push(new Coin(4475, 75));

				Mario.instObjects.push(new Coin(4500, 75));

				Mario.instObjects.push(new Coin(4150, 75));

				Mario.instObjects.push(new Coin(4075, 100));

				Mario.instObjects.push(new Coin(4100, 100));

				Mario.instObjects.push(new Coin(4125, 75));

				Mario.instObjects.push(new ElevatorFall(850, 250, 100, 'elevator_4'));

				Mario.instObjects.push(new ElevatorFall(1200, 250, 75, 'elevator_3'));

				Mario.instObjects.push(new ElevatorFall(1525, 250, 75, 'elevator_3'));

				Mario.instEnemies.push(new BBeetle(2125, 275));

				Mario.instEnemies.push(new BBeetle(2475, 275));

				Mario.instEnemies.push(new BBeetle(2800, 275));

				Mario.instEnemies.push(new PFlame(2925, 250));

				Mario.instEnemies.push(new PFlame(2625, 225));

				Mario.instEnemies.push(new PFlame(2250, 225));

				Mario.instEnemies.push(new PFlame(1925, 250));

				Mario.instEnemies.push(new PStatic(3450, 275));

				Mario.instEnemies.push(new PStatic(3525, 250));

				Mario.instEnemies.push(new PStatic(3475, 300));

				Mario.instEnemies.push(new PStatic(3500, 300));

				Mario.instEnemies.push(new PStatic(3625, 175));

				Mario.instEnemies.push(new PStatic(3650, 175));

				Mario.instEnemies.push(new PStatic(3700, 200));

				Mario.instEnemies.push(new PStatic(3675, 200));

				Mario.instEnemies.push(new PStatic(3725, 175));

				Mario.instEnemies.push(new PStatic(3850, 275));

				Mario.instEnemies.push(new PStatic(3875, 275));

				Mario.instEnemies.push(new PStatic(3900, 300));

				Mario.instEnemies.push(new PStatic(3950, 300));

				Mario.instEnemies.push(new PStatic(3925, 300));

				Mario.instEnemies.push(new PStatic(3975, 300));

				Mario.instEnemies.push(new PStatic(4000, 275));

				Mario.instEnemies.push(new PStatic(4025, 250));

				Mario.instEnemies.push(new PStatic(4200, 175));

				Mario.instEnemies.push(new PStatic(4175, 150));

				Mario.instEnemies.push(new PStatic(4225, 200));

				Mario.instEnemies.push(new PStatic(4250, 250));

				Mario.instEnemies.push(new PStatic(4275, 275));

				Mario.instEnemies.push(new PStatic(4350, 275));

				Mario.instEnemies.push(new PStatic(4450, 150));

				Mario.instEnemies.push(new PStatic(4550, 250));

				Mario.instEnemies.push(new PStatic(4575, 250));

				Mario.instEnemies.push(new PStatic(4600, 250));

				Mario.instBlocks.push(new Brick(650, 150));

				Mario.instBlocks.push(new Brick(600, 150));

				Mario.instBlocks.push(new Brick(450, 150));

				Mario.instBlocks.push(new Brick(500, 150));

				Mario.instBlocks.push(new Brick(550, 150));

				Mario.instBlocks.push(new Bonus(475, 150, 1));

				Mario.instBlocks.push(new Bonus(625, 150, 1));

				Mario.instBlocks.push(new Bonus(575, 150, 2));

				Mario.instBlocks.push(new Bonus(525, 150, 3));

				Mario.instBlocks.push(new Bonus(4275, 175, 4, true));

				Mario.instEnemies.push(new Spiny(3125, 300));

				Mario.instEnemies.push(new Spiny(3225, 300));

				Mario.instObjects.push(new Mill(375, 250, 100, 4));

				Mario.instObjects.push(new Mill(725, 250, 100, 4, 8));

				Mario.instEnemies.push(new JumperThrower(300, 350, -10, 0, 100, 1, 0));

				Mario.instEnemies.push(new JumperThrower(875, 350, -10, 1, 160, 4, 10));

				Mario.instEnemies.push(new JumperThrower(1225, 350, -11, 1, 180, 6, 9));

				Mario.instEnemies.push(new JumperThrower(1550, 350, -10, 1, 195, 3, 20));

				Mario.instEnemies.push(new JumperThrower(1775, 350, -6, 2, 35, 1, 0));

				Mario.instEnemies.push(new Bowser(200 * 25, 175, 189 * 25, 5, 15, 0, 0, 0));

				Mario.instEffects.push(new Back(3));

				break;
			case 8:
				Mario.levelGenre = 2;

				Mario.musika = 0;

				Mario.generateBackground(1);

				Mario.level[0] = "                                                                                                                                                                                                                                                                                                                                                                           ";
				Mario.level[1] = "                                                                                                                                                                                                                                                                                                                                                                           ";
				Mario.level[2] = "                                                                                                                                                                                                                                                                                                                                                                           ";
				Mario.level[3] = "                                                                                                                                                                                                                                                                                                                                                                           ";
				Mario.level[4] = "                                                                                                                                                                                                                                                                                                                                                                           ";
				Mario.level[5] = "                                                                                                                            MM   MM   MM                                                                                                                                                                                                                                   ";
				Mario.level[6] = "                                                                                                                            23   23   23                                                                                                                                                                                                                                   ";
				Mario.level[7] = "                                                                                                                            23   23   23                                                                                                                                                                                                                                   ";
				Mario.level[8] = "                                                           01                                                               23   23   23                                 01                              MM                                                 MM                                                                                                             ";
				Mario.level[9] = "                                                           23     01                                                        23   45   23                                 23                              M         MM       MM                MM            M                                                                                                              ";
				Mario.level[10] = "                                    M   M                  23     23                                              01        23        45               01          01    23                         MM   M          M   MM   M           MM   M             M   MM                                                                                                         ";
				Mario.level[11] = "                    01              M   M                  23     23                                 M M          23        45                   01    23          23    23    01                    M   M    MM    M   M    M  MM       M    M   MM        M    M         MM                                                                                              ";
				Mario.level[12] = "                    23              M   M           01     23     23                                 M MM         23             01              23    23    01    23    23    23        MM      MM  M   M MM M     M   M    M   M    MM M    M    M   MM   M    M   MM MM M       MM                                                                                      ";
				Mario.level[13] = "                    23              M   M           23     23     23                                 M MMM        23             23   01         23    23    23    23    23    23    01  M    MM M   M   M M  M     M   M    M   M MM  M M    M    M    M   M MM M   M   M M  MM   M                                                                                       ";
				Mario.level[14] = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxy   wxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxy    wxy    wxy    wxy    M wxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxy    wy    wy    wy    wy    wy    wy  M     M M   M   M M  M     M   M    M   M M   M M    M    M    M   M M  M   M   M M   M   M    wxy       wy    wy  wy     wy  wy     wy wy  wy   wy    wxxxxxxxxxxxxxxxxxxxxxxxxxx";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Player.ResetPlayer(75, 325);

				Mario.layerWall.addChild(AddGraphic(9050, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(9025, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(9000, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8975, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8950, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8925, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8900, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8875, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8850, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8825, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8800, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8775, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8750, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8725, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(8700, 225, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(8700, 250, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(8700, 275, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(8700, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(8700, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(8375, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(8400, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8425, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8450, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(8150, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(8125, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8100, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(7975, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(7950, 275, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(7950, 250, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(7950, 225, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(7975, 275, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(7950, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(7975, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(7950, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(7775, 250, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(7775, 275, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(7775, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(7775, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(7425, 300, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(7425, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(7225, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(7300, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(7275, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(7250, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3400, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(3600, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(3575, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3550, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3525, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3500, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3475, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3450, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3425, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3500, 225, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(3500, 250, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(3500, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(3500, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(3500, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(3400, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(3400, 175, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(3400, 200, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(3400, 225, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(3400, 250, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(3400, 275, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(3400, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(3150, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(3125, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3100, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3075, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3050, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3025, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3000, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2975, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2950, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2925, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2900, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2875, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(2825, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(2650, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2675, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2700, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2725, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2750, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2775, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2800, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2375, 300, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(2375, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2225, 275, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(2225, 250, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(2225, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(2225, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2150, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(2200, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(2175, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1675, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1775, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(1750, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1725, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1700, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1875, 275, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(1875, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1875, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1525, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1625, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(1600, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1575, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1550, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1450, 275, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1450, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(1450, 250, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(1450, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1075, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1150, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(1125, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1100, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1250, 275, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(1250, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1250, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1050, 275, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(1050, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(1050, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1175, 300, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(1175, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(550, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(725, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(700, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(675, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(650, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(625, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(575, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(600, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(125, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(100, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(75, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(50, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(25, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(0, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(300, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(300, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(300, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(300, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(300, 225, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(150, 250, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(150, 225, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(225, 125, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(225, 150, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(225, 175, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(225, 200, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(225, 225, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(225, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(225, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(225, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(225, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(150, 275, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(150, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(150, 325, 'back_tree_1'));

				Mario.instObjects.push(new Coin(8275, 225));

				Mario.instObjects.push(new Coin(8250, 225));

				Mario.instObjects.push(new Coin(8150, 225));

				Mario.instObjects.push(new Coin(8125, 225));

				Mario.instObjects.push(new Coin(8050, 225));

				Mario.instObjects.push(new Coin(8025, 225));

				Mario.instObjects.push(new Coin(7975, 225));

				Mario.instObjects.push(new Coin(7950, 225));

				Mario.instObjects.push(new Coin(7800, 225));

				Mario.instObjects.push(new Coin(7775, 225));

				Mario.instObjects.push(new Coin(7700, 225));

				Mario.instObjects.push(new Coin(7675, 225));

				Mario.instObjects.push(new Coin(7525, 225));

				Mario.instObjects.push(new Coin(7500, 225));

				Mario.instObjects.push(new Coin(7425, 225));

				Mario.instObjects.push(new Coin(7400, 225));

				Mario.instObjects.push(new Coin(7275, 225));

				Mario.instObjects.push(new Coin(7250, 225));

				Mario.instObjects.push(new Coin(7025, 225));

				Mario.instObjects.push(new Coin(6225, 75));

				Mario.instObjects.push(new Coin(6225, 100));

				Mario.instObjects.push(new Coin(6225, 125));

				Mario.instObjects.push(new Coin(6150, 125));

				Mario.instObjects.push(new Coin(6150, 100));

				Mario.instObjects.push(new Coin(6150, 75));

				Mario.instObjects.push(new Coin(6200, 125));

				Mario.instObjects.push(new Coin(6175, 125));

				Mario.instObjects.push(new Coin(6175, 75));

				Mario.instObjects.push(new Coin(6200, 75));

				Mario.instObjects.push(new Coin(6200, 100));

				Mario.instObjects.push(new Coin(6175, 100));

				Mario.instObjects.push(new Coin(6375, 275));

				Mario.instObjects.push(new Coin(6350, 275));

				Mario.instObjects.push(new Coin(5100, 250));

				Mario.instObjects.push(new Coin(5075, 250));

				Mario.instObjects.push(new Coin(4900, 100));

				Mario.instObjects.push(new Coin(4925, 100));

				Mario.instObjects.push(new Coin(4250, 75));

				Mario.instObjects.push(new Coin(4225, 75));

				Mario.instObjects.push(new Coin(3800, 125));

				Mario.instObjects.push(new Coin(3775, 125));

				Mario.instObjects.push(new Coin(3025, 250));

				Mario.instObjects.push(new Coin(2950, 250));

				Mario.instObjects.push(new Coin(2700, 250));

				Mario.instObjects.push(new Coin(2775, 250));

				Mario.instObjects.push(new Coin(2875, 125));

				Mario.instObjects.push(new Coin(2850, 125));

				Mario.instObjects.push(new Coin(2375, 225));

				Mario.instObjects.push(new Coin(2025, 225));

				Mario.instObjects.push(new Coin(2200, 225));

				Mario.instObjects.push(new Coin(1500, 75));

				Mario.instObjects.push(new Coin(1475, 75));

				Mario.instObjects.push(new Coin(1000, 150));

				Mario.instObjects.push(new Coin(1000, 175));

				Mario.instObjects.push(new Coin(900, 175));

				Mario.instObjects.push(new Coin(900, 150));

				Mario.instEnemies.push(new Lakitu(275, 50));

				Mario.instEnemies.push(new PFlame(500, 250));

				Mario.instEnemies.push(new PPlant(1475, 175));

				Mario.instEnemies.push(new PPlant(1300, 275));

				Mario.instEnemies.push(new PPlant(1650, 200));

				Mario.instEnemies.push(new PFlame(2850, 225));

				Mario.instEnemies.push(new PPlant(3225, 275));

				Mario.instEnemies.push(new PPlant(3350, 300));

				Mario.instEnemies.push(new PPlant(3100, 300, -1));

				Mario.instEnemies.push(new PPlant(3225, 250, -1));

				Mario.instEnemies.push(new PPlant(3350, 275, -1));

				Mario.instEnemies.push(new PPlant(3625, 250));

				Mario.instEnemies.push(new PPlant(3925, 275));

				Mario.instEnemies.push(new PPlant(4225, 175));

				Mario.instEnemies.push(new PPlant(4525, 300));

				Mario.instEnemies.push(new Spiny(450, 325));

				Mario.instEnemies.push(new Spiny(850, 325));

				Mario.instEnemies.push(new Goomba(650, 325));

				Mario.instEnemies.push(new Goomba(700, 325));

				Mario.instEnemies.push(new FlyRed(950, 100));

				Mario.instObjects.push(new Finish(8500, 325));

				Mario.instBlocks.push(new Bonus(6325, 250, 4, true));

				Mario.instBlocks.push(new Brick(900, 100));

				Mario.instBlocks.push(new Brick(1000, 100));

				Mario.instBlocks.push(new Bonus(1525, 275, 2, true));

				Mario.instBlocks.push(new Bonus(3400, 225, 2, true));

				Mario.instBlocks.push(new Bonus(225, 225, 1, true));

				Mario.instBlocks.push(new Bonus(225, 125, 1, true));

				Mario.instBlocks.push(new Bonus(300, 225, 1, true));

				Mario.instBlocks.push(new Bonus(150, 225, 1, true));

				Mario.instEffects.push(new Back(5));
				break;

			case 9:
				Mario.levelGenre = 1;

				Mario.musika = 1;

				Mario.level[0] = "                                                                                                                                                                                                                                                                                                                                                                                         ";
				Mario.level[1] = "N        NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN                                                         NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN";
				Mario.level[2] = "N                                                                                                                                              23                         23                                                                                                   NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN                               ";
				Mario.level[3] = "N                                                                                                                                              45                         45                                                                                                   NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN                               ";
				Mario.level[4] = "N                                                                                                                                                                                                                                                             01               NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN                               ";
				Mario.level[5] = "N                                                  01                                                                                                                                                                                                         23               NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN                               ";
				Mario.level[6] = "N                                                  23                                                                                                                                                                                                         23                45                  23              45             45                45                                  ";
				Mario.level[7] = "N                                                  23                                                                                                                                                                                                         23                                    45                                                                                   ";
				Mario.level[8] = "N                                                  23                                                                                                                                                                                                     6777NN7778                                                                                                                     ";
				Mario.level[9] = "N                            01    01              23                                                                                                                                                                                                     9aaaNNaaab            01                                                                                                       ";
				Mario.level[10] = "N                            23    23              23           qrrrs                            qrrrs               qrs                                                                                                                                      23               NrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrN                               ";
				Mario.level[11] = "N                            23    23              23           tuuuv                            tuuuv               tuvqrs                                  01                                                                                               23               NuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuN                               ";
				Mario.level[12] = "N                            NN    NN       01     23     01    NNNNN                            NNNNN               tuvtuvqrs                               23                               NNN                                                             23               NuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuN                               ";
				Mario.level[13] = "N                                           23     23     23                                                         tuvtuvtuvqrs                            23                               NNN                                                             23               NuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuN                               ";
				Mario.level[14] = "qrrrrrrrrrrrrs         qs   qrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrs                                                         tuvtuvtuvtuvqrs N N N N N N N N N N N N qrrrrrrrrs        qrrrrrrrrrrrrrrrrrrrrrrrrrrrs  qs  qs  qs  qs  qs  qs  qs  qrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrNuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Player.ResetPlayer(125, 25);

				Mario.instObjects.push(new Coin(8450, 150));

				Mario.instObjects.push(new Coin(8475, 150));

				Mario.instObjects.push(new Coin(8625, 150));

				Mario.instObjects.push(new Coin(8600, 150));

				Mario.instObjects.push(new Coin(8175, 150));

				Mario.instObjects.push(new Coin(8150, 150));

				Mario.instObjects.push(new Coin(8000, 150));

				Mario.instObjects.push(new Coin(8025, 150));

				Mario.instObjects.push(new Coin(7800, 150));

				Mario.instObjects.push(new Coin(7775, 150));

				Mario.instObjects.push(new Coin(7625, 150));

				Mario.instObjects.push(new Coin(7650, 150));

				Mario.instObjects.push(new Coin(7250, 150));

				Mario.instObjects.push(new Coin(7225, 150));

				Mario.instObjects.push(new Coin(7400, 150));

				Mario.instObjects.push(new Coin(7375, 150));

				Mario.instObjects.push(new Coin(7325, 200));

				Mario.instObjects.push(new Coin(7300, 200));

				Mario.instObjects.push(new Coin(8550, 175));

				Mario.instObjects.push(new Coin(8525, 175));

				Mario.instObjects.push(new Coin(8100, 175));

				Mario.instObjects.push(new Coin(8075, 175));

				Mario.instObjects.push(new Coin(7725, 175));

				Mario.instObjects.push(new Coin(7700, 175));

				Mario.instObjects.push(new Coin(6575, 175));

				Mario.instObjects.push(new Coin(6150, 175));

				Mario.instObjects.push(new Coin(5625, 250));

				Mario.instObjects.push(new Coin(5600, 250));

				Mario.instObjects.push(new Coin(5325, 250));

				Mario.instObjects.push(new Coin(5300, 250));

				Mario.instObjects.push(new Coin(4775, 200));

				Mario.instObjects.push(new Coin(4300, 200));

				Mario.instObjects.push(new Coin(4275, 200));

				Mario.instObjects.push(new Coin(4225, 200));

				Mario.instObjects.push(new Coin(4250, 200));

				Mario.instObjects.push(new Coin(4350, 250));

				Mario.instObjects.push(new Coin(4325, 225));

				Mario.instObjects.push(new Coin(4200, 225));

				Mario.instObjects.push(new Coin(4175, 250));

				Mario.instObjects.push(new Coin(3625, 250));

				Mario.instObjects.push(new Coin(3600, 250));

				Mario.instObjects.push(new Coin(3575, 250));

				Mario.instObjects.push(new Coin(3550, 250));

				Mario.instObjects.push(new Coin(3250, 300));

				Mario.instObjects.push(new Coin(3175, 275));

				Mario.instObjects.push(new Coin(3100, 250));

				Mario.instObjects.push(new Coin(3025, 225));

				Mario.instObjects.push(new Coin(2950, 200));

				Mario.instObjects.push(new Coin(2700, 100));

				Mario.instObjects.push(new Coin(2750, 150));

				Mario.instObjects.push(new Coin(2700, 200));

				Mario.instObjects.push(new Coin(2100, 325));

				Mario.instObjects.push(new Coin(2125, 225));

				Mario.instObjects.push(new Coin(2100, 125));

				Mario.instObjects.push(new Coin(2125, 25));

				Mario.instObjects.push(new Coin(1850, 0));

				Mario.instObjects.push(new Coin(1875, 100));

				Mario.instObjects.push(new Coin(1850, 200));

				Mario.instObjects.push(new Coin(1875, 300));

				Mario.instObjects.push(new Coin(2475, 125));

				Mario.instObjects.push(new Coin(2475, 150));

				Mario.instObjects.push(new Coin(2475, 175));

				Mario.instObjects.push(new Coin(1650, 175));

				Mario.instObjects.push(new Coin(1650, 125));

				Mario.instObjects.push(new Coin(1650, 150));

				Mario.instObjects.push(new Coin(1350, 150));

				Mario.instObjects.push(new Coin(1350, 125));

				Mario.instObjects.push(new Coin(1225, 150));

				Mario.instObjects.push(new Coin(1225, 125));

				Mario.instObjects.push(new Coin(775, 300));

				Mario.instObjects.push(new Coin(800, 300));

				Mario.instObjects.push(new Coin(825, 300));

				Mario.instObjects.push(new Coin(850, 300));

				Mario.instObjects.push(new Coin(850, 275));

				Mario.instObjects.push(new Coin(825, 275));

				Mario.instObjects.push(new Coin(800, 275));

				Mario.instObjects.push(new Coin(775, 275));

				Mario.instObjects.push(new Coin(150, 250));

				Mario.instObjects.push(new Coin(125, 250));

				Mario.instObjects.push(new Coin(100, 250));

				Mario.instObjects.push(new ElevatorLoop(1850, 150, 50, 'elevator_2', 2));

				Mario.instObjects.push(new ElevatorLoop(1850, 350, 50, 'elevator_2', 2));

				Mario.instObjects.push(new ElevatorLoop(2100, 250, 50, 'elevator_2', -2));

				Mario.instObjects.push(new ElevatorLoop(2100, 50, 50, 'elevator_2', -2));

				Mario.instObjects.push(new ElevatorFall(2700, 250, 25, 'elevator_1'));

				Mario.instObjects.push(new ElevatorFall(2750, 250, 25, 'elevator_1'));

				Mario.instObjects.push(new Cannon(5050, 325));

				Mario.instObjects.push(new Cannon(5875, 325));

				Mario.instEnemies.push(new PStatic(3000, 0));

				Mario.instEnemies.push(new PStatic(3050, 0));

				Mario.instEnemies.push(new PStatic(3100, 0));

				Mario.instEnemies.push(new PStatic(3150, 0));

				Mario.instEnemies.push(new PStatic(3200, 0));

				Mario.instEnemies.push(new PStatic(3250, 0));

				Mario.instEnemies.push(new PFlame(725, 200));

				Mario.instEnemies.push(new PFlame(875, 200));

				Mario.instEnemies.push(new PPlant(1100, 275));

				Mario.instEnemies.push(new PPlant(1450, 275));

				Mario.instEnemies.push(new PPlant(1275, 100));

				Mario.instEnemies.push(new Spiny(1200, 325));

				Mario.instEnemies.push(new Spiny(1375, 325));

				Mario.instBlocks.push(new Brick(1250, 200));

				Mario.instBlocks.push(new Brick(1225, 200));

				Mario.instBlocks.push(new Brick(1200, 200));

				Mario.instBlocks.push(new Brick(1350, 200));

				Mario.instBlocks.push(new Brick(1375, 200));

				Mario.instBlocks.push(new Bonus(1250, 275, 2, true));

				Mario.instBlocks.push(new Bonus(1325, 275, 4, true));

				Mario.instBlocks.push(new BrickMulti(1250, 200));

				Mario.instBlocks.push(new BrickMulti(1325, 200));

				Mario.instBlocks.push(new Brick(775, 250));

				Mario.instBlocks.push(new Brick(800, 250));

				Mario.instBlocks.push(new Brick(825, 250));

				Mario.instBlocks.push(new Brick(850, 250));

				Mario.instBlocks.push(new Bonus(775, 225, 1, true));

				Mario.instBlocks.push(new Bonus(825, 225, 1, true));

				Mario.instBlocks.push(new Bonus(850, 225, 1, true));

				Mario.instBlocks.push(new Bonus(800, 225, 3, true));

				Mario.instEnemies.push(new TroopaRed(2475, 225));

				Mario.instEnemies.push(new FlyRed(2625, 150));

				Mario.instEnemies.push(new FlyRed(2000, 150));

				Mario.instObjects.push(new ElevatorFall(2725, 250, 25, 'elevator_1'));

				Mario.instEnemies.push(new FlyRed(2850, 200));

				Mario.instEnemies.push(new PFlame(3575, 100, -1));

				Mario.instEnemies.push(new PFlame(4250, 100, -1));

				Mario.instEnemies.push(new PPlant(3925, 250));

				Mario.instEnemies.push(new FlyGreen(3875, 300));

				Mario.instEnemies.push(new FlyGreen(3825, 300));

				Mario.instEnemies.push(new FlyGreen(3775, 300));

				Mario.instEnemies.push(new FlyGreen(4775, 250));

				Mario.instEnemies.push(new Spiny(4700, 325));

				Mario.instEnemies.push(new Spiny(4650, 325));

				Mario.instEnemies.push(new Spiny(4600, 325));

				Mario.instEnemies.push(new Goomba(4550, 325));

				Mario.instEnemies.push(new FlyGreen(5650, 325));

				Mario.instEnemies.push(new FlyGreen(5550, 325));

				Mario.instEnemies.push(new Goomba(6350, 75));

				Mario.instEnemies.push(new Spiny(6300, 175));

				Mario.instEnemies.push(new Spiny(6250, 175));

				Mario.instEnemies.push(new BBeetle(6325, 325));

				Mario.instBlocks.push(new Bonus(6325, 275, 1, true));

				Mario.instBlocks.push(new Bonus(6300, 275, 1, true));

				Mario.instBlocks.push(new Bonus(6275, 275, 1, true));

				Mario.instBlocks.push(new Bonus(6250, 275, 1, true));

				Mario.instBlocks.push(new Bonus(6425, 275, 1, true));

				Mario.instBlocks.push(new Bonus(6400, 275, 1, true));

				Mario.instBlocks.push(new Bonus(6450, 275, 1, true));

				Mario.instBlocks.push(new Bonus(6475, 275, 1, true));

				Mario.instBlocks.push(new Bonus(6175, 225, 0));

				Mario.instBlocks.push(new Bonus(6150, 225, 1));

				Mario.instBlocks.push(new Bonus(6125, 225, 1));

				Mario.instBlocks.push(new Bonus(6550, 225, 1));

				Mario.instBlocks.push(new Bonus(6600, 225, 1));

				Mario.instEnemies.push(new Goomba(300, 325));

				Mario.instEnemies.push(new Goomba(275, 325));

				Mario.instEnemies.push(new Goomba(250, 325));

				Mario.instEnemies.push(new TroopaRed(1650, 225));

				Mario.instEnemies.push(new Spiny(6425, 175));

				Mario.instEnemies.push(new Spiny(6475, 175));

				Mario.instEnemies.push(new Goomba(6375, 75));

				Mario.instEnemies.push(new BBeetle(6400, 325));

				Mario.instEnemies.push(new PFlame(8525, 175, -1));

				Mario.instEnemies.push(new PFlame(8075, 175, -1));

				Mario.instEnemies.push(new PFlame(7700, 175, -1));

				Mario.instEnemies.push(new PPlant(7300, 200, -1));

				Mario.instEnemies.push(new PPlant(6800, 175, -1));

				Mario.instEnemies.push(new PPlant(6800, 200));

				Mario.instEnemies.push(new Goomba(7000, 225));

				Mario.instEnemies.push(new Goomba(7050, 225));

				Mario.instEnemies.push(new Goomba(7100, 225));

				Mario.instEnemies.push(new Spiny(7150, 225));

				Mario.instEnemies.push(new Spiny(7200, 225));

				Mario.instEnemies.push(new FlyGreen(7350, 225));

				Mario.instEnemies.push(new Spiny(7900, 225));

				Mario.instEnemies.push(new Spiny(7950, 225));

				Mario.instEnemies.push(new BBeetle(7850, 225));

				Mario.instEnemies.push(new Goomba(7625, 225));

				Mario.instEnemies.push(new Goomba(7675, 225));

				Mario.instEnemies.push(new Goomba(7725, 225));

				Mario.instEnemies.push(new Goomba(8300, 225));

				Mario.instEnemies.push(new Goomba(8400, 225));

				Mario.instEnemies.push(new Spiny(8350, 225));

				Mario.instEnemies.push(new Spiny(8450, 225));

				Mario.instEnemies.push(new Goomba(8500, 225));

				Mario.instObjects.push(new Finish(8850, 325));

				Mario.instBlocks.push(new Bonus(6575, 225, 3));

				Mario.instEffects.push(new Back(1));

				break;

			case 10:
				Mario.levelGenre = 2;

				Mario.musika = 0;

				Mario.generateBackground(1);

				Mario.level[0] = "                                                                                                                                                                                                                            MM    MM  MM                                                       ";
				Mario.level[1] = "                                                           MM                                        MM                                                                                                                     23    23  23                                                       ";
				Mario.level[2] = "                                                           23                                        23                                                                                                                     23    23  45                                                       ";
				Mario.level[3] = "                                            01             23                                        23                                                                                                                     23    23                                                           ";
				Mario.level[4] = "                                            23             45                                        23                                                                                                                     23    23                                                           ";
				Mario.level[5] = "                                            23  01                                                   23                  MMQQQQQQQQQQQQQQQQQQMM                                                                             23    45      01QQQQQQQQQQQQQQQQQQQQQQQM                           ";
				Mario.level[6] = "                                            23  23                                                   23                  MM                  MM                                                     M M M M M M M M M M M M 23            23                                                   ";
				Mario.level[7] = "                                            MM77MM78                                                 23                  MM                  MM    MM                                            MM                         23        01  23                                                   ";
				Mario.level[8] = "                                            MMaaMMab                                                 23              MM  MM                  MM    MM                                            MM                         23        45  23                                                   ";
				Mario.level[9] = "                                            23  23                                              S    23              MM  MM                  MM                                                                             45    01      23                                                   ";
				Mario.level[10] = "                                            23  23                                              R    45              MM  MM                  MM                                         01         M M M M M M M M M M M M M      45      23                                                   ";
				Mario.level[11] = "                                            23  45                                    wxxy      R                MM  MM  MM                  MM         01                   01         23                                                23                                                   ";
				Mario.level[12] = "                                            23         S   01                         MMMM      R                MM  MM  MM                  MM         23        01         23         23                                            01  23                                                   ";
				Mario.level[13] = "                                            23         R   23                                   R                MM  MM  MM                  MM         23        23         23         23                                            23  23                                                   ";
				Mario.level[14] = "wxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxy  23             wxxxxxxxy             M    wxxxxxxxxxy wy  wy  wy                  wy         wy        wy         wy         wy         wxxxxxxxxxxxxxxxxxxxxxxxy  wxy wy  23  23                   wxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Player.ResetPlayer(150, 325);

				Mario.layerWall.addChild(AddGraphic(7075, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(6925, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(7000, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(7175, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(7150, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(7125, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(7100, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6975, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6950, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(7025, 225, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(7025, 250, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(7025, 275, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(7025, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(7025, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(6775, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(6350, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(6550, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6750, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6725, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6700, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6675, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6650, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6525, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6625, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6600, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6575, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6500, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6475, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6450, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6425, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6400, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6375, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5675, 300, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(5675, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5325, 175, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(5325, 200, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(5325, 225, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(5325, 275, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(5325, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(5325, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5350, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(5150, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(4850, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(5000, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(5300, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(5400, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(5375, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5275, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5250, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5225, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5200, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5175, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4975, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4950, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4875, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4925, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4900, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2625, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(2775, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2800, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(2750, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2725, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2700, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2675, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2650, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2550, 275, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(2550, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(2550, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2225, 225, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(2225, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2075, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(2050, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2025, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2000, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1975, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1950, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1250, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1275, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1300, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1325, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1350, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1075, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(950, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(975, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1000, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1025, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1050, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(875, 275, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(825, 250, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(825, 275, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(825, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(875, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(875, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(825, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(575, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(400, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(550, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(525, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(500, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(475, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(450, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(425, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(450, 200, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(450, 225, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(450, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(450, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(450, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(450, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(400, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(400, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(400, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(400, 125, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(400, 150, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(400, 175, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(400, 200, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(400, 225, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(400, 100, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(400, 250, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(300, 150, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(300, 175, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(300, 200, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(300, 225, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(300, 250, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(300, 275, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(300, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(300, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(275, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(250, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(225, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(200, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(175, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(150, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(125, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(100, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(75, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(50, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(25, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(0, 325, 'back_fence_2'));

				Mario.instObjects.push(new Coin(6400, 50));

				Mario.instObjects.push(new Coin(6325, 50));

				Mario.instObjects.push(new Coin(6250, 50));

				Mario.instObjects.push(new Coin(6175, 50));

				Mario.instObjects.push(new Coin(6100, 50));

				Mario.instObjects.push(new Coin(6025, 50));

				Mario.instObjects.push(new Coin(5950, 50));

				Mario.instObjects.push(new Coin(5825, 125));

				Mario.instObjects.push(new Coin(5725, 100));

				Mario.instObjects.push(new Coin(5700, 100));

				Mario.instObjects.push(new Coin(5725, 75));

				Mario.instObjects.push(new Coin(5700, 75));

				Mario.instObjects.push(new Coin(5725, 300));

				Mario.instObjects.push(new Coin(5700, 250));

				Mario.instObjects.push(new Coin(5725, 200));

				Mario.instObjects.push(new Coin(5700, 50));

				Mario.instObjects.push(new Coin(5725, 50));

				Mario.instObjects.push(new Coin(5375, 50));

				Mario.instObjects.push(new Coin(5275, 50));

				Mario.instObjects.push(new Coin(5175, 50));

				Mario.instObjects.push(new Coin(5075, 50));

				Mario.instObjects.push(new Coin(4975, 50));

				Mario.instObjects.push(new Coin(4900, 250));

				Mario.instObjects.push(new Coin(5050, 250));

				Mario.instObjects.push(new Coin(5400, 250));

				Mario.instObjects.push(new Coin(5375, 150));

				Mario.instObjects.push(new Coin(5275, 150));

				Mario.instObjects.push(new Coin(5200, 250));

				Mario.instObjects.push(new Coin(5025, 150));

				Mario.instObjects.push(new Coin(4675, 100));

				Mario.instObjects.push(new Coin(4675, 75));

				Mario.instObjects.push(new Coin(4675, 50));

				Mario.instObjects.push(new Coin(4550, 50));

				Mario.instObjects.push(new Coin(4550, 75));

				Mario.instObjects.push(new Coin(4550, 100));

				Mario.instObjects.push(new Coin(4400, 50));

				Mario.instObjects.push(new Coin(4400, 75));

				Mario.instObjects.push(new Coin(4400, 100));

				Mario.instObjects.push(new Coin(4275, 100));

				Mario.instObjects.push(new Coin(4275, 75));

				Mario.instObjects.push(new Coin(4275, 50));

				Mario.instObjects.push(new Coin(4125, 50));

				Mario.instObjects.push(new Coin(4125, 75));

				Mario.instObjects.push(new Coin(4125, 100));

				Mario.instObjects.push(new Coin(4000, 100));

				Mario.instObjects.push(new Coin(4000, 75));

				Mario.instObjects.push(new Coin(4000, 50));

				Mario.instObjects.push(new Coin(3875, 50));

				Mario.instObjects.push(new Coin(3875, 100));

				Mario.instObjects.push(new Coin(3750, 50));

				Mario.instObjects.push(new Coin(3750, 100));

				Mario.instObjects.push(new Coin(3750, 75));

				Mario.instObjects.push(new Coin(3875, 75));

				Mario.instObjects.push(new Coin(2675, 225));

				Mario.instObjects.push(new Coin(2675, 250));

				Mario.instObjects.push(new Coin(2750, 225));

				Mario.instObjects.push(new Coin(2750, 250));

				Mario.instObjects.push(new Coin(2600, 225));

				Mario.instObjects.push(new Coin(2600, 250));

				Mario.instObjects.push(new Coin(3125, 50));

				Mario.instObjects.push(new Coin(3225, 50));

				Mario.instObjects.push(new Coin(3325, 50));

				Mario.instObjects.push(new Coin(3425, 50));

				Mario.instObjects.push(new Coin(3525, 50));

				Mario.instObjects.push(new Coin(2400, 125));

				Mario.instObjects.push(new Coin(2400, 150));

				Mario.instObjects.push(new Coin(2400, 75));

				Mario.instObjects.push(new Coin(2400, 100));

				Mario.instObjects.push(new Coin(2025, 150));

				Mario.instObjects.push(new Coin(1975, 150));

				Mario.instObjects.push(new Coin(1925, 150));

				Mario.instObjects.push(new Coin(1875, 150));

				Mario.instObjects.push(new Coin(925, 100));

				Mario.instObjects.push(new Coin(825, 100));

				Mario.instObjects.push(new Coin(825, 200));

				Mario.instObjects.push(new Coin(925, 200));

				Mario.instEnemies.push(new HammerTroopa(875, 225));

				Mario.instBlocks.push(new Brick(875, 250));

				Mario.instBlocks.push(new Brick(900, 250));

				Mario.instBlocks.push(new Brick(925, 250));

				Mario.instBlocks.push(new Brick(850, 250));

				Mario.instBlocks.push(new Brick(825, 250));

				Mario.instBlocks.push(new Brick(800, 250));

				Mario.instBlocks.push(new Brick(825, 150));

				Mario.instBlocks.push(new Brick(850, 150));

				Mario.instBlocks.push(new Brick(875, 150));

				Mario.instBlocks.push(new Brick(900, 150));

				Mario.instBlocks.push(new Brick(925, 150));

				Mario.instBlocks.push(new Brick(950, 150));

				Mario.instEnemies.push(new HammerTroopa(875, 125));

				Mario.instEnemies.push(new PFlame(1200, 100));

				Mario.instEnemies.push(new PPlant(1100, 50));

				Mario.instEnemies.push(new PPlant(1200, 300, -1));

				Mario.instBlocks.push(new Bonus(1175, 275, 4, true));

				Mario.instBlocks.push(new Bonus(1150, 275, 3, true));

				Mario.instBlocks.push(new BrickMulti(950, 250));

				Mario.instBlocks.push(new BrickMulti(800, 150));

				Mario.instBlocks.push(new Bonus(775, 150, 1));

				Mario.instBlocks.push(new Bonus(775, 250, 1));

				Mario.instBlocks.push(new Bonus(975, 250, 1));

				Mario.instBlocks.push(new Bonus(975, 150, 1));

				Mario.instBlocks.push(new Bonus(400, 250, 1, true));

				Mario.instBlocks.push(new Bonus(400, 150, 1, true));

				Mario.instBlocks.push(new Bonus(400, 50, 1, true));

				Mario.instBlocks.push(new Bonus(300, 50, 1, true));

				Mario.instBlocks.push(new Bonus(300, 150, 1, true));

				Mario.instBlocks.push(new Bonus(300, 250, 1, true));

				Mario.instBlocks.push(new Bonus(500, 50, 1, true));

				Mario.instBlocks.push(new Bonus(500, 150, 1, true));

				Mario.instBlocks.push(new Bonus(500, 250, 1, true));

				Mario.instBlocks.push(new Bonus(450, 100, 1, true));

				Mario.instBlocks.push(new Bonus(450, 200, 1, true));

				Mario.instBlocks.push(new Bonus(350, 200, 1, true));

				Mario.instBlocks.push(new Bonus(350, 100, 1, true));

				Mario.instEnemies.push(new PPlant(1475, 275));

				Mario.instObjects.push(new Cannon(1375, 275));

				Mario.instObjects.push(new ElevatorFall(1650, 300, 75, 'elevator_3'));

				Mario.instEnemies.push(new HammerTroopa(1950, 325));

				Mario.instEnemies.push(new FlyRed(1675, 125));

				Mario.instEnemies.push(new TroopaRed(2150, 250));

				Mario.instEnemies.push(new TroopaRed(2225, 250));

				Mario.instEnemies.push(new Spiny(2200, 250));

				Mario.instEnemies.push(new Spiny(2175, 250));

				Mario.instEnemies.push(new PStatic(2400, 175));

				Mario.instObjects.push(new Cannon(2400, 200));

				Mario.instObjects.push(new ElevatorFall(2325, 225, 50, 'elevator_2'));

				Mario.instObjects.push(new ElevatorFall(2450, 225, 50, 'elevator_2'));

				Mario.instEnemies.push(new Goomba(2725, 325));

				Mario.instEnemies.push(new Goomba(2750, 325));

				Mario.instEnemies.push(new Spiny(2700, 325));

				Mario.instBlocks.push(new Brick(1875, 250));

				Mario.instBlocks.push(new Brick(1900, 250));

				Mario.instBlocks.push(new Brick(1925, 250));

				Mario.instBlocks.push(new Brick(1975, 250));

				Mario.instBlocks.push(new Brick(2000, 250));

				Mario.instBlocks.push(new Brick(2025, 250));

				Mario.instBlocks.push(new BrickMulti(1950, 250));

				Mario.instBlocks.push(new Bonus(1150, 75, 2, true));

				Mario.instEnemies.push(new PStatic(3100, 100));

				Mario.instEnemies.push(new PStatic(3075, 100));

				Mario.instEnemies.push(new PStatic(3175, 100));

				Mario.instEnemies.push(new PStatic(3200, 100));

				Mario.instEnemies.push(new PStatic(3275, 100));

				Mario.instEnemies.push(new PStatic(3300, 100));

				Mario.instEnemies.push(new PStatic(3375, 100));

				Mario.instEnemies.push(new PStatic(3400, 100));

				Mario.instEnemies.push(new PStatic(3475, 100));

				Mario.instEnemies.push(new PStatic(3500, 100));

				Mario.instEnemies.push(new Spiny(3150, 100));

				Mario.instEnemies.push(new Spiny(3250, 100));

				Mario.instEnemies.push(new Spiny(3350, 100));

				Mario.instEnemies.push(new Spiny(3450, 100));

				Mario.instEnemies.push(new Spiny(3550, 100));

				Mario.instEnemies.push(new FlyGreen(3050, 100));

				Mario.instBlocks.push(new Bonus(0, 250, 3, true));

				Mario.instBlocks.push(new Bonus(0, 150, 3, true));

				Mario.instBlocks.push(new Bonus(0, 50, 3, true));

				Mario.instObjects.push(new Elevator(3725, 175, 100, 'elevator_4'));

				Mario.instObjects.push(new Elevator(3825, 175, 100, 'elevator_4'));

				Mario.instObjects.push(new Elevator(3925, 175, 100, 'elevator_4'));

				Mario.instObjects.push(new Elevator(4025, 175, 100, 'elevator_4'));

				Mario.instObjects.push(new Elevator(4125, 175, 100, 'elevator_4'));

				Mario.instObjects.push(new Elevator(4225, 175, 100, 'elevator_4'));

				Mario.instObjects.push(new Elevator(4325, 175, 100, 'elevator_4'));

				Mario.instObjects.push(new Elevator(4425, 175, 100, 'elevator_4'));

				Mario.instObjects.push(new Elevator(4525, 175, 100, 'elevator_4'));

				Mario.instObjects.push(new Elevator(4625, 175, 100, 'elevator_4'));

				Mario.instObjects.push(new Elevator(4725, 175, 100, 'elevator_4'));

				Mario.instEnemies.push(new PFlame(3800, 250));

				Mario.instEnemies.push(new PFlame(4050, 275));

				Mario.instEnemies.push(new PFlame(4325, 250));

				Mario.instEnemies.push(new PFlame(4600, 225));

				Mario.instEnemies.push(new HammerTroopa(5100, 125));

				Mario.instEnemies.push(new HammerTroopa(5275, 225));

				Mario.instEnemies.push(new PPlant(5500, 250, -1));

				Mario.instEnemies.push(new PPlant(5750, 75, -1));

				Mario.instEnemies.push(new PPlant(5750, 225, -1));

				Mario.instEnemies.push(new PPlant(5650, 150, -1));

				Mario.instEnemies.push(new PPlant(5650, 200));

				Mario.instEnemies.push(new PPlant(5750, 150));

				Mario.instEnemies.push(new PPlant(5750, 275));

				Mario.instEnemies.push(new PPlant(5850, 100));

				Mario.instEnemies.push(new PPlant(5650, 275, -1));

				Mario.instBlocks.push(new Bonus(5625, 125, 5));

				Mario.instObjects.push(new Finish(6650, 325));

				Mario.instEnemies.push(new Spiny(6325, 100));

				Mario.instEnemies.push(new Spiny(6200, 100));

				Mario.instEnemies.push(new Spiny(6075, 100));

				Mario.instEnemies.push(new Goomba(6125, 100));

				Mario.instEnemies.push(new Goomba(6250, 100));

				Mario.instEnemies.push(new Goomba(6375, 100));

				Mario.instEnemies.push(new FlyGreen(6150, 100));

				Mario.instEnemies.push(new FlyGreen(6275, 100));

				Mario.instEnemies.push(new FlyGreen(6400, 100));

				Mario.instObjects.push(new Cannon(6475, 100));

				Mario.instEnemies.push(new Goomba(2775, 325));

				Mario.instEffects.push(new Back(5));

				break;

			case 11:
				Mario.levelGenre = 3;

				Mario.musika = 2;

				Mario.level[0] = "ABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABAx";
				Mario.level[1] = "                                               AB                              ABABAB                                                                                                                                                                        x";
				Mario.level[2] = "                                                                                 CAB                                                                                                                                                                         x";
				Mario.level[3] = "                                                                                 AB                                                                                                                                                                          x";
				Mario.level[4] = "                                                                                  D                     EFG                                                                                                                                                  x";
				Mario.level[5] = "                                                                                                       EKILG                                                                                                                                                 x";
				Mario.level[6] = "                                        EFG                          EFG                              EKIIILG                                                                                                                                                x";
				Mario.level[7] = "                                       EKILG                        EKILG                EFG         EKIIIIILG                                  EG                                                                                                           x";
				Mario.level[8] = "FFG               EG                  EKIIILG                     EFKIIILG              EKILG       EKIIIIIIILG                               EFKJ                                                                         EFFFG        EFFFG                x";
				Mario.level[9] = "IILG             EKLG                EKIIIIILFFFG                EKIIIIIILG            EKIIILG     EKIIIIIIIIILG                              HIIJ                                                                         HIIIJ        HIIIJ                x";
				Mario.level[10] = "IIILG           EKIILG            EFFKIIIIIIIIIILG             EFIIIIIIIIIJ            HIIIIILG   EKIIIIIIIIIIILG                            EKIIJ              EG                                                        EKIIILG       HIIIJOOOOOOOOOOOOOOOOx";
				Mario.level[11] = "IIIILG         EKIIIILG          EKIIIIIIIIIIIIIILG           EKIIIIIIIIIIJ            HIIIIIILFFFKIIIIIIIIIIIIILFFFFG                EFFFFFFKIIIJ              HJ                                                      EFKIIIIIJ       HIIIJ                x";
				Mario.level[12] = "IIIIILG       EKIIIIIILG        EKIIIIIIIIIIIIIIIILG         EKIIIIIIIIIIILG          EKIIIIIIIIIIIIIIIIIIIIIIIIIIIIILG               HIIIIIIIIIIJ              HLG                                                     HIIIIIIILG      HIIIJ                x";
				Mario.level[13] = "IIIIIILG     EKIIIIIIIILG      EKIIIIIIIIIIIIIIIIIILG       EKIIIIIIIIIIIIILG        EKIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIILFFFFFFFFFG     HIIIIIIIIIIJ  EG          HIJ                                                     HIIIIIIIILFFG   HIIIJ                x";
				Mario.level[14] = "IIIIIIILFFFFFKIIIIIIIIIILFFFFFFKIIIIIIIIIIIIIIIIIIIILFFFFFFFKIIIIIIIIIIIIIIILFFFFFFFFKIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIJ     HIIIIIIIIIIJ  HJ    EG    HIJUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUHIIIIIIIIIIILFFFKIIIJ                x";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Player.ResetPlayer(Mario.checkPoint == 11 ? 235 * 25 : 25, 175);

				Mario.instObjects.push(new Coin(2025, 225));

				Mario.instObjects.push(new Coin(2000, 225));

				Mario.instObjects.push(new Coin(5075, 175));

				Mario.instObjects.push(new Coin(5100, 175));

				Mario.instObjects.push(new Coin(5125, 175));

				Mario.instObjects.push(new Coin(5150, 250));

				Mario.instObjects.push(new Coin(5050, 250));

				Mario.instObjects.push(new Coin(4225, 250));

				Mario.instObjects.push(new Coin(4325, 250));

				Mario.instObjects.push(new Coin(4725, 250));

				Mario.instObjects.push(new Coin(4625, 250));

				Mario.instObjects.push(new Coin(4700, 175));

				Mario.instObjects.push(new Coin(4675, 175));

				Mario.instObjects.push(new Coin(4650, 175));

				Mario.instObjects.push(new Coin(4300, 175));

				Mario.instObjects.push(new Coin(4250, 175));

				Mario.instObjects.push(new Coin(4275, 175));

				Mario.instObjects.push(new Coin(3700, 225));

				Mario.instObjects.push(new Coin(3700, 250));

				Mario.instObjects.push(new Coin(3725, 250));

				Mario.instObjects.push(new Coin(3725, 225));

				Mario.instObjects.push(new Coin(3875, 250));

				Mario.instObjects.push(new Coin(3850, 275));

				Mario.instObjects.push(new Coin(3850, 250));

				Mario.instObjects.push(new Coin(3875, 275));

				Mario.instObjects.push(new Coin(2350, 225));

				Mario.instObjects.push(new Coin(2325, 200));

				Mario.instObjects.push(new Coin(1150, 175));

				Mario.instObjects.push(new Coin(1125, 175));

				Mario.instObjects.push(new Coin(1150, 200));

				Mario.instObjects.push(new Coin(1850, 200));

				Mario.instObjects.push(new Coin(1825, 175));

				Mario.instObjects.push(new Coin(1425, 250));

				Mario.instObjects.push(new Coin(1375, 250));

				Mario.instObjects.push(new Coin(850, 150));

				Mario.instObjects.push(new Coin(900, 150));

				Mario.instObjects.push(new Coin(725, 275));

				Mario.instObjects.push(new Coin(650, 275));

				Mario.instObjects.push(new Coin(275, 275));

				Mario.instObjects.push(new Coin(225, 275));

				Mario.instEnemies.push(new Spiny(450, 175));

				Mario.instEnemies.push(new Spiny(375, 250));

				Mario.instEnemies.push(new Spiny(800, 275));

				Mario.instEnemies.push(new Spiny(1000, 125));

				Mario.instEnemies.push(new Spiny(1525, 275));

				Mario.instEnemies.push(new Spiny(1650, 175));

				Mario.instEnemies.push(new Spiny(2250, 150));

				Mario.instEnemies.push(new Spiny(2150, 275));

				Mario.instEnemies.push(new Spiny(2450, 225));

				Mario.instEnemies.push(new Spiny(2575, 100));

				Mario.instEnemies.push(new PStatic(150, 275));

				Mario.instEnemies.push(new PStatic(300, 325));

				Mario.instEnemies.push(new PStatic(500, 200));

				Mario.instEnemies.push(new PStatic(525, 225));

				Mario.instEnemies.push(new PStatic(550, 250));

				Mario.instEnemies.push(new PStatic(575, 275));

				Mario.instEnemies.push(new PStatic(600, 300));

				Mario.instEnemies.push(new PStatic(775, 300));

				Mario.instEnemies.push(new PStatic(825, 250));

				Mario.instEnemies.push(new PStatic(1075, 150));

				Mario.instEnemies.push(new PStatic(1100, 175));

				Mario.instEnemies.push(new PStatic(1050, 125));

				Mario.instEnemies.push(new PStatic(1200, 200));

				Mario.instEnemies.push(new PStatic(1175, 200));

				Mario.instEnemies.push(new PStatic(1225, 225));

				Mario.instEnemies.push(new PStatic(1475, 325));

				Mario.instEnemies.push(new PStatic(1450, 325));

				Mario.instEnemies.push(new PStatic(1425, 325));

				Mario.instEnemies.push(new PStatic(1550, 250));

				Mario.instEnemies.push(new PStatic(1575, 225));

				Mario.instEnemies.push(new PStatic(1600, 225));

				Mario.instEnemies.push(new PStatic(1725, 125));

				Mario.instEnemies.push(new PStatic(1750, 125));

				Mario.instEnemies.push(new PStatic(1775, 125));

				Mario.instEnemies.push(new PStatic(1875, 275));

				Mario.instEnemies.push(new PStatic(2100, 325));

				Mario.instEnemies.push(new PStatic(2200, 175));

				Mario.instEnemies.push(new PStatic(2375, 250));

				Mario.instEnemies.push(new PStatic(2725, 150));

				Mario.instEnemies.push(new PStatic(2750, 175));

				Mario.instObjects.push(new Mill(2675, 100, 120, 3));

				// Mario.instObjects.push(new Mill(2300,175,140,2))
				Mario.instObjects.push(new Mill(1800, 150, 150, 3));

				// Mario.instObjects.push(new Mill(1125,200,100,4))
				Mario.instObjects.push(new Mill(425, 200, 110, 3));

				Mario.instEnemies.push(new JumperThrower(3275, 350, -10, 1, 190, 10, 3));

				Mario.instEnemies.push(new JumperThrower(3800, 350, -6, 2, 210, 20, 4));

				Mario.instEnemies.push(new HammerTroopa(4275, 325));

				Mario.instEnemies.push(new HammerTroopa(5100, 325));

				Mario.instEnemies.push(new Spiny(4625, 325));

				Mario.instEnemies.push(new Spiny(4725, 325));

				Mario.instBlocks.push(new Brick(4250, 250));

				Mario.instBlocks.push(new Brick(4275, 250));

				Mario.instBlocks.push(new Brick(4300, 250));

				Mario.instBlocks.push(new Brick(4700, 250));

				Mario.instBlocks.push(new Brick(4675, 250));

				Mario.instBlocks.push(new Brick(4650, 250));

				Mario.instBlocks.push(new Brick(5075, 250));

				Mario.instBlocks.push(new Brick(5100, 250));

				Mario.instBlocks.push(new Brick(5125, 250));

				Mario.instBlocks.push(new Brick(4325, 175));

				Mario.instBlocks.push(new Bonus(450, 75, 1));

				Mario.instBlocks.push(new Bonus(475, 75, 1));

				Mario.instBlocks.push(new Bonus(3025, 200, 1));

				Mario.instBlocks.push(new Bonus(3050, 200, 1));

				Mario.instBlocks.push(new Bonus(3400, 150, 1));

				Mario.instBlocks.push(new Bonus(3425, 150, 1));

				Mario.instBlocks.push(new Bonus(4225, 175, 1));

				Mario.instBlocks.push(new Bonus(4325, 175, 1));

				Mario.instBlocks.push(new Bonus(4225, 275, 0));

				Mario.instBlocks.push(new Bonus(4325, 275, 0));

				Mario.instBlocks.push(new Bonus(4625, 275, 0));

				Mario.instBlocks.push(new Bonus(4725, 275, 0));

				Mario.instBlocks.push(new Bonus(4625, 175, 1));

				Mario.instBlocks.push(new Bonus(4725, 175, 1));

				Mario.instBlocks.push(new Bonus(5050, 175, 1));

				Mario.instBlocks.push(new Bonus(5150, 175, 1));

				Mario.instBlocks.push(new Bonus(5150, 275, 0));

				Mario.instBlocks.push(new Bonus(5050, 275, 0));

				Mario.instBlocks.push(new Bonus(0, 50, 4, true));

				Mario.instBlocks.push(new Bonus(3025, 100, 2));

				Mario.instBlocks.push(new Bonus(3050, 100, 1));

				Mario.instBlocks.push(new BrickMulti(3000, 200));

				Mario.instBlocks.push(new Brick(3075, 200));

				Mario.instEnemies.push(new Spiny(5750, 325));

				Mario.instEnemies.push(new FlyGreen(5575, 175));

				Mario.instEnemies.push(new FlyGreen(5525, 175));

				Mario.instEnemies.push(new FlyGreen(5475, 175));

				Mario.instEnemies.push(new FlyGreen(3550, 175));

				Mario.instEnemies.push(new FlyGreen(3475, 250));

				Mario.instEnemies.push(new Spiny(3625, 150));

				Mario.instEnemies.push(new FlyRed(3900, 125));

				Mario.instEnemies.push(new FlyRed(3950, 175));

				Mario.instEnemies.push(new Spiny(2825, 250));

				Mario.instEnemies.push(new FlyGreen(3075, 300));

				Mario.instEnemies.push(new FlyGreen(3125, 300));

				Mario.instEnemies.push(new Spiny(3050, 175));

				Mario.instEnemies.push(new Bowser(242 * 25, 100, 237 * 25, 7, 15, 5, 2, 20));

				Mario.instEffects.push(new Back(3));

				break;

			case 12:
				Mario.levelGenre = 1;

				Mario.musika = 1;

				Mario.level[0] = "NNNNN23NNNNNNNNNNNNNNNNNNNNNNNNNtuv              NNNNNNNNNNNN                      tuvNNNNNNNNNNNNNNtuvNNNNNNNNNNNNNNtuvNNNNNNNNNNNNNNtuv                                     ";
				Mario.level[1] = "v    45                         tuv                       23NNNNNNNNNNNNNNNNNNNNNNNtuv              tuv              tuv              tuv                                     ";
				Mario.level[2] = "v                               tuv                       23                       tuv              tuv              tuv              tuv                                     ";
				Mario.level[3] = "v              qrs              tuv              qrs      23                       tuv              tuv              tuv              tuv                                     ";
				Mario.level[4] = "v              tuv              tuv              tuv      23      qrsN           N tuv              NNN              tuv              tuv                                     ";
				Mario.level[5] = "v78           6NuN8             tuv              tuv      23      tuvNNNNNNNNNNNNN tuv                               tuv              tuv                                     ";
				Mario.level[6] = "vab      01   9NuNb     01      tuv              tuv      45      tuv              tuv                               tuv              tuv                                     ";
				Mario.level[7] = "v        NN    tuv      NN      tuv              tuv              tuv              tuv                               tuv              NNN                                     ";
				Mario.level[8] = "v        NN    tuv              tuv              tuv              tuv N           Ntuv                               NNN                                                      ";
				Mario.level[9] = "v        23    tuv              NNN              tuv              tuv NNNNNNNNNNNNNNNN                                                                                        ";
				Mario.level[10] = "v        45    tuv                               tuv              tuv                                                                                                         ";
				Mario.level[11] = "v   01         tuv                               tuv              tuv                                                                                                         ";
				Mario.level[12] = "v   23         tuv              qrs              tuv              tuv              qrs                                                                                        ";
				Mario.level[13] = "v   23         tuv              tuv              tuv              tuvN            Ntuv                                                                                        ";
				Mario.level[14] = "vqrrrrrrrrrrrrstuvqrrrrrrrrrrrrstuvqrrrrrrrrrrrrstuvqrrrrrrrrrrrrstuvqrrrrrrrrrrrrrNNNrrs                                                       qrrrrrrrrrrrrrrrrrrrrrrrrrrrrr";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;

				Mario.instObjects.push(new Coin(1550, 225));

				Mario.instObjects.push(new Coin(1550, 200));

				Mario.instObjects.push(new Coin(1375, 225));

				Mario.instObjects.push(new Coin(1375, 200));

				Mario.instObjects.push(new Coin(1475, 175));

				Mario.instObjects.push(new Coin(1475, 200));

				Mario.instObjects.push(new Coin(1475, 225));

				Mario.instObjects.push(new Coin(1450, 225));

				Mario.instObjects.push(new Coin(1450, 200));

				Mario.instObjects.push(new Coin(1450, 175));

				Mario.instObjects.push(new Coin(900, 50));

				Mario.instObjects.push(new Coin(900, 25));

				Mario.instObjects.push(new Coin(1175, 100));

				Mario.instObjects.push(new Coin(1175, 125));

				Mario.instObjects.push(new Coin(925, 200));

				Mario.instObjects.push(new Coin(925, 175));

				Mario.instObjects.push(new Coin(525, 150));

				Mario.instObjects.push(new Coin(550, 150));

				Mario.instObjects.push(new Coin(550, 175));

				Mario.instObjects.push(new Coin(525, 175));

				Mario.instObjects.push(new Coin(500, 175));

				Mario.instObjects.push(new Coin(500, 150));

				Mario.instObjects.push(new Coin(500, 125));

				Mario.instObjects.push(new Coin(525, 125));

				Mario.instObjects.push(new Coin(550, 125));

				Mario.instObjects.push(new Coin(700, 175));

				Mario.instObjects.push(new Coin(750, 125));

				Mario.instObjects.push(new Coin(750, 150));

				Mario.instObjects.push(new Coin(750, 175));

				Mario.instObjects.push(new Coin(725, 175));

				Mario.instObjects.push(new Coin(725, 150));

				Mario.instObjects.push(new Coin(700, 150));

				Mario.instObjects.push(new Coin(700, 125));

				Mario.instObjects.push(new Coin(725, 125));

				Mario.instObjects.push(new Coin(350, 200));

				Mario.instObjects.push(new Coin(350, 175));

				Mario.instObjects.push(new Coin(150, 100));

				Mario.instObjects.push(new Coin(150, 125));

				Mario.instObjects.push(new Coin(50, 75));

				Mario.instObjects.push(new Coin(50, 50));

				Mario.instObjects.push(new Coin(50, 25));

				Mario.instObjects.push(new Coin(25, 25));

				Mario.instObjects.push(new Coin(25, 100));

				Mario.instObjects.push(new Coin(25, 75));

				Player.ResetPlayer(50, 325);

				Mario.instEnemies.push(new PFlame(225, 275, -1));

				Mario.instEnemies.push(new PPlant(100, 250));

				Mario.instEnemies.push(new PPlant(125, 50, -1));

				Mario.instEnemies.push(new FlyRed(300, 75));

				Mario.instBlocks.push(new Bonus(350, 225, 1));

				Mario.instBlocks.push(new Bonus(25, 250, 2, true));

				Mario.instEnemies.push(new PStatic(50, 100));

				Mario.instBlocks.push(new Bonus(150, 175, 1, true));

				Mario.instBlocks.push(new Bonus(25, 50, 3, true));

				Mario.instEnemies.push(new Goomba(325, 325));

				Mario.instEnemies.push(new Goomba(225, 325));

				Mario.instEnemies.push(new FlyGreen(475, 300));

				Mario.instEnemies.push(new FlyGreen(575, 300));

				Mario.instEnemies.push(new FlyGreen(750, 300));

				Mario.instEnemies.push(new FlyGreen(650, 300));

				Mario.instEnemies.push(new Spiny(500, 325));

				Mario.instEnemies.push(new Spiny(550, 325));

				Mario.instEnemies.push(new Spiny(675, 325));

				Mario.instEnemies.push(new Spiny(725, 325));

				Mario.instBlocks.push(new Bonus(525, 225, 1, true));

				Mario.instBlocks.push(new Bonus(725, 225, 1, true));

				Mario.instBlocks.push(new Bonus(725, 100, 3, true));

				Mario.instBlocks.push(new Brick(350, 250));

				Mario.instBlocks.push(new BrickMulti(450, 225));

				Mario.instBlocks.push(new Brick(450, 250));

				Mario.instBlocks.push(new Brick(875, 225));

				Mario.instBlocks.push(new Brick(900, 225));

				Mario.instBlocks.push(new Brick(950, 225));

				Mario.instBlocks.push(new Brick(975, 225));

				Mario.instBlocks.push(new Brick(1000, 225));

				Mario.instBlocks.push(new Brick(1025, 225));

				Mario.instBlocks.push(new Brick(1050, 225));

				Mario.instBlocks.push(new Brick(1075, 225));

				Mario.instBlocks.push(new Brick(1100, 225));

				Mario.instBlocks.push(new Brick(1150, 225));

				Mario.instBlocks.push(new Brick(1125, 225));

				Mario.instBlocks.push(new Brick(1200, 150));

				Mario.instBlocks.push(new Brick(1150, 150));

				Mario.instBlocks.push(new Brick(1125, 150));

				Mario.instBlocks.push(new Brick(1100, 150));

				Mario.instBlocks.push(new Brick(1075, 150));

				Mario.instBlocks.push(new Brick(1050, 150));

				Mario.instBlocks.push(new Brick(1025, 150));

				Mario.instBlocks.push(new Brick(1000, 150));

				Mario.instBlocks.push(new Brick(975, 150));

				Mario.instBlocks.push(new Brick(950, 150));

				Mario.instBlocks.push(new Brick(925, 150));

				Mario.instBlocks.push(new Brick(900, 150));

				Mario.instBlocks.push(new Brick(875, 75));

				Mario.instBlocks.push(new Brick(925, 75));

				Mario.instBlocks.push(new Brick(950, 75));

				Mario.instBlocks.push(new Brick(975, 75));

				Mario.instBlocks.push(new Brick(1000, 75));

				Mario.instBlocks.push(new Brick(1025, 75));

				Mario.instBlocks.push(new Brick(1050, 75));

				Mario.instBlocks.push(new Brick(1075, 75));

				Mario.instBlocks.push(new Brick(1100, 75));

				Mario.instBlocks.push(new Brick(1125, 75));

				Mario.instBlocks.push(new Brick(1150, 75));

				Mario.instBlocks.push(new Brick(1175, 75));

				Mario.instBlocks.push(new Brick(1175, 225));

				Mario.instBlocks.push(new Bonus(1200, 325, 0));

				Mario.instEnemies.push(new HammerTroopa(1050, 50, true));

				Mario.instBlocks.push(new BrickMulti(900, 75));

				Mario.instBlocks.push(new BrickMulti(1175, 150));

				Mario.instBlocks.push(new BrickMulti(925, 225));

				Mario.instBlocks.push(new Bonus(875, 300, 2, true));

				Mario.instEnemies.push(new HammerTroopa(1475, 325));

				Mario.instEnemies.push(new Spiny(1375, 325));

				Mario.instEnemies.push(new Spiny(1550, 325));

				Mario.instEnemies.push(new PStatic(1525, 0));

				Mario.instEnemies.push(new PStatic(1575, 0));

				Mario.instEnemies.push(new PStatic(1625, 0));

				Mario.instEnemies.push(new PStatic(1675, 0));

				Mario.instEnemies.push(new PStatic(1725, 0));

				Mario.instEnemies.push(new PStatic(1775, 0));

				Mario.instEnemies.push(new PStatic(1825, 0));

				Mario.instEnemies.push(new PStatic(1875, 0));

				Mario.instEnemies.push(new PStatic(1925, 0));

				Mario.instEnemies.push(new PStatic(1975, 0));

				Mario.instEnemies.push(new PStatic(2025, 0));

				Mario.instEnemies.push(new PStatic(2050, 0));

				Mario.instEnemies.push(new PStatic(2000, 0));

				Mario.instEnemies.push(new PStatic(1950, 0));

				Mario.instEnemies.push(new PStatic(1900, 0));

				Mario.instEnemies.push(new PStatic(1850, 0));

				Mario.instEnemies.push(new PStatic(1800, 0));

				Mario.instEnemies.push(new PStatic(1750, 0));

				Mario.instEnemies.push(new PStatic(1700, 0));

				Mario.instEnemies.push(new PStatic(1650, 0));

				Mario.instEnemies.push(new PStatic(1600, 0));

				Mario.instEnemies.push(new PStatic(1550, 0));

				Mario.instBlocks.push(new Bonus(1625, 250, 1));

				Mario.instBlocks.push(new Bonus(1625, 150, 1));

				Mario.instBlocks.push(new Bonus(1300, 250, 1));

				Mario.instBlocks.push(new Bonus(1300, 150, 1));

				Mario.instEnemies.push(new Spiny(1775, 100));

				Mario.instEnemies.push(new Spiny(1975, 100));

				Mario.instEnemies.push(new Spiny(1825, 200));

				Mario.instEnemies.push(new Spiny(1975, 200));

				Mario.instEnemies.push(new Spiny(1800, 325));

				Mario.instEnemies.push(new Spiny(1950, 325));

				Mario.instObjects.push(new Cannon(1775, 200));

				Mario.instObjects.push(new Cannon(2000, 100));

				Mario.instObjects.push(new Cannon(2025, 325));

				Mario.instObjects.push(new Cannon(1725, 300));

				Mario.instObjects.push(new ElevatorFall(2300, 300, 25, 'elevator_1'));

				Mario.instObjects.push(new ElevatorFall(2475, 250, 25, 'elevator_1'));

				Mario.instObjects.push(new ElevatorFall(2625, 350, 25, 'elevator_1'));

				Mario.instObjects.push(new ElevatorFall(2825, 275, 25, 'elevator_1'));

				Mario.instObjects.push(new ElevatorFall(2950, 350, 25, 'elevator_1'));

				Mario.instObjects.push(new ElevatorFall(3425, 350, 25, 'elevator_1'));

				Mario.instObjects.push(new ElevatorFall(3325, 175, 25, 'elevator_1'));

				Mario.instObjects.push(new ElevatorFall(3125, 175, 25, 'elevator_1'));

				Mario.instObjects.push(new ElevatorFall(3075, 275, 25, 'elevator_1'));

				Mario.instObjects.push(new Finish(3650, 325));

				Mario.instObjects.push(new Cannon(350, 100));

				Mario.instEnemies.push(new PFlame(225, 125));

				Mario.instEnemies.push(new Spiny(275, 325));

				Mario.instEnemies.push(new Spiny(175, 325));

				Mario.instEnemies.push(new PFlame(600, 125));

				Mario.instEnemies.push(new HammerTroopa(975, 325, true));

				Mario.instEnemies.push(new HammerTroopa(1100, 200, true));

				Mario.instEnemies.push(new HammerTroopa(1075, 125, true));

				Mario.instEnemies.push(new HammerTroopa(975, 50, true));

				Mario.instEnemies.push(new HammerTroopa(1025, 200, true));

				Mario.instEnemies.push(new PFlame(1450, 175, -1));

				Mario.instEffects.push(new Back(1));

				var i:int;

				for (i = Mario.instEnemies.length - 1; i >= 0; i--)
				{
					if (Mario.instEnemies[i] is Enemy)
					{
						Mario.instEnemies[i].active = true;

					}
				}
				break;

			case 13:
				Mario.levelGenre = 0;

				Mario.musika = 0;

				Mario.generateBackground(0);

				Mario.level[0] = "                                                                                                                                                                                                                                                                                                                                                    ";
				Mario.level[1] = "                                                                                                                                                                                                                                                                                                                                                    ";
				Mario.level[2] = "                                                                                                                                                                   cde                                                                                                                                M M MMM M M M M M                             ";
				Mario.level[3] = "                                                                             ce cddde cddde cddde ce                                                               fgh                            cde  cde cde cde                                                                                    M M MMM M M M M M                             ";
				Mario.level[4] = "                                                                             MM MMMMM MMMMM MMMMM MM                                                               fgh                            MMM  MMM MMM MMM                                                                                          M M M M M                               ";
				Mario.level[5] = "                                                                                  M           M                                                                    fgh                             M    M   M   M                                                                                           M M M M                                 ";
				Mario.level[6] = "                                                                                  M           M                                                  01                fgh                01           M    M   M   M                           M                                 M                             M M M                                   ";
				Mario.level[7] = "                                               MM        M                        M           M                                         ce       23                fgh                23           M    M       M                   M              M      M         M               M                     M M M                                     ";
				Mario.level[8] = "                                               MM        MM                  ce  cde   cde   cde  ce                                    fh       MM78              fgh              67MM           M    M       M               M       M                      M          M                             M M M         M                             ";
				Mario.level[9] = "                                    MM                                       fh  MMM   MMM   MMM  fh                                    fh       MMab ijklm ijklm ijklm ijklm ijklm 9aMM                M       M                             M     M                           M       M    M          M M M       M M                             ";
				Mario.level[10] = "                                    MM    MM                                 fh         M         fh                                    fh ce    23    nop   nop   nop   nop   nop    23                M       M           MM      M     M             M   M          M                              M M M M     M M M                             ";
				Mario.level[11] = "                                          MM                                 fh         M         fh                              ce    fh fh    23    nop   nop   nop   nop   nop    23                M               01  MM                    M                 M                                 M M M     M M M M                             ";
				Mario.level[12] = "                                 M                                           fh         M         fh                              fh ce fh fh    23cdddeocdddeocdddeocdddeocdddeocddde23                M   M           23       01   M    M   M     M        M             M    M                  M M M M   M M M M M                             ";
				Mario.level[13] = "                                 M                              cddddddddddddfhdddddddddddddddddddfhddddddde    ce    ce    ce    fh fh fh fh    23fggghofggghofggghofggghofggghofgggh23           M        M           23       23                                                   M       M    MM M M M   M M M M M                             ";
				Mario.level[14] = "dddddddddde M M M M MM        cdde                              fggggggggggggfhgggggggggggggggggggfhgggggggh ce fh ce fh ce fh ce fh fh fh fh ce 23fggghofggghofggghofggghofggghofgggh23 cddddddddde cdddddde cdddddddddde cdddddde cde   cddddde    cdddddddde M     cddde    cddde   cddde ce   cde M M MM MM M M M M     cddddddddddddddddddddddd";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 150;
				Player.ResetPlayer(50, 275);

				Mario.instEffects.push(new Background(3850, 50, 'back_hill_big', 0.82));

				Mario.instEffects.push(new Background(25, 125, 'back_clouds_8', 0.64));

				Mario.instEffects.push(new Background(1350, 150, 'back_hill_big', 0.59));

				Mario.instEffects.push(new Background(3050, 300, 'back_hill', 0.55));

				Mario.instEffects.push(new Background(6075, 350, 'back_hill', 0.50));

				Mario.instEffects.push(new Background(5050, 300, 'back_hill', 0.39));

				Mario.instEffects.push(new Background(4625, 75, 'back_clouds_3', 0.18));

				Mario.instEffects.push(new Background(7875, 100, 'back_clouds_1', 0.17));

				Mario.instEffects.push(new Background(6575, 50, 'back_clouds_3', 0.12));

				Mario.instEffects.push(new Background(3200, 25, 'back_clouds_2', 0.05));

				Mario.instObjects.push(new Coin(4975, 225));

				Mario.instObjects.push(new Coin(4975, 200));

				Mario.instObjects.push(new Coin(5025, 225));

				Mario.instObjects.push(new Coin(5025, 200));

				Mario.instObjects.push(new Coin(4525, 250));

				Mario.instObjects.push(new Coin(4450, 250));

				Mario.instObjects.push(new Coin(4350, 250));

				Mario.instObjects.push(new Coin(4300, 250));

				Mario.instObjects.push(new Coin(4200, 250));

				Mario.instObjects.push(new Coin(4050, 250));

				Mario.instObjects.push(new Coin(4150, 250));

				Mario.instObjects.push(new Coin(4000, 250));

				Mario.instObjects.push(new Coin(3900, 250));

				Mario.instObjects.push(new Coin(3850, 250));

				Mario.instObjects.push(new Coin(3750, 250));

				Mario.layerWall.addChild(AddGraphic(3675, 275, 'back_fence_1'));

				Mario.instObjects.push(new Coin(3700, 250));

				Mario.instObjects.push(new Coin(3675, 250));

				Mario.instObjects.push(new Coin(3575, 300));

				Mario.instObjects.push(new Coin(3550, 300));

				Mario.instObjects.push(new Coin(2375, 125));

				Mario.instObjects.push(new Coin(2375, 150));

				Mario.instObjects.push(new Coin(2325, 150));

				Mario.instObjects.push(new Coin(2325, 125));

				Mario.instObjects.push(new Coin(2075, 150));

				Mario.instObjects.push(new Coin(2075, 125));

				Mario.instObjects.push(new Coin(2025, 125));

				Mario.instObjects.push(new Coin(2025, 150));

				Mario.instObjects.push(new Coin(1450, 175));

				Mario.instObjects.push(new Coin(825, 250));

				Mario.instObjects.push(new Coin(825, 225));

				Mario.instObjects.push(new Coin(225, 250));

				Mario.instObjects.push(new Coin(200, 250));

				Mario.layerWall.addChild(AddGraphic(8000, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(8475, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(8450, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8425, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8400, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8375, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8350, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8325, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8300, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8275, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8250, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8225, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8200, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8175, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8150, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8125, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8100, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8075, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8050, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(8025, 325, 'back_fence_2'));

				Mario.instEffects.push(new Cloud(8350, 125));

				Mario.instEffects.push(new Cloud(7925, 25));

				Mario.instEffects.push(new Cloud(7175, 150));

				Mario.instEffects.push(new Cloud(6025, 50));

				Mario.instEffects.push(new Cloud(5275, 175));

				Mario.instEffects.push(new Cloud(4450, 25));

				Mario.instEffects.push(new Cloud(3625, 75));

				Mario.instEffects.push(new Cloud(100, 100));

				Mario.instEffects.push(new Cloud(475, 25));

				Mario.instEffects.push(new Cloud(1200, 75));

				Mario.instEffects.push(new Cloud(1775, 25));

				Mario.instEffects.push(new Cloud(2475, 125));

				Mario.instEffects.push(new Cloud(3025, 50));

				Mario.layerWall.addChild(AddGraphic(7100, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(7125, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(7075, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(6975, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(7000, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(7025, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(7050, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6875, 300, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(6875, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(6850, 275, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(6850, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(6850, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(6775, 275, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(6775, 300, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(6775, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(6575, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(6650, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(6600, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6625, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6275, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(6350, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(6325, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(6300, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5850, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(5925, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(5900, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5875, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4700, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(4725, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4750, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4775, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4800, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4825, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4850, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4450, 275, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(4525, 275, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(4475, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4500, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(4100, 0, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(4100, 25, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(4050, 250, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(4050, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(3750, 275, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(3725, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3700, 275, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(3500, 200, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(3500, 225, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(3325, 200, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(3325, 225, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(3325, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(3325, 250, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(3275, 200, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(3275, 225, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(3275, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(3125, 250, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(3125, 275, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(3125, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(3025, 300, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(3025, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2775, 300, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(2850, 300, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(2825, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2800, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2700, 300, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(2650, 300, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(2675, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2475, 0, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(2475, 25, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(2475, 50, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2125, 50, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(2275, 50, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(2150, 50, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2250, 50, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2225, 50, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2200, 50, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(2175, 50, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1925, 25, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(1925, 50, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1875, 100, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(1875, 125, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1875, 150, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1875, 175, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(1875, 200, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(1875, 225, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1875, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1875, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1875, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1825, 250, 'back_tree_5'));

				Mario.layerWall.addChild(AddGraphic(1825, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1825, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1625, 300, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(1800, 300, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(1650, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1675, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1700, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1725, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1750, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(1775, 300, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(750, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(775, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(800, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(475, 325, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(550, 325, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(525, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(500, 325, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(5200, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5200, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5200, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5100, 175, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5100, 200, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5100, 225, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5100, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5100, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(5000, 325, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(4875, 225, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(4875, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(4875, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(4875, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1925, 125, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1925, 150, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(1925, 175, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2475, 175, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2475, 150, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2475, 125, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2375, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2375, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2375, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2325, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2325, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2325, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2225, 175, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2225, 150, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2225, 125, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2175, 125, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2175, 150, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2175, 175, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2075, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2075, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2075, 300, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2025, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2025, 275, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(2025, 300, 'back_tree_1'));

				Mario.instEnemies.push(new PStatic(5100, 275));

				Mario.instEnemies.push(new PStatic(4875, 300));

				Mario.instObjects.push(new Finish(7925, 325));

				Mario.instEnemies.push(new Lakitu(175, 13));

				Mario.instEnemies.push(new Lakitu(575, 15));

				Mario.instEnemies.push(new Lakitu(900, 17));

				Mario.instObjects.push(new Elevator(1975, 100, 25, 'elevator_1'));

				Mario.instObjects.push(new Elevator(2125, 100, 25, 'elevator_1'));

				Mario.instObjects.push(new Elevator(2275, 100, 25, 'elevator_1'));

				Mario.instObjects.push(new Elevator(2425, 100, 25, 'elevator_1'));

				Mario.instObjects.push(new Elevator(4925, 100, 50, 'elevator_2'));

				Mario.instObjects.push(new Elevator(5050, 100, 25, 'elevator_1'));

				Mario.instObjects.push(new Elevator(5150, 100, 25, 'elevator_1'));

				Mario.instObjects.push(new Elevator(7375, 75, 25, 'elevator_1'));

				Mario.instObjects.push(new Elevator(7425, 75, 25, 'elevator_1'));

				Mario.instObjects.push(new Elevator(7525, 75, 25, 'elevator_1'));

				Mario.instObjects.push(new Elevator(7575, 75, 25, 'elevator_1'));

				Mario.instObjects.push(new Elevator(7625, 75, 25, 'elevator_1'));

				Mario.instObjects.push(new Elevator(7675, 75, 25, 'elevator_1'));

				Mario.instObjects.push(new Elevator(7725, 75, 25, 'elevator_1'));

				Mario.instBlocks.push(new Bonus(3600, 225, 4, true));

				Mario.instBlocks.push(new Bonus(4150, 100, 4, true));

				Mario.instBlocks.push(new Bonus(5300, 250, 1));

				Mario.instBlocks.push(new Bonus(5275, 250, 1));

				Mario.instBlocks.push(new Bonus(5250, 250, 2));

				Mario.instBlocks.push(new Bonus(5325, 250, 3, true));

				Mario.instBlocks.push(new Bonus(2500, 250, 5, true));

				break;

			case 14:
				Mario.levelGenre = 0;

				Mario.musika = 0;

				Mario.generateBackground(0);

				Mario.level[0] = "                                                                                                                                                                                                               ";
				Mario.level[1] = "                                                                                                                                                                                                               ";
				Mario.level[2] = "                                                                                                                                                                                                               ";
				Mario.level[3] = "                                                                                                                                                                                                               ";
				Mario.level[4] = "                                                                                                                                                                                                               ";
				Mario.level[5] = "                                                                                                                                                                                                               ";
				Mario.level[6] = "                                                                                                                                                                                                               ";
				Mario.level[7] = "                                                                                                                                                                                                               ";
				Mario.level[8] = "                                                                                                                                                                                                               ";
				Mario.level[9] = "                                                                                                                                                                                                               ";
				Mario.level[10] = "                                                                                                                                                                                                               ";
				Mario.level[11] = "                         S                                                                                                                                                                                     ";
				Mario.level[12] = " MMMMM                   R                       S                                                                S                                                     S                                      ";
				Mario.level[13] = "ijkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkklm";
				Mario.level[14] = " nooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooop ";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Mario.instEffects.push(new Cloud(4925, 75));

				Mario.instEffects.push(new Cloud(4425, 125));

				Mario.instEffects.push(new Cloud(3875, 75));

				Mario.instEffects.push(new Cloud(3375, 25));

				Mario.instEffects.push(new Cloud(2925, 125));

				Mario.instEffects.push(new Cloud(2475, 75));

				Mario.instEffects.push(new Cloud(2000, 100));

				Mario.instEffects.push(new Cloud(1425, 50));

				Mario.instEffects.push(new Cloud(1050, 150));

				Mario.instEffects.push(new Cloud(625, 50));

				Mario.instEffects.push(new Cloud(125, 100));

				Mario.instObjects.push(new Coin(4200, 200));

				Mario.instObjects.push(new Coin(3500, 200));

				Mario.instObjects.push(new Coin(2850, 200));

				Mario.instObjects.push(new Coin(1675, 200));

				Mario.instObjects.push(new Coin(1225, 200));

				Mario.instObjects.push(new Coin(625, 200));

				Player.ResetPlayer(75, 275);

				Mario.instEnemies.push(new HammerTroopa(425, 300, true));

				Mario.instEnemies.push(new Spiny(675, 300));

				Mario.instEnemies.push(new Spiny(775, 300));

				Mario.instEnemies.push(new Spiny(875, 300));

				Mario.instEnemies.push(new Spiny(975, 300));

				Mario.instEnemies.push(new Spiny(1075, 300));

				Mario.instEnemies.push(new Spiny(1175, 300));

				Mario.instObjects.push(new Cannon(625, 250));

				Mario.instObjects.push(new Cannon(1225, 275));

				Mario.instEnemies.push(new HammerTroopa(1375, 300, true));

				Mario.instEnemies.push(new HammerTroopa(1550, 300, true));

				Mario.instEnemies.push(new Spiny(1800, 300));

				Mario.instObjects.push(new Cannon(1675, 300));

				Mario.instEnemies.push(new Spiny(1900, 300));

				Mario.instEnemies.push(new HammerTroopa(2050, 300));

				Mario.instEnemies.push(new HammerTroopa(2300, 300, true));

				Mario.instEnemies.push(new HammerTroopa(2625, 300));

				Mario.instEnemies.push(new PStatic(2500, 300));

				Mario.instEnemies.push(new PStatic(2425, 300));

				Mario.instEnemies.push(new PStatic(2125, 300));

				Mario.instEnemies.push(new PStatic(2200, 300));

				Mario.instObjects.push(new Cannon(2850, 275));

				Mario.instEnemies.push(new HammerTroopa(3025, 300, true));

				Mario.instEnemies.push(new HammerTroopa(3175, 300, true));

				Mario.instEnemies.push(new BBeetle(3275, 300));

				Mario.instEnemies.push(new BBeetle(3325, 300));

				Mario.instEnemies.push(new Spiny(3300, 300));

				Mario.instObjects.push(new Cannon(3500, 300));

				Mario.instEnemies.push(new Lakitu(400, 50));

				Mario.instEnemies.push(new HammerTroopa(3750, 300));

				Mario.instEnemies.push(new HammerTroopa(4000, 300, true));

				Mario.instObjects.push(new Cannon(4200, 275));

				Mario.instObjects.push(new Finish(4550, 300));

				Mario.instEnemies.push(new HammerTroopa(375, 300));

				Mario.instEnemies.push(new PStatic(400, 300));

				Mario.instEnemies.push(new PStatic(900, 300));

				Mario.instEnemies.push(new PStatic(1150, 300));

				Mario.instEnemies.push(new PStatic(1275, 300));

				Mario.instEnemies.push(new PStatic(1725, 300));

				Mario.instEnemies.push(new PStatic(3150, 300));

				Mario.instEnemies.push(new PStatic(3400, 300));

				Mario.instEnemies.push(new PStatic(3725, 300));

				Mario.instEnemies.push(new PStatic(3650, 300));

				Mario.instEnemies.push(new PStatic(3875, 300));

				Mario.instEnemies.push(new PStatic(4275, 300));

				Mario.instEnemies.push(new PStatic(4425, 300));

				Mario.instEnemies.push(new PStatic(3600, 300));

				Mario.instBlocks.push(new Bonus(650, 250, 4, true));

				Mario.instBlocks.push(new Bonus(25, 250, 2, true));

				Mario.instEffects.push(new Back(4));

				break;

			case 15:
				Mario.musika = 2;

				Mario.levelGenre = 3;

				Mario.level[0] = "ABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABABAB";
				Mario.level[1] = "            CD           ABABABABAB                                    45                                  U              U                            U         45             U            U                                      ";
				Mario.level[2] = "            AB           CABABABABD                                                                        U              U                            U                        U            U                                      ";
				Mario.level[3] = "            CD           ABABABABD    UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU UUUUUUUUUUUUUUUUUUUUUUUU UUUUUUUUUUUU U UUUUUUUUUUUUUUUUUUUUUUUUUU UUUUUUUUUUUUUUUU UUUUUUUUUUUUUUUUU UUUU                                      ";
				Mario.level[4] = "            AB   EFFFFFG CABABABD                       45   U                    U  45          U   45  U              U                    U                          U                  U U                                      ";
				Mario.level[5] = "            CD   HIIIIIJ ABABABAB                            U                    U              U       U              U                    U                          U                  U U                                      ";
				Mario.level[6] = "            AB   HIIIIIJ CABABABD        01                  U               01   U              U       U     01       U         01         U            01            U     01      01     U                                      ";
				Mario.level[7] = "            CD   HIIIIIJ ABABABAB   UUUUUUUUUUUUUUUUUUUUUUUU UUUUUUUUUUUUU UUUUUUUUUUUUU UUUUUUUUUU UUUU UUUUUUUUUUUU UUUUUUUUUUUUUUUUU UUUUUU UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU UUUUUUUUU U                                      ";
				Mario.level[8] = "            AB   HIIIIIJ CABABD                                            U       45     U          U             45      U            U    U               U   U              45 U         U                                      ";
				Mario.level[9] = "FFG              HIIIIIJ ABABAB                                            U              U          U                     U            U                    U   U                 U         U                                      ";
				Mario.level[10] = "IILG             HIIIIIJ CABAB    UUUUUUUUUUUUUUUUUUUUUUUUUUUUU UUUUUUUUUUUUUUU UUUUUUUUUUUU UUUUUUUUUUUUUUUUU UUUUUUUUUUUUUUUUUUUUUU UUU UUUUUUUUUUUUUUUUUUUU U UUUUUUUUUUU UUUUUUUUUUUUU UUU                                      ";
				Mario.level[11] = "IIILFFFFFFFFFFFFFKIIIIIJ                                             U                                      U                  U       U     45                U               U  45         U    01                                ";
				Mario.level[12] = "IIIIIIIIIIIIIIIIIIIIIIIJ                                             U                                      U                  U       U                       U               U             U    23                                ";
				Mario.level[13] = "IIIIIIIIIIIIIIIIIIIIIIIJ                                             U               01                 01  U          01      U       U               01      U       01      U       01         23                                ";
				Mario.level[14] = "IIIIIIIIIIIIIIIIIIIIIIIJ EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFG                               ";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 150;
				Mario.instObjects.push(new Coin(375, 125));

				Mario.instObjects.push(new Coin(375, 175));

				Mario.instObjects.push(new Coin(375, 225));

				Mario.instObjects.push(new Coin(550, 50));

				Mario.instObjects.push(new Coin(500, 50));

				Mario.instObjects.push(new Coin(450, 50));

				Mario.instObjects.push(new Coin(4700, 300));

				Mario.instObjects.push(new Coin(4350, 300));

				Mario.instObjects.push(new Coin(4400, 300));

				Mario.instObjects.push(new Coin(4450, 225));

				Mario.instObjects.push(new Coin(4500, 225));

				Mario.instObjects.push(new Coin(4700, 225));

				Mario.instObjects.push(new Coin(4650, 125));

				Mario.instObjects.push(new Coin(4700, 125));

				Mario.instObjects.push(new Coin(4700, 50));

				Mario.instObjects.push(new Coin(4425, 50));

				Mario.instObjects.push(new Coin(4375, 50));

				Mario.instObjects.push(new Coin(4225, 125));

				Mario.instObjects.push(new Coin(4175, 125));

				Mario.instObjects.push(new Coin(3800, 50));

				Mario.instObjects.push(new Coin(3950, 300));

				Mario.instObjects.push(new Coin(4000, 300));

				Mario.instObjects.push(new Coin(4050, 225));

				Mario.instObjects.push(new Coin(3900, 225));

				Mario.instObjects.push(new Coin(3550, 125));

				Mario.instObjects.push(new Coin(3500, 125));

				Mario.instObjects.push(new Coin(3375, 225));

				Mario.instObjects.push(new Coin(2650, 125));

				Mario.instObjects.push(new Coin(2600, 125));

				Mario.instObjects.push(new Coin(2450, 125));

				Mario.instObjects.push(new Coin(2400, 125));

				Mario.instObjects.push(new Coin(3400, 300));

				Mario.instObjects.push(new Coin(3350, 300));

				Mario.instObjects.push(new Coin(3200, 300));

				Mario.instObjects.push(new Coin(3150, 300));

				Mario.instObjects.push(new Coin(3100, 225));

				Mario.instObjects.push(new Coin(3050, 225));

				Mario.instObjects.push(new Coin(3025, 150));

				Mario.instObjects.push(new Coin(2975, 150));

				Mario.instObjects.push(new Coin(2650, 50));

				Mario.instObjects.push(new Coin(2725, 300));

				Mario.instObjects.push(new Coin(2675, 300));

				Mario.instObjects.push(new Coin(2550, 225));

				Mario.instObjects.push(new Coin(2500, 225));

				Mario.instObjects.push(new Coin(2225, 225));

				Mario.instObjects.push(new Coin(2275, 225));

				Mario.instObjects.push(new Coin(2075, 125));

				Mario.instObjects.push(new Coin(2025, 125));

				Mario.instObjects.push(new Coin(1700, 300));

				Mario.instObjects.push(new Coin(1750, 300));

				Mario.instObjects.push(new Coin(1900, 225));

				Mario.instObjects.push(new Coin(1850, 225));

				Mario.instObjects.push(new Coin(1550, 125));

				Mario.instObjects.push(new Coin(1500, 125));

				Mario.instEnemies.push(new Spiny(575, 75));

				Mario.instObjects.push(new ElevatorFall(600, 100, 25, 'elevator_1'));

				Mario.instBlocks.push(new Bonus(400, 175, 1, true));

				Player.ResetPlayer(25, 200);

				Mario.instEnemies.push(new PPlant(1025, 125));

				Mario.instEnemies.push(new PPlant(1925, 125));

				Mario.instEnemies.push(new PPlant(2125, 300));

				Mario.instEnemies.push(new PPlant(2600, 300));

				Mario.instEnemies.push(new PPlant(2775, 125));

				Mario.instEnemies.push(new PPlant(2975, 300));

				Mario.instEnemies.push(new PPlant(3250, 125));

				Mario.instEnemies.push(new PPlant(3775, 300));

				Mario.instEnemies.push(new PPlant(3850, 125));

				Mario.instEnemies.push(new PPlant(4175, 300));

				Mario.instEnemies.push(new PPlant(4350, 125));

				Mario.instEnemies.push(new PPlant(4550, 125));

				Mario.instEnemies.push(new PPlant(4575, 300));

				Mario.instEnemies.push(new PPlant(4450, 300, -1));

				Mario.instEnemies.push(new PPlant(3525, 300, -1));

				Mario.instEnemies.push(new PPlant(2525, 125, -1));

				Mario.instEnemies.push(new PPlant(2125, 125, -1));

				Mario.instEnemies.push(new PPlant(1400, 125, -1));

				Mario.instObjects.push(new Pipein(195 * 25, 11 * 25, 195 * 25, 11 * 25, 1, 4));

				Mario.instEffects.push(new Back(3));

				break;

			case (16):
				Mario.levelGenre = 3;

				Mario.level[0] = "D  C45D  C45D  CM";
				Mario.level[1] = "                M";
				Mario.level[2] = "                M";
				Mario.level[3] = "                M";
				Mario.level[4] = "                M";
				Mario.level[5] = "                M";
				Mario.level[6] = "                M";
				Mario.level[7] = "                M";
				Mario.level[8] = "                M";
				Mario.level[9] = "                M";
				Mario.level[10] = "                M";
				Mario.level[11] = " OOOOOOOOOOOOOO M";
				Mario.level[12] = "                M";
				Mario.level[13] = "                M";
				Mario.level[14] = "                M";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Player.ResetPlayer(200, 0);

				Mario.instEnemies.push(new Bowser(350, 200, 0, 9, 15, 15, 6, 5));

				Mario.instEffects.push(new Back(3));

				Mario.instObjects.push(new LastLevel());

				break;
			case (17):
				Mario.level[0] = "                ";
				Mario.level[1] = "                ";
				Mario.level[2] = "                ";
				Mario.level[3] = "                ";
				Mario.level[4] = "                ";
				Mario.level[5] = "                ";
				Mario.level[6] = "                ";
				Mario.level[7] = "                ";
				Mario.level[8] = "                ";
				Mario.level[9] = "                ";
				Mario.level[10] = "                ";
				Mario.level[11] = "dddddddddddddddd";
				Mario.level[12] = "gggggggggggggggg";
				Mario.level[13] = "gggggggggggggggg";
				Mario.level[14] = "gggggggggggggggg";
				Mario.levelWid = Mario.level[0].length;
				Mario.levelHei = Mario.level.length;
				Mario.drawLevel();
				Mario.Hud.Time = 320;
				Player.ResetPlayer(0, 0);

				Mario.playerControllable = false;

				objects.Player.GFX2.alpha = 0;

				Mario.Hud.GFX.alpha = 0;

				Mario.instEffects.push(new Cloud(375, 0));

				Mario.instEffects.push(new Cloud(325, 75));

				Mario.instEffects.push(new Cloud(150, 25));

				Mario.instEffects.push(new Cloud(25, 50));

				Mario.layerWall.addChild(AddGraphic(200, 250, 'back_fence_3'));

				Mario.layerWall.addChild(AddGraphic(100, 250, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(250, 250, 'back_fence_1'));

				Mario.layerWall.addChild(AddGraphic(275, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(300, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(325, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(350, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(375, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(175, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(150, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(125, 250, 'back_fence_2'));

				Mario.layerWall.addChild(AddGraphic(375, 150, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(375, 200, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(375, 175, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(375, 225, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(375, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(300, 200, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(300, 225, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(300, 250, 'back_tree_1'));

				Mario.layerWall.addChild(AddGraphic(25, 150, 'back_tree_4'));

				Mario.layerWall.addChild(AddGraphic(25, 175, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(25, 200, 'back_tree_3'));

				Mario.layerWall.addChild(AddGraphic(25, 225, 'back_tree_2'));

				Mario.layerWall.addChild(AddGraphic(25, 250, 'back_tree_1'));

				Mario.instObjects.push(new GameEnd());

				Mario.musika = 13;
				break;

		}
		if (Mario.levelid < 17)
		{
			Mario.sequence = 0;

			Mario.self.waitScreen();

		}
		Mario.stepping = true;

	}
}