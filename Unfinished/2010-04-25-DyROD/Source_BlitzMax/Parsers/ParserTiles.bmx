'This BMX file was edited with BLIde ( http://www.blide.org )
Type ParserTiles Extends ParserManager
	Global file:TStream
	Global line:String

	Function Init()
		?Debug Logger.Log("### Initializing TILES Parser")
		?
		
		DataTile.initArray(100)
		
		file = OpenFile("./assets/data/tiles.txt")
		
		While Not file.Eof()
			line = file.ReadLine()
			
			If line.StartsWith("N")
				parseEntry()
			End If
		WEnd
		
		file.Close()
	End Function
	
	Function parseEntry()
		?Debug Logger.Log("Parsing Entry")
		?
		
		Local data:DataTile = New DataTile

		While line <> ""
			Select line[0..1]
				Case "N"
					data._id   = chunkGet(line, 1).ToInt()
					data._name = chunkGet(line, 2)
				Case "G"
					data._gfx  = chunkGet(line, 1).ToInt()
				Case "F"
					data._flags = chunkGet(line, 1)
			End Select
			
			line = file.ReadLine()
		WEnd
		
		?Debug Logger.Log("Created Data Tile ~q" + data._name + "~q")
			   Logger.Log("    ID  = " + data._id)
			   Logger.Log("    GFX = " + data._gfx)
		?

		DataTile._tilesArray[data._id] = data
	End Function
End Type
