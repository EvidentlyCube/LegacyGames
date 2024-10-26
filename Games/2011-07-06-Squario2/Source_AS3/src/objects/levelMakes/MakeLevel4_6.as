package objects.levelMakes
{
   import objects.*;
   
   public function MakeLevel4_6() : void
   {
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
      Mario.level[11] = "                ";
      Mario.level[12] = "dddddddddddddddd";
      Mario.level[13] = "gggggggggggggggg";
      Mario.level[14] = "gggggggggggggggg";
      Mario.levelWid = Mario.level[0].length;
      Mario.levelHei = Mario.level.length;
      Mario.drawLevel();
      Mario.Hud.Time = 320;
      Mario.instEffects.push(new Cloud(300,50));
      Mario.instEffects.push(new Cloud(0,0));
      Mario.instEffects.push(new Cloud(100,75));
      Mario.instEffects.push(new Cloud(375,25));
      Mario.layerWall.addChild(AddGraphic(100,200,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(150,175,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(300,225,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(250,75,"back_tree_4"));
      Mario.layerWall.addChild(AddGraphic(250,100,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(250,125,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(250,150,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(250,175,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(150,200,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(150,225,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(300,250,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(100,250,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(100,225,"back_tree_3"));
      Mario.layerWall.addChild(AddGraphic(250,275,"back_fence_3"));
      Mario.layerWall.addChild(AddGraphic(325,275,"back_fence_1"));
      Mario.layerWall.addChild(AddGraphic(350,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(375,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(175,275,"back_fence_1"));
      Mario.layerWall.addChild(AddGraphic(225,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(200,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(100,275,"back_fence_3"));
      Mario.layerWall.addChild(AddGraphic(0,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(75,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(50,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(25,275,"back_fence_2"));
      Mario.layerWall.addChild(AddGraphic(150,275,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(100,275,"back_tree_2"));
      Mario.layerWall.addChild(AddGraphic(150,250,"back_tree_2"));
      Mario.layerWall.addChild(AddGraphic(250,200,"back_tree_2"));
      Mario.layerWall.addChild(AddGraphic(300,275,"back_tree_2"));
      Mario.layerWall.addChild(AddGraphic(250,250,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(250,225,"back_tree_1"));
      Mario.layerWall.addChild(AddGraphic(250,275,"back_tree_1"));
      Mario.instObjects.push(new GameEnd());
      Player.ResetPlayer(0,0);
      Mario.playerControllable = false;
      Player.GFX2.alpha = 0;
      Mario.Hud.GFX.alpha = 0;
      Mario.musika = 13;
   }
}
