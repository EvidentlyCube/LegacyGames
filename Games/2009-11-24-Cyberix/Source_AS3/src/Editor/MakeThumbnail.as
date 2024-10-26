// ActionScript file
package Editor{
	import Classes.BGHandler;
	import Classes.Interactivers.*;
	import Classes.Items.*;
	import Classes.TLevel;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	public function MakeThumbnail(data:String, small:Boolean = false, onlyValidate: Boolean = false):BitmapData{
		TLevel.Clear()
		TPlayer.playerCount = 0
		var space:int
		var arr:Array
		var i:uint
		var j:uint
		var k:uint
		var l:uint
		var tile:TField
		var len:uint
		var temp:uint
		//PACOMIX LEVEL DATA
		if (data.substr(0,6) == "PMLBEG"){
			data = data.substring(6)
		} else {
			throw new Error(data)
		}

		//LEVEL AUTHOR
		len = TextToNum(data.substr(0,1))
		TLevel.authorName = data.substr(1,len)
		data = data.substring(len + 1)

		//LEVEL NAME
		len = TextToNum(data.substr(0,1))
		TLevel.levelName = data.substr(1,len)
		data = data.substring(len + 1)

		//LEVEL SIZE
		TLevel.wid = TextToNum(data.substr(0,1))
		TLevel.hei = TextToNum(data.substr(1,1))
		data = data.substring(2)

		//BACKGROUND ID
		//BACKGROUND ANIMATION
		BGHandler.Reset(TextToNum(data.substr(1,2)),TextToNum(data.substr(3,2)),TextToNum(data.substr(0,1)))
		data = data.substring(5)


		//FLOOR DATA
		for (j = 0;j < TLevel.hei;j++){
			for (i = 0;i < TLevel.wid;i++){
				temp = TextToNum(data.substr(0,1))
				data = data.substring(1)
				if (temp > 0){
					TLevel.addFloor(i,j,temp)
				}
			}
		}


		//WALL DATA
		space=-1
		while(true){
			temp = TextToNum(data.substr(0,2))
			data = data.substring(2)
			if (temp == 0){break}
			space += temp
			temp = TextToNum(data.substr(0,1)) + 70
			data = data.substring(1)
			i = space%TLevel.wid
			j = Math.floor(space / TLevel.wid)
			i *= 24
			j *= 24
			TLevel.Set(i,j,new TWall(i,j,temp))
		}

		//ITEM DATA
		space=-1
		while(true){
			temp = TextToNum(data.substr(0,2))
			data = data.substring(2)
			if (temp == 0){break}
			space += temp
			temp = TextToNum(data.substr(0,1)) + 140
			data = data.substring(1)
			i = space%TLevel.wid
			j = Math.floor(space / TLevel.wid)
			i *= 24
			j *= 24
			switch(temp){
				case(160): TLevel.Set(i,j,new TExit(i,j));break;
				case(161): TLevel.Set(i,j,new TStopper(i,j));break;
				case(162): TLevel.Set(i,j,new TBouncerH(i,j,0));break;
				case(163): TLevel.Set(i,j,new TBouncerH(i,j,1));break;
				case(164): TLevel.Set(i,j,new TBouncerV(i,j,0));break;
				case(165): TLevel.Set(i,j,new TBouncerV(i,j,1));break;
				case(166): TLevel.Set(i,j,new TBouncerD(i,j,0));break;
				case(167): TLevel.Set(i,j,new TBouncerD(i,j,1));break;
				case(168): TLevel.Set(i,j,new TCannon(i,j,0));break;
				case(169): TLevel.Set(i,j,new TCannon(i,j,1));break;
				case(170): TLevel.Set(i,j,new TCannon(i,j,2));break;
				case(171): TLevel.Set(i,j,new TCannon(i,j,3));break;
				case(172): TLevel.Set(i,j,new TMine(i,j));break;
				case(173):
					k = TextToNum(data.substr(0,1))
					l = TextToNum(data.substr(1,1))
					data = data.substring(2)
					TLevel.Set(i,j,new TTeleport(i,j,k * 24,l * 24));break;
					break;
				case(174):
					k = TextToNum(data.substr(0,1))
					l = TextToNum(data.substr(1,1))
					data = data.substring(2)
					TLevel.Set(i,j,new TButtonShot(i,j,k * 24,l * 24));break;
					break;
				case(175):
					temp = TextToNum(data.substr(0,2))
					k = TextToNum(data.substr(2,1))
					l = TextToNum(data.substr(3,1))
					data = data.substring(4)
					TLevel.Set(i,j,new TButtonItem(i,j,k * 24,l * 24,temp));break;
					break
				case(176): TLevel.Set(i,j,new TArrow(i,j,0));break;
				case(177): TLevel.Set(i,j,new TArrow(i,j,1));break;
				case(178): TLevel.Set(i,j,new TArrow(i,j,2));break;
				case(179): TLevel.Set(i,j,new TArrow(i,j,3));break;
				case(180): TLevel.Set(i,j,new TArrow(i,j,4));break;
				case(181): TLevel.Set(i,j,new TArrow(i,j,5));break;
				case(182): TLevel.Set(i,j,new TArrow(i,j,6));break;
				case(183): TLevel.Set(i,j,new TArrow(i,j,7));break;
				case(184): TLevel.Set(i,j,new TArrow(i,j,8));break;
				case(185): TLevel.Set(i,j,new TArrow(i,j,9));break;
				case(186): new TPlayer(i,j);break;
				case(187): TLevel.Set(i,j,new TWallPierced(i,j,0));break;
				case(188): TLevel.Set(i,j,new TWallPierced(i,j,1));break;
				case(189): TLevel.Set(i,j,new TWallPierced(i,j,2));break;
				case(190): TLevel.Set(i,j,new TRounder(i,j,0));break;
				case(191): TLevel.Set(i,j,new TRounder(i,j,1));break;
				case(192): TLevel.Set(i,j,new TDropper(i,j));break;
				default: if(temp >= 140 && temp < 160){TLevel.Set(i,j,new TBonus(i,j,temp));}break;
			}
		}

		//OBJECT DATA
		space=-1
		while(true){
			temp = TextToNum(data.substr(0,2))
			data = data.substring(2)
			if (temp == 0){break}
			space += temp
			temp = TextToNum(data.substr(0,1)) + 200
			data = data.substring(1)
			i = space%TLevel.wid
			j = Math.floor(space / TLevel.wid)
			switch(temp){
				case(201):new TCrate(i * 24,j * 24);break;
				case(202):new TCrateSteel(i * 24,j * 24);break;
				case(203):new TIceCrate(i * 24,j * 24);break;
				case(204):new TIceCrateSteel(i * 24,j * 24);break;
				case(205):new TWaller(i * 24,j * 24);break;
				case(206): new TPlayer(i * 24,j * 24);break;
				case(207): new TEnOrtho(i * 24,j * 24,1,0);break;
				case(208): new TEnOrtho(i * 24,j * 24,0,1);break;
				case(209): new TEnOrtho(i * 24,j * 24,-1,0);break;
				case(210): new TEnOrtho(i * 24,j * 24,0,-1);break;
				case(211): new TEnTurner(i * 24,j * 24,1,0,1);break;
				case(212): new TEnTurner(i * 24,j * 24,0,1,1);break;
				case(213): new TEnTurner(i * 24,j * 24,-1,0,1);break;
				case(214): new TEnTurner(i * 24,j * 24,0,-1,1);break;
				case(215): new TEnTurner(i * 24,j * 24,1,0,-1);break;
				case(216): new TEnTurner(i * 24,j * 24,0,1,-1);break;
				case(217): new TEnTurner(i * 24,j * 24,-1,0,-1);break;
				case(218): new TEnTurner(i * 24,j * 24,0,-1,-1);break;
				case(219): new TEnWaller(i * 24,j * 24,1,0,1);break;
				case(220): new TEnWaller(i * 24,j * 24,0,1,1);break;
				case(221): new TEnWaller(i * 24,j * 24,-1,0,1);break;
				case(222): new TEnWaller(i * 24,j * 24,0,-1,1);break;
				case(223): new TEnWaller(i * 24,j * 24,1,0,-1);break;
				case(224): new TEnWaller(i * 24,j * 24,0,1,-1);break;
				case(225): new TEnWaller(i * 24,j * 24,-1,0,-1);break;
				case(226): new TEnWaller(i * 24,j * 24,0,-1,-1);break;
				case(227): new TEnMimic(i * 24,j * 24);break;
			}
		}

		if (data != "PMLEND"){
			throw new Error(data + " - That was left")
		}
		if (onlyValidate) {
			TLevel.Clear();
			return null;
		}
		TLevel.FixSize()
		var b:BitmapData
		var mLEV:Matrix = new Matrix
		var shap:Shape = new Shape
		if (small){
			b = new BitmapData(76,76)
			shap.graphics.beginFill(0)
			shap.graphics.drawRect(0,0,76,76)
			shap.graphics.endFill()
			mLEV.scale(0.126,0.126)
		} else {
			b = new BitmapData(600,600)
			shap.graphics.beginFill(0)
			shap.graphics.drawRect(0,0,600,600)
			shap.graphics.endFill()
		}
		Game.addLayer(Game.layerBg)
		Game.addLayer(Game.layerFloor)
		Game.addLayer(Game.layerItems)
		Game.addLayer(Game.layerObjects)
		Game.addLayer(Game.layerEffects)
		for(var w:int = Game.layerEffects.numChildren - 1;w >= 0;w--){
			if (Game.layerEffects.getChildAt(w) as TPlayerAppear){
				Game.layerEffects.removeChildAt(w)
			}
		}
		Game.addLayer(Game.layerPlayer)

		b.draw(shap)
		b.draw(Game.display,mLEV)

		Game.removeLayer(Game.layerBg)
		Game.removeLayer(Game.layerFloor)
		Game.removeLayer(Game.layerItems)
		Game.removeLayer(Game.layerObjects)
		Game.removeLayer(Game.layerEffects)
		Game.removeLayer(Game.layerPlayer)

		TLevel.Clear()
		return b;
	}
}