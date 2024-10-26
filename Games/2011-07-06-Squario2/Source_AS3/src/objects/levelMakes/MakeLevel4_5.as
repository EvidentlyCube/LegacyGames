package objects.levelMakes
{
   import objects.*;
   
   public function MakeLevel4_5() : void
   {
      Mario.level[0] = "ABABAB    CABABAB";
      Mario.level[1] = "                C";
      Mario.level[2] = "                C";
      Mario.level[3] = "                C";
      Mario.level[4] = "                C";
      Mario.level[5] = "                C";
      Mario.level[6] = "                C";
      Mario.level[7] = "                C";
      Mario.level[8] = "                C";
      Mario.level[9] = "                C";
      Mario.level[10] = "                C";
      Mario.level[11] = "                C";
      Mario.level[12] = "                C";
      Mario.level[13] = " OOOOOOOOOOOOOO C";
      Mario.level[14] = "                C";
      Mario.levelWid = Mario.level[0].length;
      Mario.levelHei = Mario.level.length;
      Mario.drawLevel();
      Mario.Hud.Time = 320;
      Player.ResetPlayer(200,0);
      Mario.instEnemies.push(new Bowser(350,200,0,9,15,15,16,3));
      Mario.instEffects.push(new Back(3));
      Mario.instObjects.push(new ElevatorBounce(25,225,25,"elevator_1",1));
      Mario.instObjects.push(new ElevatorBounce(350,125,25,"elevator_1",-1));
      Mario.instObjects.push(new LastLevel());
   }
}
