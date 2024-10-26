'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type ParserBuildingBlock
	Field tile:DataTile
	Field tileSpecialData:String
	
	Method Build(room:TRoom, x:Int, y:Int)
		Local tile:TTile = TTIle.Create(tile)
		room.SetTIleAt(tile, x, y)
	End Method
	
	Method SetTile(id:Int, specialData:String)
		tile 		    = DataTile.getTileByID(id)  
		tileSpecialData = specialData 
	End Method
End Type
