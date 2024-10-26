package Editor{
	import Classes.Scenes.TEditorScene;
	public function LoadLevel(data: String): void{

		TEditorScene.drawID = 0
		TEditorScene.drawField = null

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
			throw new Error("Invalid Level")
		}

		//LEVEL AUTHOR
		len = TextToNum(data.substr(0, 1))
		TopPanelMonster.authorText.htmlText="<font face='fonter' color='#FFFFFF' size='16'>"+data.substr(1, len)+"</font>";
		data = data.substring(len+1)

		//LEVEL NAME
		len = TextToNum(data.substr(0, 1))
		TopPanelMonster.nameText.htmlText="<font face='fonter' color='#FFFFFF' size='16'>"+data.substr(1, len)+"</font>";
		data = data.substring(len+1)

		//PLAYER POS
		TEditorScene.pla.x=(TextToNum(data.substr(0, 1))-1)*25
		TEditorScene.pla.y=(TextToNum(data.substr(1, 1))-1)*25
		data = data.substring(2)
		if (TEditorScene.pla.x == -1){TEditorScene.pla.visible = false} else {TEditorScene.pla.visible = true}

		arr = TEditorScene.layer

		//TILES DATA
		for (j = 0;j < 50;j++){
			for (i = 0;i < 50;i++){
				tile = arr[i][j]
				if (tile!=null){
					tile.remove(true)
				}
			}
		}

		while(true){
			i = TextToNum(data.substr(0, 1))-1
			if (i == -1){break}
			j = TextToNum(data.substr(1, 1))-1
			temp = TextToNum(data.substr(2, 1))
			data = data.substring(3)
			arr[i][j]=new TField(i, j,temp, false)
		}
		data = data.substring(1)

		if (data!="TPDEND"){
			throw new Error('"'+data+'" - That was left')
		}
	}
}
