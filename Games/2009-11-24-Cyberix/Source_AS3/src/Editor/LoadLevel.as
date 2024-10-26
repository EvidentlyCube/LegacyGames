package Editor{
	import Classes.Scenes.TEditorScene;

	public function LoadLevel(data:String, anonymize: Boolean = false):void{
        if (data.indexOf("\\\\") != -1 || data.indexOf("\\\"") != -1){
            data = data.replace(/\\\\/g, "\\").replace(/\\\"/g, '"');
        }

        if (data.charAt(0) == '"')
            data = data.substr(1);
        if (data.charAt(data.length - 1) == '"')
            data = data.substr(0, data.length - 1);

		TEditorScene.drawLayer = 0
		TEditorScene.drawID = 0
		TEditorScene.drawField = null
		var space:int
		var arr:Array
		var i:uint
		var j:uint
		var tile:TField
		var len:uint
		var temp:Number
		//PACOMIX LEVEL DATA
		if (data.substr(0,6) == "PMLBEG"){
			data = data.substring(6)
		} else {
			throw new Error("Invalid Level")
		}

		//LEVEL AUTHOR
		len = TextToNum(data.substr(0,1))
		TopPanelMonster.authorTextField.htmlText = "<font face='fonter' color='#FFFFFF' size='16'>"+data.substr(1, len)+"</font>";
		data = data.substring(len + 1)

		//LEVEL NAME
		len = TextToNum(data.substr(0,1))
		TopPanelMonster.nameTextField.htmlText = "<font face='fonter' color='#FFFFFF' size='16'>"+data.substr(1,len) + "</font>";
		data = data.substring(len + 1)

		if (anonymize) {
			TopPanelMonster.authorTextField.htmlText = "<font face='fonter' color='#FFFFFF' size='16'>No author provided</font>";
			TopPanelMonster.nameTextField.htmlText = "<font face='fonter' color='#FFFFFF' size='16'>Unnamed level</font>";
		}

		//LEVEL SIZE
		TEditorScene.levWid = TextToNum(data.substr(0,1))
		TEditorScene.levHei = TextToNum(data.substr(1,1))
		data = data.substring(2)

		//BACKGROUND ID
		TEditorScene.bgID = TextToNum(data.substr(0,1))
		TEditorScene.setItem(0,TEditorScene.bgID + 500,GiveClass(TEditorScene.bgID + 500))
		data = data.substring(1)

		//BACKGROUND ANIMATION
		temp = TextToNum(data.substr(0,2)) - 4000
		data = data.substring(2)
		TopPanelMonster.backgroundHSpeedTextField.htmlText = "<font face='fonter' color='#FFFFFF' size='16'>"+temp + "</font>";

		temp = TextToNum(data.substr(0,2)) - 4000
		data = data.substring(2)
		TopPanelMonster.backgroundVSpeedTextField.htmlText = "<font face='fonter' color='#FFFFFF' size='16'>"+temp + "</font>";

		//FLOOR DATA
		arr = TEditorScene.layer0;
		for (j = 0;j < TEditorScene.levHei;j++){
			for (i = 0;i < TEditorScene.levWid;i++){
				tile = arr[i][j]
				if (tile != null){
					tile.remove(true)
				}
				temp = TextToNum(data.substr (0,1))
				data = data.substring(1)
				if (temp > 0){
					arr[i][j]=new TField(i,j,temp)
				}
			}
		}

		arr = TEditorScene.layer1;

		//WALL DATA
		for (j = 0;j < TEditorScene.levHei;j++){
			for (i = 0;i < TEditorScene.levWid;i++){
				tile = arr[i][j]
				if (tile != null){
					tile.remove(true)
				}
			}
		}
		space=-1
		while(true){
			temp = TextToNum(data.substr(0,2))
			data = data.substring(2)
			if (temp == 0){break}
			space += temp
			temp = TextToNum(data.substr(0,1)) + 70
			data = data.substring(1)
			i = space%TEditorScene.levWid
			j = Math.floor(space / TEditorScene.levWid)
			arr[i][j]=new TField(i,j,temp,false)
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
			i = space%TEditorScene.levWid
			j = Math.floor(space / TEditorScene.levWid)
			tile = new TField(i,j,temp,false)
			arr[i][j]=tile
			switch(temp){
				case(173):
				case(174):
					i = TextToNum(data.substr(0,1))
					j = TextToNum(data.substr(1,1))
					data = data.substring(2)
					tile.tempx = i
					tile.tempy = j
					tile.Teleportisis()
					break;
				case(175):
					temp = TextToNum(data.substr(0,2))
					i = TextToNum(data.substr(2,1))
					j = TextToNum(data.substr(3,1))
					data = data.substring(4)
					tile.tempclass = temp
					tile.tempx = i
					tile.tempy = j
					tile.Teleportisis()
					break
			}
		}

		//OBJECT DATA
		arr = TEditorScene.layer2;
		for (j = 0;j < TEditorScene.levHei;j++){
			for (i = 0;i < TEditorScene.levWid;i++){
				tile = arr[i][j]
				if (tile != null){
					tile.remove(true)
				}
			}
		}
		space=-1
		while(true){
			temp = TextToNum(data.substr(0,2))
			data = data.substring(2)
			if (temp == 0){break}
			space += temp
			temp = TextToNum(data.substr(0,1)) + 200
			data = data.substring(1)
			i = space%TEditorScene.levWid
			j = Math.floor(space / TEditorScene.levWid)
			arr[i][j]=new TField(i,j,temp,false)
		}

		if (data != "PMLEND"){
			throw new Error('"' + data + '" - That was left')
		}
	}
}
