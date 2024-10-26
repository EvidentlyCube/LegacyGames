'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type ParserLevel Extends ParserManager
	Global file:TStream
	Global line:String

	Global level:TLevel
	
	Function Init()
		?Debug Logger.Log("### Initializng Level Parser")
		?
		
		file = OpenFile("./assets/data/level-root.txt")
		
		While Not file.Eof()
			line = file.ReadLine()
			
			If line.StartsWith("L")
				createLevel()
			End If
			
			If line.StartsWith("R")
				loadRoom()
			End If
			
			if line.StartsWith("P")
				Local room:TRoom
				Local x:Int         = chunkGet(line, 3).ToInt()
				Local y:Int         = chunkGet(line, 4).ToInt()
				Local roomX:Int     = chunkGet(line, 1).ToInt()
				Local roomY:Int     = chunkGet(line, 2).ToInt()
				Local direction:Int = chunkGet(line, 5).ToInt()
				'DebugStop
				room = level.getRoomAt(roomX, roomY)
				TBrainPlayer.Create(room, x, y, direction) 
			End If
		WEnd
		
		file.Close()
	End Function
	
	Function createLevel()
		?Debug Logger.Log("Creating level")
		?
		
		level = TLevel.Create(ParserManager.chunkGet(line, 2).ToInt(), ParserManager.chunkGet(line, 3).ToInt())
	End Function
	
	Function loadRoom()
		?Debug Logger.Log("Loading room")
		?
		
		Local room:TRoom
		Local x:Int
		Local y:Int
		
		While Not line.StartsWith("E")
			Select line[0..1]
				Case "R"
					x = chunkGet(line, 1).ToInt()
					y = chunkGet(line, 2).ToInt()
					room = TRoom.Create(x, y, level)
				Case "D"
					line = ParserRoom.ParseRoom(file, line, room)
					Continue
			End Select
			
			line = file.ReadLine()
		Wend
		
		level.setRoomAt(x, y, room)
	End Function
End Type
