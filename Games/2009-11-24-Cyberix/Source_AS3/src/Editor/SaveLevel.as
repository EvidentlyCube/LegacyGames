package Editor{
	import Classes.Scenes.TEditorScene;
	public function SaveLevel():String{
		var result:String
		var space:int = 0
		var arr:Array
		var i:uint
		var j:uint
		var temp:Number
		var tile:TField
		//PACOMIX LEVEL DATA
		result = "PMLBEG"

		//LEVEL AUTHOR
		result += NumToText(TopPanelMonster.authorTextField.text.length)
		result += TopPanelMonster.authorTextField.text

		//LEVEL NAME
		result += NumToText(TopPanelMonster.nameTextField.text.length)
		result += TopPanelMonster.nameTextField.text

		//LEVEL SIZE
		result += NumToText(TEditorScene.levWid)
		result += NumToText(TEditorScene.levHei)

		//BACKGROUND ID
		result += NumToText(TEditorScene.bgID)

		//BACKGROUND ANIMATION
		temp = Math.max(Math.min(Number(TopPanelMonster.backgroundHSpeedTextField.text),4000),-4000) + 4000
		result += NumToText(temp,2)
		temp = Math.max(Math.min(Number(TopPanelMonster.backgroundVSpeedTextField.text),4000),-4000) + 4000
		result += NumToText(temp,2)

		//FLOOR DATA
		arr = TEditorScene.layer0;
		for (j = 0;j < TEditorScene.levHei;j++){
			for (i = 0;i < TEditorScene.levWid;i++){
				if (arr[i][j]!=null){
					result += NumToText(TField(arr[i][j]).type)
				} else {
					result += NumToText(0)
				}
			}
		}

		//WALL DATA
		arr = TEditorScene.layer1;
		space = 0
		for (j = 0;j < TEditorScene.levHei;j++){
			for (i = 0;i < TEditorScene.levWid;i++){
				space++
				tile = arr[i][j]
				if (tile != null && tile.type < 140 && tile.type > 70){
					result += NumToText(space,2)			//Always >0
					result += NumToText(tile.type - 70)		//Always between 0 and 59
					space = 0
				}
			}
		}
		result += NumToText(0,2)							//End WALL Data

		//ITEM DATA
		arr = TEditorScene.layer1;
		space = 0
		for (j = 0;j < TEditorScene.levHei;j++){
			for (i = 0;i < TEditorScene.levWid;i++){
				space++
				tile = arr[i][j]
				if (tile != null && tile.type >= 140){
					result += NumToText(space,2)			//Always >0
					result += tile.toString()
					space = 0
				}
			}
		}
		result += NumToText(0,2)							//End ITEM Data

		//OBJECT DATA
		arr = TEditorScene.layer2;
		space = 0
		for (j = 0;j < TEditorScene.levHei;j++){
			for (i = 0;i < TEditorScene.levWid;i++){
				space++
				tile = arr[i][j]
				if (tile != null && tile.type > 200){
					result += NumToText(space,2)			//Always >0
					result += tile.toString()
					space = 0
				}
			}
		}
		result += NumToText(0,2)							//End OBJECT Data
		result += "PMLEND"

		return result;
	}
}