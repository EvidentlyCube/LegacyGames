package Editor{
	import Classes.Scenes.TEditorScene;
	public function SaveLevel(): String{
		var result: String
		var space: int = 0
		var arr: Array
		var i: uint
		var j: uint
		var tile: TField
		//TRAPDOORER LEVEL DATA
		result="TPDBEG"

		//LEVEL AUTHOR
		result += NumToText(TopPanelMonster.authorText.text.length)
		result += TopPanelMonster.authorText.text

		//LEVEL NAME
		result += NumToText(TopPanelMonster.nameText.text.length)
		result += TopPanelMonster.nameText.text

		//PLAYER POS
		result += NumToText(TEditorScene.pla.x/25+1)
		result += NumToText(TEditorScene.pla.y/25+1)

		//TILES DATA
		arr = TEditorScene.layer;
		for (j = 0;j < 50;j++){
			for (i = 0;i < 50;i++){
				tile = arr[i][j]
				if (tile!=null && tile.type > 0){
					result += NumToText(i+1, 1)			//Always >0
					result += NumToText(j+1, 1)			//Always >0
					result += NumToText(tile.type)
					space = 0
				}
			}
		}
		result += NumToText(0, 1)							//End TILES Data
		result+="TPDEND"

		return result;
	}
}