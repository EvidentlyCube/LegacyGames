package objects.levelMakes
{
   import objects.*;
   
   public function MakeLevel1_3() : void
   {
      Mario.generateBackground(0);
      Mario.levelGenre = 0;
      Mario.musika = 1;
      Mario.level[0] = "                                                                                                                                                                                    ";
      Mario.level[1] = "                                                                                                                                                                                    ";
      Mario.level[2] = "                                                                                                                                                                                    ";
      Mario.level[3] = "                                                                                                                                                                                    ";
      Mario.level[4] = "                                                                                                                                                                                    ";
      Mario.level[5] = "                                                                                                                                                                                    ";
      Mario.level[6] = "                                                                                                                                                                                    ";
      Mario.level[7] = "                                                                                                                                                                                    ";
      Mario.level[8] = "                                                                                                                                                                                    ";
      Mario.level[9] = "           lmnnnnnop                                                                            lmnnnnop                                                                            ";
      Mario.level[10] = "            qrrrrrs                                                                      lmop    qrrrrs                                                                             ";
      Mario.level[11] = " cddddde    qrrrrrs                                           01            01            qs     qrrrrs                                             01                              ";
      Mario.level[12] = " fgggggh    qrrrrrs                                           23            23            qs     qrrrcddddddddddddde                                23                              ";
      Mario.level[13] = " ijjjjjk    qrrrrrs                                           23            23            qs     qrrrfgggggggggggggh      cdddddddde   01   cdddddddddddddddddddddddddddddddddddddde";
      Mario.level[14] = "            qrrrrrs      cddddddddde    cddddde  cde  cddddddddddddddddddddddddddddddde   qs     qrrrfgggggggggggggh      fggggggggh   23   fggggggggggggggggggggggggggggggggggggggh";
      Mario.levelWid = Mario.level[0].length;
      Mario.levelHei = Mario.level.length;
      Mario.Hud.Time = 320;
      Mario.instEffects.push(new Background(200,50,"back_clouds_2",0.320000023));
      Mario.instEffects.push(new Background(3625,25,"back_clouds_1",0.300000012));
      Mario.instEffects.push(new Background(2300,25,"back_clouds_1",0.25999999));
      Mario.instEffects.push(new Background(1000,175,"back_clouds_3",0.189999998));
      Mario.instEffects.push(new Background(1975,250,"back_clouds_3",0.170000002));
      Mario.instEffects.push(new Background(3475,175,"back_clouds_1",0.140000001));
      Mario.instEffects.push(new Background(1600,100,"back_clouds_3",0.129999995));
      Mario.instEffects.push(new Background(550,200,"back_clouds_2",0.0500000007));
      Mario.layerWall.addChild(AddGraphic(3925,50,"back_castle"));
      Mario.drawLevel();
      Mario.instEffects.push(new Cloud(4175,175));
      Mario.instEffects.push(new Cloud(4050,75));
      Mario.instEffects.push(new Cloud(3725,175));
      Mario.instEffects.push(new Cloud(3325,50));
      Mario.instEffects.push(new Cloud(3050,175));
      Mario.instEffects.push(new Cloud(2675,100));
      Mario.instEffects.push(new Cloud(2700,25));
      Mario.instEffects.push(new Cloud(2200,100));
      Mario.instEffects.push(new Cloud(2100,200));
      Mario.instEffects.push(new Cloud(1775,50));
      Mario.instEffects.push(new Cloud(1425,150));
      Mario.instEffects.push(new Cloud(1200,25));
      Mario.instEffects.push(new Cloud(950,100));
      Mario.instEffects.push(new Cloud(700,50));
      Mario.instEffects.push(new Cloud(525,150));
      Mario.instEffects.push(new Cloud(75,75));
      Mario.instObjects.push(new Finish(3825,300));
      Player.ResetPlayer(100,225);
      Mario.instBlocks.push(new Brick(325,125));
      Mario.instBlocks.push(new Brick(425,125));
      Mario.instBlocks.push(new Brick(675,275));
      Mario.instBlocks.push(new Brick(825,275));
      Mario.instBlocks.push(new Brick(800,275));
      Mario.instBlocks.push(new Brick(1675,250));
      Mario.instBlocks.push(new Brick(1800,250));
      Mario.instBlocks.push(new Brick(2725,200));
      Mario.instBlocks.push(new BrickMulti(700,275));
      Mario.instBlocks.push(new BrickMulti(1250,250));
      Mario.instBlocks.push(new BrickMulti(2475,125));
      Mario.instBlocks.push(new Bonus(2750,200,1));
      Mario.instBlocks.push(new Bonus(2700,200,1));
      Mario.instBlocks.push(new Bonus(1700,250,1));
      Mario.instBlocks.push(new Bonus(1775,250,1));
      Mario.instBlocks.push(new Bonus(1650,250,1));
      Mario.instBlocks.push(new Bonus(1825,250,1));
      Mario.instBlocks.push(new Bonus(700,200,1));
      Mario.instBlocks.push(new Bonus(800,200,1));
      Mario.instBlocks.push(new Bonus(775,200,1));
      Mario.instBlocks.push(new Bonus(725,200,1));
      Mario.instBlocks.push(new Bonus(450,125,1));
      Mario.instBlocks.push(new Bonus(300,125,1));
      Mario.instObjects.push(new Coin(350,125));
      Mario.instObjects.push(new Coin(375,125));
      Mario.instObjects.push(new Coin(400,125));
      Mario.instObjects.push(new Coin(325,50));
      Mario.instObjects.push(new Coin(425,50));
      Mario.instObjects.push(new Coin(50,200));
      Mario.instObjects.push(new Coin(50,175));
      Mario.instObjects.push(new Coin(150,175));
      Mario.instObjects.push(new Coin(150,200));
      Mario.instObjects.push(new Coin(725,175));
      Mario.instObjects.push(new Coin(775,175));
      Mario.instObjects.push(new Coin(700,250));
      Mario.instObjects.push(new Coin(800,250));
      Mario.instObjects.push(new Coin(750,100));
      Mario.instObjects.push(new Coin(1275,250));
      Mario.instObjects.push(new Coin(1250,275));
      Mario.instObjects.push(new Coin(1225,250));
      Mario.instObjects.push(new Coin(1250,225));
      Mario.instObjects.push(new Coin(1575,250));
      Mario.instObjects.push(new Coin(1550,250));
      Mario.instObjects.push(new Coin(1900,250));
      Mario.instObjects.push(new Coin(1925,250));
      Mario.instObjects.push(new Coin(1800,200));
      Mario.instObjects.push(new Coin(1675,200));
      Mario.instObjects.push(new Coin(2250,200));
      Mario.instObjects.push(new Coin(2275,200));
      Mario.instObjects.push(new Coin(2425,125));
      Mario.instObjects.push(new Coin(2550,125));
      Mario.instBlocks.push(new Brick(2500,125));
      Mario.instObjects.push(new Coin(2700,150));
      Mario.instObjects.push(new Coin(2725,150));
      Mario.instObjects.push(new Coin(2750,150));
      Mario.instObjects.push(new Coin(3100,300));
      Mario.instObjects.push(new Coin(3125,300));
      Mario.instObjects.push(new Coin(3125,275));
      Mario.instObjects.push(new Coin(3125,250));
      Mario.instObjects.push(new Coin(3225,300));
      Mario.instObjects.push(new Coin(3200,300));
      Mario.instObjects.push(new Coin(3200,275));
      Mario.instObjects.push(new Coin(3200,250));
      Mario.instObjects.push(new Coin(3125,175));
      Mario.instObjects.push(new Coin(3200,175));
      Mario.instObjects.push(new Coin(3150,300));
      Mario.instObjects.push(new Coin(3175,300));
      Mario.instObjects.push(new Coin(3400,300));
      Mario.instObjects.push(new Coin(3375,300));
      Mario.instObjects.push(new Coin(3725,250));
      Mario.instObjects.push(new Coin(3700,250));
      Mario.instObjects.push(new Coin(2050,300));
      Mario.instObjects.push(new Coin(2100,300));
      Mario.instObjects.push(new Coin(2000,300));
      Mario.instObjects.push(new Coin(1400,300));
      Mario.instObjects.push(new Coin(1475,300));
      Mario.instObjects.push(new Coin(1125,275));
      Mario.instObjects.push(new Coin(1025,275));
      Mario.instObjects.push(new Coin(1075,250));
      Mario.instEnemies.push(new Goomba(450,200));
      Mario.instEnemies.push(new Goomba(850,325));
      Mario.instEnemies.push(new TroopaRed(1250,325));
      Mario.instEnemies.push(new PPlant(1550,250));
      Mario.instEnemies.push(new PPlant(1900,250));
      Mario.instEnemies.push(new PPlant(3375,300));
      Mario.instEnemies.push(new PPlant(3700,250));
      Mario.instEnemies.push(new TroopaRed(3175,200));
      Mario.instEnemies.push(new FlyRed(2975,225));
      Mario.instEnemies.push(new TroopaGreen(2700,275));
      Mario.instEnemies.push(new Goomba(2525,200));
      Mario.instEffects.push(new Back(4));
   }
}