package objects.levelMakes
{
   import objects.*;
   
   public function MakeLevel2_4() : void
   {
      Mario.levelGenre = 3;
      Mario.musika = 2;
      Mario.level[0] = "ABABABABABABAB            ABABABAB  AB CABAB    ABABABABABABC  DABABAB                ABAB      CABABD       ABABC ABABABABAB       ABABABABABABABAB            ABABD  CABAB                   DABABC  DABC ABABABABABABABABABABABABABC";
      Mario.level[1] = "BABABABABAB                     CABABABD                    DABAB                        DABABABAB               DABABABC              ABABABC                     ABABABAB                      ABABABABABABD  CABABD                D";
      Mario.level[2] = "AB                                                             CAB                         AB                        AB                   AB                         DABC                         ABABABAB        ABAB                C";
      Mario.level[3] = "C                                                               CAB                                                   D                    D                          CAB                          ABABC           ABC                D";
      Mario.level[4] = "                                                                                                                                                                      AB                           DAB              AB                C";
      Mario.level[5] = "                                                                                                                                                                      DC                           AB               CD                D";
      Mario.level[6] = "                                                                                                                                                                      AB                           CD               AB                C";
      Mario.level[7] = "                                                     01                                                    01                                                         CAB                          AB                                 D";
      Mario.level[8] = "                                                     23DABACOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOEG23                                                         ABAB                        ABD                                 C";
      Mario.level[9] = "                                 01            01    23ABD                                               HJ23                                                         DABABABABABABABABABABABABABABAB           EFFFFGOOOOOOOOOOOOOOOOD";
      Mario.level[10] = "                                 23            23    23CAB                                               HJ23                                                         ABUU UUUUUUUUUUUUUU UUUUUUUUUDC         EFKIIIIJ                C";
      Mario.level[11] = "EFG              EG01EG          23      01    23    23D                                                 HJ23EFFG                                                                                           EFKIIIIIIJ                D";
      Mario.level[12] = "HIJ              HJ23HJ          23      23    23    23AB                                                HJ23HIIJ                                                                                         EFKIIIIIIIIJ                C";
      Mario.level[13] = "HILFFFFFG    EFFFKJ23HLFFFG    EG23EG    23    23    23DC            MMM              MM M              EKJ23HIILGUUUUUUUUUUUUUUUUUUEFGUUUUUUUUUUUUUUUUUUUUUUUUEFFGUUUEFFFGUUUUUUUU UEFFGUUUEGUU EFFFFFFFFKIIIIIIIIIIJ                D";
      Mario.level[14] = "HIIIIIIIJ    HIIIIJ23HIIIIJ    HJ23HJ    23    23    23ABD         MMMMMM            MMMMMM           EFKILFFKIIILGUUUUUUUUUUUUUUEFFKILFGUUUEFGUUUUUUUUUUEFFFFFKIILFFFKIIILFGUUUUEFFFKIILGUUHLGUEKIIIIIIIIIIIIIIIIIIIJ                C";
      Mario.levelWid = Mario.level[0].length;
      Mario.levelHei = Mario.level.length;
      Mario.drawLevel();
      Mario.Hud.Time = 320;
      Player.ResetPlayer(Mario.checkPoint == 7 ? 5000 : 25,225);
      Mario.instEnemies.push(new Bowser(5575,150,5350,5,3,0,0,0));
      Mario.instBlocks.push(new Bonus(450,175,1));
      Mario.instBlocks.push(new BrickMulti(875,225));
      Mario.instBlocks.push(new Brick(800,225));
      Mario.instBlocks.push(new Bonus(525,175,0));
      Mario.instBlocks.push(new Brick(1875,100));
      Mario.instBlocks.push(new Brick(1975,100));
      Mario.instBlocks.push(new Brick(2075,100));
      Mario.instBlocks.push(new Bonus(1550,75,2,true));
      Mario.instBlocks.push(new Brick(2900,225));
      Mario.instBlocks.push(new Brick(2925,225));
      Mario.instBlocks.push(new Brick(2950,225));
      Mario.instBlocks.push(new Brick(2975,225));
      Mario.instBlocks.push(new Brick(3000,225));
      Mario.instBlocks.push(new Brick(3050,225));
      Mario.instBlocks.push(new Brick(3075,225));
      Mario.instBlocks.push(new Brick(3100,225));
      Mario.instBlocks.push(new Brick(3125,225));
      Mario.instBlocks.push(new Brick(3150,225));
      Mario.instBlocks.push(new Brick(3175,225));
      Mario.instBlocks.push(new Brick(3200,225));
      Mario.instBlocks.push(new Brick(3225,225));
      Mario.instBlocks.push(new Brick(3275,225));
      Mario.instBlocks.push(new Brick(3300,225));
      Mario.instBlocks.push(new Brick(3325,225));
      Mario.instBlocks.push(new Brick(3350,225));
      Mario.instBlocks.push(new Brick(3375,225));
      Mario.instBlocks.push(new Brick(3425,225));
      Mario.instBlocks.push(new Brick(3450,225));
      Mario.instBlocks.push(new Brick(3475,225));
      Mario.instBlocks.push(new Brick(3500,225));
      Mario.instBlocks.push(new Brick(3525,225));
      Mario.instBlocks.push(new Brick(3550,225));
      Mario.instBlocks.push(new Brick(3575,225));
      Mario.instBlocks.push(new Brick(3600,225));
      Mario.instBlocks.push(new Brick(3625,225));
      Mario.instBlocks.push(new Brick(3675,225));
      Mario.instBlocks.push(new Brick(3700,225));
      Mario.instBlocks.push(new Brick(3750,225));
      Mario.instBlocks.push(new Brick(3775,225));
      Mario.instBlocks.push(new Brick(3800,225));
      Mario.instBlocks.push(new Brick(3825,225));
      Mario.instBlocks.push(new Brick(3875,225));
      Mario.instBlocks.push(new Brick(3900,225));
      Mario.instBlocks.push(new Brick(3925,225));
      Mario.instBlocks.push(new Brick(3950,225));
      Mario.instBlocks.push(new Brick(2900,125));
      Mario.instBlocks.push(new Brick(2925,125));
      Mario.instBlocks.push(new Brick(2950,125));
      Mario.instBlocks.push(new Brick(2975,125));
      Mario.instBlocks.push(new Brick(3000,125));
      Mario.instBlocks.push(new Brick(3025,125));
      Mario.instBlocks.push(new Brick(3075,125));
      Mario.instBlocks.push(new Brick(3100,125));
      Mario.instBlocks.push(new Brick(3125,125));
      Mario.instBlocks.push(new Brick(3150,125));
      Mario.instBlocks.push(new Brick(3175,125));
      Mario.instBlocks.push(new Brick(3200,125));
      Mario.instBlocks.push(new Brick(3250,125));
      Mario.instBlocks.push(new Brick(3275,125));
      Mario.instBlocks.push(new Brick(3300,125));
      Mario.instBlocks.push(new Brick(3350,125));
      Mario.instBlocks.push(new Brick(3375,125));
      Mario.instBlocks.push(new Brick(3400,125));
      Mario.instBlocks.push(new Brick(3425,125));
      Mario.instBlocks.push(new Brick(3450,125));
      Mario.instBlocks.push(new Brick(3500,125));
      Mario.instBlocks.push(new Brick(3525,125));
      Mario.instBlocks.push(new Brick(3550,125));
      Mario.instBlocks.push(new Brick(3575,125));
      Mario.instBlocks.push(new Brick(3600,125));
      Mario.instBlocks.push(new Brick(3650,125));
      Mario.instBlocks.push(new Brick(3675,125));
      Mario.instBlocks.push(new Brick(3700,125));
      Mario.instBlocks.push(new Brick(3725,125));
      Mario.instBlocks.push(new Brick(3750,125));
      Mario.instBlocks.push(new Brick(3775,125));
      Mario.instBlocks.push(new Brick(3800,125));
      Mario.instBlocks.push(new Brick(3825,125));
      Mario.instBlocks.push(new Brick(3850,125));
      Mario.instBlocks.push(new Brick(3875,125));
      Mario.instBlocks.push(new Brick(3900,125));
      Mario.instBlocks.push(new Brick(3950,125));
      Mario.instBlocks.push(new Brick(3975,125));
      Mario.instObjects.push(new Mill(3050,125,100,2.5,12));
      Mario.instObjects.push(new Mill(3250,225,100,2.5,43));
      Mario.instObjects.push(new Mill(3475,125,100,2.5,49));
      Mario.instObjects.push(new Mill(3725,225,100,2.5,39));
      Mario.instObjects.push(new Mill(4250,250,100,2.5,4832));
      Mario.instObjects.push(new Mill(4475,325,100,2.5,4389));
      Mario.instObjects.push(new Mill(4625,250,100,2.5,4382));
      Mario.instObjects.push(new Mill(4800,325,100,2.5,9864));
      Mario.instObjects.push(new Mill(2825,300,100,2.5,1295));
      Mario.instObjects.push(new Mill(1575,75,100,2.5,7502));
      Mario.instEnemies.push(new PFlame(475,250));
      Mario.instEnemies.push(new PFlame(825,200));
      Mario.instEnemies.push(new PPlant(1025,250));
      Mario.instEnemies.push(new PPlant(1175,200));
      Mario.instEnemies.push(new PPlant(1325,150));
      Mario.instEnemies.push(new PPlant(2675,150));
      Mario.instObjects.push(new Coin(5050,200));
      Mario.instObjects.push(new Coin(5050,225));
      Mario.instObjects.push(new Coin(5100,175));
      Mario.instObjects.push(new Coin(5100,200));
      Mario.instObjects.push(new Coin(5150,175));
      Mario.instObjects.push(new Coin(5150,150));
      Mario.instObjects.push(new Coin(5000,225));
      Mario.instObjects.push(new Coin(5000,250));
      Mario.instObjects.push(new Coin(2925,175));
      Mario.instObjects.push(new Coin(2975,175));
      Mario.instObjects.push(new Coin(3025,175));
      Mario.instObjects.push(new Coin(3075,175));
      Mario.instObjects.push(new Coin(3125,175));
      Mario.instObjects.push(new Coin(3175,175));
      Mario.instObjects.push(new Coin(3225,175));
      Mario.instObjects.push(new Coin(3275,175));
      Mario.instObjects.push(new Coin(3325,175));
      Mario.instObjects.push(new Coin(3375,175));
      Mario.instObjects.push(new Coin(3425,175));
      Mario.instObjects.push(new Coin(3475,175));
      Mario.instObjects.push(new Coin(3525,175));
      Mario.instObjects.push(new Coin(3575,175));
      Mario.instObjects.push(new Coin(3625,175));
      Mario.instObjects.push(new Coin(3675,175));
      Mario.instObjects.push(new Coin(3725,175));
      Mario.instObjects.push(new Coin(3775,175));
      Mario.instObjects.push(new Coin(3825,175));
      Mario.instObjects.push(new Coin(3875,175));
      Mario.instObjects.push(new Coin(3925,175));
      Mario.instObjects.push(new Coin(3975,175));
      Mario.instBlocks.push(new BrickMulti(3225,125));
      Mario.instBlocks.push(new BrickMulti(3400,225));
      Mario.instBlocks.push(new BrickMulti(3025,225));
      Mario.instBlocks.push(new BrickMulti(3325,125));
      Mario.instBlocks.push(new BrickMulti(3625,125));
      Mario.instBlocks.push(new BrickMulti(3650,225));
      Mario.instBlocks.push(new BrickMulti(3850,225));
      Mario.instBlocks.push(new BrickMulti(3925,125));
      Mario.instBlocks.push(new BrickMulti(4000,225));
      Mario.instBlocks.push(new Brick(4000,125));
      Mario.instBlocks.push(new Brick(3975,225));
      Mario.instObjects.push(new Coin(450,125));
      Mario.instObjects.push(new Coin(525,125));
      Mario.instObjects.push(new Coin(800,275));
      Mario.instObjects.push(new Coin(875,275));
      Mario.instObjects.push(new Coin(375,275));
      Mario.instObjects.push(new Coin(350,275));
      Mario.instObjects.push(new Coin(625,275));
      Mario.instObjects.push(new Coin(600,275));
      Mario.instObjects.push(new Coin(100,275));
      Mario.instObjects.push(new Coin(125,275));
      Mario.instObjects.push(new Coin(150,275));
      Mario.instObjects.push(new Coin(175,275));
      Mario.instEnemies.push(new JumperThrower(1575,350,-10,0.5,110,1,0));
      Mario.instEnemies.push(new JumperThrower(1975,350,-9,2,130,15,10));
      Mario.instEnemies.push(new JumperThrower(2450,350,-10,0.5,110,1,0));
      Mario.instObjects.push(new Coin(1500,150));
      Mario.instObjects.push(new Coin(1725,150));
      Mario.instObjects.push(new Coin(1875,150));
      Mario.instObjects.push(new Coin(2025,150));
      Mario.instObjects.push(new Coin(2175,150));
      Mario.instObjects.push(new Coin(2275,150));
      Mario.instObjects.push(new Coin(2450,150));
      Mario.instObjects.push(new Coin(2575,150));
      Mario.instEffects.push(new Back(3));
   }
}