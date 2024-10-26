package objects.levelMakes
{
   public function MakeLevel(param1:uint) : void
   {
      switch(param1)
      {
         case 0:
            MakeLevel1_1();
            break;
         case 1:
            MakeLevel1_2();
            break;
         case 2:
            MakeLevel1_3();
            break;
         case 3:
            MakeLevel1_4();
            break;
         case 4:
            MakeLevel2_1();
            break;
         case 5:
            MakeLevel2_2();
            break;
         case 6:
            MakeLevel2_3();
            break;
         case 7:
            MakeLevel2_4();
            break;
         case 8:
            MakeLevel3_1();
            break;
         case 9:
            MakeLevel3_2();
            break;
         case 10:
            MakeLevel3_3();
            break;
         case 11:
            MakeLevel3_4();
            break;
         case 12:
            MakeLevel4_1();
            break;
         case 13:
            MakeLevel4_2();
            break;
         case 14:
            MakeLevel4_3();
            break;
         case 15:
            MakeLevel4_4();
            break;
         case 16:
            MakeLevel4_5();
            break;
         case 17:
            MakeLevel4_6();
      }
      if(Mario.levelid < 17)
      {
         Mario.sequence = 0;
         Mario.self.waitScreen();
      }
      Mario.stepping = true;
   }
}
