'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type ParserRoom Extends ParserManager
	Global tilesDefault:ParserBuildingBlock[93]
	
	Global file:TStream
	Global line:String
	
	Global level:TLevel
	
	'Summary: Initializes the default tile data   
	Function Init()
		?Debug Logger.Log("### Initializing Default Building Block parser")
		?
		file = OpenFile("./assets/data/default-room-data.txt", True, false)
		
		While Not file.Eof()
			line = file.ReadLine()
			
			If line.StartsWith("B")
				ParseTileDefault()
			End If
		WEnd
		
		file.Close()
	End Function
	
	Function ParseTileDefault()
		Local block:ParserBuildingBlock = new ParserBuildingBlock
		Local character:Int =  Asc(chunkGet(line, 1)) - 33
		
		?Debug Logger.Log("Building block creating, character value = " + character)
		?
		
		While Asc(line[0..1]) <> 32
			Select(line[0..1])
				Case "T"
					?Debug Logger.Log("    Tile ID = " + chunkGet(line, 1))
					?
					block.SetTile(chunkGet(line, 1).ToInt(), chunkGet(line, 2))
			End Select
			
			line = file.ReadLine()
		Wend
		
		
		
		tilesDefault[character] = block
	EndFunction
	
	Function ParseRoom:String(_file:TStream, _line:String, _room:TRoom)
		?Debug Logger.Log("Parsing room")
		?
		Local data:String
		
		For Local j:Int = 0 Until Settings.ROOM_HEIGHT
			data = chunkGet(_line, 1)
			Print (data)
			For Local i:Int = 0 Until Settings.ROOM_WIDTH
				
				tilesDefault[Asc(data[i..i+1]) - 33].Build(_room, i, j)
			Next
			
			_line = _file.ReadLine()
		Next
		Return _line
	End Function
End Type
