package objects.levelMakes
{
   import objects.*;
   
   public function MakeLevel3_3() : void
   {
      Mario.levelGenre = 1;
      Mario.musika = 1;
      Mario.level[0] = "                                                       23            23              23                    45                   23              23  23  23  23                                                                                        ";
      Mario.level[1] = "                                                       45            23              45                                         23              45  45  45  45                                                                                        ";
      Mario.level[2] = "                                                                     45                                                         45                                                                                                                    ";
      Mario.level[3] = "                                                                                                                                                                                                                                                      ";
      Mario.level[4] = "                                                                                                                                                                                                                                                      ";
      Mario.level[5] = "                                                                                                                                                                                                                                                      ";
      Mario.level[6] = "                                                                                                                                                                                                                                                      ";
      Mario.level[7] = "                                           01                                                                                   01                                                                                                                    ";
      Mario.level[8] = "                               01          23                                01                 01                              23                                               01                                                                   ";
      Mario.level[9] = "      01       cddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddde     MQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ";
      Mario.level[10] = "    0123       fgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggh                                                        ";
      Mario.level[11] = "    232301     fgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggh                                                        ";
      Mario.level[12] = "    232323     fgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggh                                                        ";
      Mario.level[13] = "    232323     fgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggh                                                        ";
      Mario.level[14] = "    232323     fgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggh                                                        ";
      Mario.levelWid = Mario.level[0].length;
      Mario.levelHei = Mario.level.length;
      Mario.Hud.Time = 320;
      Mario.layerWall.addChild(AddGraphic(2425,125,"back_crystal_3"));
      Mario.layerWall.addChild(AddGraphic(4150,125,"back_crystal_3"));
      Mario.layerWall.addChild(AddGraphic(3250,125,"back_crystal_3"));
      Mario.layerWall.addChild(AddGraphic(2750,50,"back_crystal_2"));
      Mario.layerWall.addChild(AddGraphic(425,50,"back_crystal_2"));
      Mario.layerWall.addChild(AddGraphic(1425,50,"back_crystal_2"));
      Mario.layerWall.addChild(AddGraphic(2025,125,"back_crystal_1"));
      Mario.layerWall.addChild(AddGraphic(3675,125,"back_crystal_1"));
      Mario.layerWall.addChild(AddGraphic(4500,125,"back_crystal_1"));
      Mario.drawLevel();
      Player.ResetPlayer(160,125);
      Mario.instObjects.push(new ElevatorLoop(300,300,25,"elevator_1",-2));
      Mario.instObjects.push(new ElevatorLoop(300,75,25,"elevator_1",-2));
      Mario.instObjects.push(new ElevatorLoop(50,125,25,"elevator_1",2));
      Mario.instObjects.push(new ElevatorLoop(50,300,25,"elevator_1",2));
      Mario.instBlocks.push(new Bonus(50,25,2,true));
      Mario.instBlocks.push(new Bonus(25,25,4,true));
      Mario.instBlocks.push(new Bonus(75,25,3,true));
      Mario.instEnemies.push(new PStatic(975,200));
      Mario.instEnemies.push(new PStatic(950,200));
      Mario.instEnemies.push(new PStatic(925,200));
      Mario.instEnemies.push(new PStatic(900,200));
      Mario.instEnemies.push(new PStatic(1400,200));
      Mario.instEnemies.push(new PStatic(1375,200));
      Mario.instEnemies.push(new PStatic(1425,200));
      Mario.instEnemies.push(new PStatic(1350,200));
      Mario.instEnemies.push(new PStatic(1775,200));
      Mario.instEnemies.push(new PStatic(1750,200));
      Mario.instEnemies.push(new PStatic(1725,200));
      Mario.instEnemies.push(new PStatic(1700,200));
      Mario.instEnemies.push(new PStatic(2725,200));
      Mario.instEnemies.push(new PStatic(2700,200));
      Mario.instEnemies.push(new PStatic(2675,200));
      Mario.instEnemies.push(new PStatic(2650,200));
      Mario.instEnemies.push(new PStatic(3650,200));
      Mario.instEnemies.push(new PStatic(3675,200));
      Mario.instEnemies.push(new PStatic(3750,200));
      Mario.instEnemies.push(new PStatic(3775,200));
      Mario.instEnemies.push(new PStatic(3875,200));
      Mario.instEnemies.push(new PStatic(3850,200));
      Mario.instEnemies.push(new Spiny(4100,200));
      Mario.instEnemies.push(new Spiny(4150,200));
      Mario.instEnemies.push(new Spiny(4200,200));
      Mario.instEnemies.push(new Spiny(3050,200));
      Mario.instEnemies.push(new Spiny(2325,200));
      Mario.instEnemies.push(new Spiny(2275,200));
      Mario.instEnemies.push(new Spiny(1825,200));
      Mario.instEnemies.push(new Spiny(725,200));
      Mario.instEnemies.push(new BBeetle(675,200));
      Mario.instEnemies.push(new BBeetle(625,200));
      Mario.instEnemies.push(new BBeetle(1650,200));
      Mario.instEnemies.push(new BBeetle(1600,200));
      Mario.instEnemies.push(new BBeetle(2225,200));
      Mario.instEnemies.push(new BBeetle(3000,200));
      Mario.instEnemies.push(new BBeetle(3100,200));
      Mario.instEnemies.push(new BBeetle(4050,200));
      Mario.instEnemies.push(new BBeetle(4250,200));
      Mario.instEnemies.push(new FlyGreen(4250,150));
      Mario.instEnemies.push(new FlyGreen(3600,150));
      Mario.instEnemies.push(new FlyGreen(3550,150));
      Mario.instEnemies.push(new FlyGreen(3575,150));
      Mario.instEnemies.push(new FlyGreen(2700,150));
      Mario.instEnemies.push(new FlyGreen(2175,150));
      Mario.instEnemies.push(new FlyGreen(1300,150));
      Mario.instEnemies.push(new FlyGreen(525,150));
      Mario.instObjects.push(new Finish(4925,200));
      Mario.instObjects.push(new Coin(4450,125));
      Mario.instObjects.push(new Coin(4425,125));
      Mario.instObjects.push(new Coin(3925,150));
      Mario.instObjects.push(new Coin(3900,150));
      Mario.instObjects.push(new Coin(3825,150));
      Mario.instObjects.push(new Coin(3800,150));
      Mario.instObjects.push(new Coin(3725,150));
      Mario.instObjects.push(new Coin(3700,150));
      Mario.instObjects.push(new Coin(3625,150));
      Mario.instObjects.push(new Coin(3600,150));
      Mario.instObjects.push(new Coin(3225,125));
      Mario.instObjects.push(new Coin(3200,125));
      Mario.instObjects.push(new Coin(3200,100));
      Mario.instObjects.push(new Coin(3225,100));
      Mario.instObjects.push(new Coin(2425,125));
      Mario.instObjects.push(new Coin(2400,125));
      Mario.instObjects.push(new Coin(1950,125));
      Mario.instObjects.push(new Coin(1925,125));
      Mario.instObjects.push(new Coin(1750,125));
      Mario.instObjects.push(new Coin(1725,125));
      Mario.instObjects.push(new Coin(1400,125));
      Mario.instObjects.push(new Coin(1375,125));
      Mario.instObjects.push(new Coin(775,125));
      Mario.instObjects.push(new Coin(800,125));
      Mario.instObjects.push(new Coin(1075,100));
      Mario.instObjects.push(new Coin(1100,100));
      Mario.instBlocks.push(new Brick(2800,125));
      Mario.instBlocks.push(new Brick(2825,125));
      Mario.instBlocks.push(new Brick(2025,125));
      Mario.instBlocks.push(new Brick(1475,125));
      Mario.instBlocks.push(new Brick(1500,125));
      Mario.instBlocks.push(new Bonus(575,125,1));
      Mario.instBlocks.push(new Bonus(1275,125,1));
      Mario.instBlocks.push(new Bonus(1250,125,1));
      Mario.instBlocks.push(new Bonus(2250,125,1));
      Mario.instBlocks.push(new Bonus(2575,125,1));
      Mario.instBlocks.push(new Bonus(3450,125,1));
      Mario.instBlocks.push(new Bonus(3400,125,1));
      Mario.instBlocks.push(new Bonus(3425,125,3));
      Mario.instBlocks.push(new Bonus(4100,125,3));
      Mario.instBlocks.push(new Bonus(4000,125,2));
      Mario.instObjects.push(new Coin(4700,175));
      Mario.instObjects.push(new Coin(4700,150));
      Mario.instObjects.push(new Coin(4675,150));
      Mario.instObjects.push(new Coin(4675,175));
      Mario.instEnemies.push(new PFlame(775,175));
      Mario.instEnemies.push(new PFlame(3900,50,-1));
      Mario.instEnemies.push(new PPlant(3800,50,-1));
      Mario.instEnemies.push(new PPlant(3700,50,-1));
      Mario.instEnemies.push(new PFlame(3600,50,-1));
      Mario.instEnemies.push(new PFlame(2675,25,-1));
      Mario.instEnemies.push(new PFlame(2125,50,-1));
      Mario.instEnemies.push(new PFlame(1725,75,-1));
      Mario.instEnemies.push(new PFlame(1375,50,-1));
      Mario.instEnemies.push(new PPlant(1075,150));
      Mario.instEnemies.push(new PPlant(1925,175));
      Mario.instEnemies.push(new PPlant(2400,175));
      Mario.instEnemies.push(new PPlant(3200,150));
      Mario.instEnemies.push(new PPlant(4425,175));
      Mario.instEffects.push(new Back(1));
   }
}