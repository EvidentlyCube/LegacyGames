package objects.levelMakes
{
   import objects.*;
   
   public function MakeLevel2_1() : void
   {
      Mario.levelGenre = 0;
      Mario.musika = 0;
      Mario.generateBackground(0);
      Mario.level[0] = "                                                                                                                                                                             ";
      Mario.level[1] = "                                                                                                                                                                             ";
      Mario.level[2] = "                                                                                                                                                                             ";
      Mario.level[3] = "                                                                                                                                                                             ";
      Mario.level[4] = "                                                                                                                                                                             ";
      Mario.level[5] = "                                                                                                                                                                             ";
      Mario.level[6] = "                                                                                                                                                                             ";
      Mario.level[7] = "                                                                                                                                                                             ";
      Mario.level[8] = "                                                                        cde                                                                                                  ";
      Mario.level[9] = "                      01                         01        01           fgh             cdddde      cddddddde                                                                ";
      Mario.level[10] = "                      23                         23        23    cdde   ijk   cddde     fggggh      fgggggggh    01                                                          ";
      Mario.level[11] = "                01    23                         23        23    fggh         fgggh     ijjjjk      ijjjjjjjk    23                                                          ";
      Mario.level[12] = "      01cdddddde23cdde23                         23cdddddde23    ijjk         ijjjk                              23   cddddddddddddddddddddddddddddddddddddddddddddddddddddde";
      Mario.level[13] = "ddddde23fggggggh23fggh23                         23fggggggh23                                                    23   fgggggggggggggggggggggggggggggggggggggggggggggggggggggh";
      Mario.level[14] = "gggggh23fggggggh23fggh23                         23fggggggh23                                                    23   fgggggggggggggggggggggggggggggggggggggggggggggggggggggh";
      Mario.levelWid = Mario.level[0].length;
      Mario.levelHei = Mario.level.length;
      Mario.Hud.Time = 320;
      Player.ResetPlayer(50,275);
      Mario.instEffects.push(new Background(2875,125,"back_clouds_8",0.81));
      Mario.instEffects.push(new Background(1950,175,"back_clouds_6",0.56));
      Mario.instEffects.push(new Background(925,150,"back_clouds_5",0.5));
      Mario.instEffects.push(new Background(275,150,"back_clouds_4",0.5));
      Mario.instEffects.push(new Background(2450,200,"back_clouds_1",0.32));
      Mario.instEffects.push(new Background(2225,75,"back_clouds_3",0.3));
      Mario.instEffects.push(new Background(2850,50,"back_clouds_2",0.25));
      Mario.instEffects.push(new Background(1450,25,"back_clouds_2",0.18));
      Mario.instEffects.push(new Background(3700,25,"back_clouds_2",0.17));
      Mario.instEffects.push(new Background(2725,250,"back_clouds_3",0.14));
      Mario.instEffects.push(new Background(3975,175,"back_clouds_2",0.12));
      Mario.instEffects.push(new Background(1700,275,"back_clouds_3",0.09));
      Mario.instEffects.push(new Background(925,125,"back_clouds_1",0.09));
      Mario.instEffects.push(new Background(100,50,"back_clouds_1",0.05));
      Mario.instEffects.push(new Cloud(3875,150));
      Mario.instEffects.push(new Cloud(4075,50));
      Mario.instEffects.push(new Cloud(3250,25));
      Mario.instEffects.push(new Cloud(375,100));
      Mario.instEffects.push(new Cloud(875,50));
      Mario.instEffects.push(new Cloud(1850,50));
      Mario.instEffects.push(new Cloud(2075,0));
      Mario.instEffects.push(new Cloud(2400,50));
      Mario.instEffects.push(new Cloud(2750,25));
      Mario.layerWall.addChild(AddGraphic(3475,125,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(3275,175,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(3150,200,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(2650,150,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(2500,100,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(2025,125,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(1425,175,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(500,150,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(450,200,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(75,225,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(75,250,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(500,175,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(450,250,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(450,225,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(1425,200,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(2025,150,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(2650,175,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(2500,125,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(3150,225,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(3275,225,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(3275,200,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(3475,150,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(3475,175,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(3475,200,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(1425,275,"back_fence_3"));
      Mario.layerWall.addChild(AddGraphic(1725,225,"back_fence_3"));
      Mario.layerWall.addChild(AddGraphic(2350,200,"back_fence_3"));
      Mario.layerWall.addChild(AddGraphic(3075,275,"back_fence_3"));
      Mario.layerWall.addChild(AddGraphic(2925,275,"back_fence_1"));
      Mario.layerWall.addChild(AddGraphic(2175,200,"back_fence_1"));
      Mario.layerWall.addChild(AddGraphic(1600,225,"back_fence_1"));
      Mario.layerWall.addChild(AddGraphic(1275,275,"back_fence_1"));
      Mario.layerWall.addChild(AddGraphic(200,275,"back_fence_1"));
      Mario.layerWall.addChild(AddGraphic(225,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(250,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(275,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(300,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(325,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(350,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(375,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(1375,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(1400,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(1350,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(1325,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(1300,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(1700,225,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(1675,225,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(1650,225,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(1625,225,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(2200,200,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(2225,200,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(2250,200,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(2275,200,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(2300,200,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(2325,200,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(3050,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(3025,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(3000,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(2975,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(2950,275,"back_fence_2"));
      Mario.instObjects.push(new ElevatorBounce(625,250,75,"elevator_3",3));
      Mario.instEnemies.push(new PFlame(2825,225));
      Mario.instEnemies.push(new PPlant(150,275));
      Mario.instEnemies.push(new PPlant(400,250));
      Mario.instEnemies.push(new PPlant(550,200));
      Mario.instEnemies.push(new PPlant(1225,200));
      Mario.instEnemies.push(new PPlant(1475,200));
      Mario.instObjects.push(new Finish(3350,275));
      Mario.instEnemies.push(new FlyGreen(1450,250));
      Mario.instEnemies.push(new FlyRed(2125,150));
      Mario.instEnemies.push(new FlyRed(2425,125));
      Mario.instEnemies.push(new TroopaRed(2275,200));
      Mario.instEnemies.push(new TroopaRed(2700,200));
      Mario.instEnemies.push(new TroopaRed(1825,175));
      Mario.instEnemies.push(new Spiny(3200,275));
      Mario.instEnemies.push(new Spiny(3150,275));
      Mario.layerWall.addChild(AddGraphic(500,250,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(500,275,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(500,225,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(75,300,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(1425,275,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(1425,250,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(2025,225,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(2025,200,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(1825,175,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(2500,200,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(2500,175,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(3150,275,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(3475,275,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(3475,250,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(3275,275,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(2650,200,"back_tree_2"));
      Mario.layerWall.addChild(AddGraphic(2500,150,"back_tree_2"));
      Mario.layerWall.addChild(AddGraphic(2025,175,"back_tree_2"));
      Mario.layerWall.addChild(AddGraphic(450,275,"back_tree_2"));
      Mario.layerWall.addChild(AddGraphic(500,200,"back_tree_2"));
      Mario.layerWall.addChild(AddGraphic(75,275,"back_tree_2"));
      Mario.layerWall.addChild(AddGraphic(1425,225,"back_tree_2"));
      Mario.layerWall.addChild(AddGraphic(3275,250,"back_tree_2"));
      Mario.layerWall.addChild(AddGraphic(3150,250,"back_tree_2"));
      Mario.layerWall.addChild(AddGraphic(3475,225,"back_tree_2"));
      Mario.instObjects.push(new Coin(350,200));
      Mario.instObjects.push(new Coin(325,200));
      Mario.instObjects.push(new Coin(225,200));
      Mario.instObjects.push(new Coin(200,200));
      Mario.instObjects.push(new Coin(1375,225));
      Mario.instObjects.push(new Coin(1350,225));
      Mario.instObjects.push(new Coin(1325,150));
      Mario.instObjects.push(new Coin(1325,175));
      Mario.instObjects.push(new Coin(1400,150));
      Mario.instObjects.push(new Coin(1400,175));
      Mario.instObjects.push(new Coin(1400,200));
      Mario.instObjects.push(new Coin(1325,200));
      Mario.instObjects.push(new Coin(1375,125));
      Mario.instObjects.push(new Coin(1350,125));
      Mario.instObjects.push(new Coin(1650,175));
      Mario.instObjects.push(new Coin(1675,175));
      Mario.instObjects.push(new Coin(1825,125));
      Mario.instObjects.push(new Coin(1975,200));
      Mario.instObjects.push(new Coin(2000,200));
      Mario.instObjects.push(new Coin(2025,200));
      Mario.instObjects.push(new Coin(2000,75));
      Mario.instObjects.push(new Coin(2225,150));
      Mario.instObjects.push(new Coin(2250,150));
      Mario.instObjects.push(new Coin(2275,150));
      Mario.instObjects.push(new Coin(2300,150));
      Mario.instObjects.push(new Coin(2575,175));
      Mario.instObjects.push(new Coin(2625,175));
      Mario.instObjects.push(new Coin(2600,75));
      Mario.instObjects.push(new Coin(2825,150));
      Mario.instObjects.push(new Coin(2850,150));
      Mario.instObjects.push(new Coin(3050,150));
      Mario.instObjects.push(new Coin(3125,150));
      Mario.instObjects.push(new Coin(3100,125));
      Mario.instObjects.push(new Coin(3075,125));
      Mario.instObjects.push(new Coin(3025,125));
      Mario.instObjects.push(new Coin(3150,125));
      Mario.drawLevel();
      Mario.instBlocks.push(new Bonus(475,200,1));
      Mario.instBlocks.push(new Bonus(275,200,1));
      Mario.instBlocks.push(new Bonus(2575,125,1));
      Mario.instBlocks.push(new Bonus(1975,150,1));
      Mario.instBlocks.push(new Bonus(1325,225,1));
      Mario.instBlocks.push(new Bonus(1400,225,1));
      Mario.instBlocks.push(new Bonus(2550,125,3));
      Mario.instBlocks.push(new Bonus(3025,200,1,true));
      Mario.instBlocks.push(new Bonus(3075,200,1,true));
      Mario.instBlocks.push(new Bonus(3150,200,2));
      Mario.instBlocks.push(new Brick(3125,200));
      Mario.instBlocks.push(new Brick(3100,200));
      Mario.instBlocks.push(new Brick(3050,200));
      Mario.instBlocks.push(new Brick(3000,200));
      Mario.instBlocks.push(new Brick(2625,125));
      Mario.instBlocks.push(new Brick(2650,125));
      Mario.instBlocks.push(new Brick(2000,150));
      Mario.instBlocks.push(new Brick(2025,150));
      Mario.instBlocks.push(new Brick(1325,125));
      Mario.instBlocks.push(new BrickMulti(1400,125));
      Mario.instBlocks.push(new BrickMulti(2600,125));
      Mario.instBlocks.push(new BrickMulti(3175,200));
   }
}