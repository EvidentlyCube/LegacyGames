package Editor{
	import Classes.Interactivers.*;
	import Classes.Items.*;
	import Classes.Scenes.TLevelScene;
	import Classes.TLevData;
	import Classes.TLevel;

	import flash.text.TextField;

	import mx.core.BitmapAsset;
	public function PlayLevel(data: String): void{
		TLevel.Clear()
		TPlayer.active = false
		var space: int
		var arr: Array
		var i: int
		var j: int
		var tile: TField
		var len: uint
		var temp: uint
		//TRAPDOORER LEVEL DATA
		if (data.substr(0, 6) == "TPDBEG"){
			data = data.substring(6)
		} else {
			throw new Error(data)
		}

		//LEVEL AUTHOR
		len = TextToNum(data.substr(0, 1))
		TLevel.authorName = data.substr(1, len)
		data = data.substring(len+1)

		//LEVEL NAME
		len = TextToNum(data.substr(0, 1))
		TLevel.levelName = data.substr(1, len)
		data = data.substring(len+1)

		//PLAYER POS
		i = TextToNum(data.substr(0, 1))-1
		j = TextToNum(data.substr(1, 1))-1
		data = data.substring(2)
		if (i >= 0){TPlayer.drop(i, j)}

		//TILES DATA
		while(true){
			i = TextToNum(data.substr(0, 1))-1
			if (i == -1){break}
			j = TextToNum(data.substr(1, 1))-1
			temp = TextToNum(data.substr(2, 1))
			data = data.substring(3)
			switch (temp){
				case(1): new TNormal(i*25, j*25);break;
				case(2): new TStrong(i*25, j*25);break;
				case(3): new TSteel(i*25, j*25);break;
				case(4): new TBlank(i*25, j*25);break;
				case(5): new TExit(i*25, j*25);break;
				case(6): new TBoom(i*25, j*25);break;
				case(7): new THori(i*25, j*25);break;
				case(8): new TDiag(i*25, j*25);break;
				case(9): new TDirt(i*25, j*25);break;
				case(10): new TDirtBlank(i*25, j*25);break;
				case(11): new TGate(i*25, j*25, 0,0);break;
				case(12): new TGate(i*25, j*25, 0,1);break;
				case(13): new TGate(i*25, j*25, 1,0);break;
				case(14): new TGate(i*25, j*25, 1,1);break;
				case(15): new TGate(i*25, j*25, 2,0);break;
				case(16): new TGate(i*25, j*25, 2,1);break;
				case(17): new TGate(i*25, j*25, 3,0);break;
				case(18): new TGate(i*25, j*25, 3,1);break;
				case(19): new TGate(i*25, j*25, 4,0);break;
				case(20): new TGate(i*25, j*25, 4,1);break;
				case(21): new TGate(i*25, j*25, 5,0);break;
				case(22): new TGate(i*25, j*25, 5,1);break;
				case(23): new TButton(i*25, j*25, 0,0);break;
				case(24): new TButton(i*25, j*25, 0,1);break;
				case(25): new TButton(i*25, j*25, 1,0);break;
				case(26): new TButton(i*25, j*25, 1,1);break;
				case(27): new TButton(i*25, j*25, 2,0);break;
				case(28): new TButton(i*25, j*25, 2,1);break;
				case(29): new TButton(i*25, j*25, 3,0);break;
				case(30): new TButton(i*25, j*25, 3,1);break;
				case(31): new TButton(i*25, j*25, 4,0);break;
				case(32): new TButton(i*25, j*25, 4,1);break;
				case(33): new TButton(i*25, j*25, 5,0);break;
				case(34): new TButton(i*25, j*25, 5,1);break;
				case(35): new TStronger(i*25, j*25);break;
				case(36): new TDire(i*25, j*25);break;
				case(37): new TFragileButton(i*25, j*25, 0,0);break;
				case(38): new TFragileButton(i*25, j*25, 0,1);break;
				case(39): new TFragileButton(i*25, j*25, 1,0);break;
				case(40): new TFragileButton(i*25, j*25, 1,1);break;
				case(41): new TFragileButton(i*25, j*25, 2,0);break;
				case(42): new TFragileButton(i*25, j*25, 2,1);break;
				case(43): new TFragileButton(i*25, j*25, 3,0);break;
				case(44): new TFragileButton(i*25, j*25, 3,1);break;
				case(45): new TFragileButton(i*25, j*25, 4,0);break;
				case(46): new TFragileButton(i*25, j*25, 4,1);break;
				case(47): new TFragileButton(i*25, j*25, 5,0);break;
				case(48): new TFragileButton(i*25, j*25, 5,1);break;
			}
		}
		if (TPlayer.active){
				TLevelScene.mx = TPlayer.x+12.5-300
				TLevelScene.my = TPlayer.y+12.5-300
		} else {
				TLevelScene.mx=(TD.self.mouseX/600)*700
				TLevelScene.my=(TD.self.mouseY/600)*700
		}

		data = data.substring(1)
		if (data!="TPDEND"){
			throw new Error(data+" - That was left")
		}

		if (TLevel.levelType == 1){
			var p: BitmapAsset = new (TLevel.g_panel)
			p.y = 550
			TD.layerPanel.addChild(p)
			var txt: String = TLevData.lastSelected.levelName +":\n";
			txt+="by: "+TLevData.lastSelected.author+"\n";
			var t: TextField
			switch (TLevData.lastSelected.id){
				case(0):
					txt+="Use WSAD/Numpad/Arrow Keys to move around."
					break;
				case(1):
					txt+="Use QEZC in Keyset A or QWAS in Keyset B to move diagonally."
					break;
				case(19):
					txt+="Use mouse to drop yourself when starting position isn't forced."
					break;
				case(6):
					txt+="Strong tiles turn into Normal when you jump off them."
					break;
				case(17):
					txt+="Steel tiles turn into Normal when neighboring tile is destroyed."
					break;
				case(22):
					txt+="Bombs destroy neighboring tiles aside from Exit, Buttons and Gates."
					break;
				case(37):
					txt+="Ortho and Diago tiles are destroyed when you jump off them Ortho-/Diagonally."
					break;
				case(41):
					txt+="Stronger are strong tiles but need 3 hits, while Direction tiles combine Ortho & Diago tiles."
					break;
				case(47):
					txt+="Fragile buttons are droppable and you need to drop them to complete level."
					break;
				case(23):
					txt+="When struck by bomb explosion Dirt turns into Floor or Normal tile."
					break;
				case(5):
					txt+="Gates can be opened and closed with buttons of the same color."
					break;
			}
			t = MakeText("<p align='center'>"+txt+"</p>", 12)
			t.x = 300-t.width/2
			t.y = 550
			TD.layerPanel.addChild(t)
		}

	}
}
