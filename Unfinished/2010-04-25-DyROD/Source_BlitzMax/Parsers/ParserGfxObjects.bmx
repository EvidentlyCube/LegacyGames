'This BMX file was edited with BLIde ( http://www.blide.org )
Type ParserGfxObjects Extends ParserManager
	Global file:TStream
	Global line:String

	Function Init()
		?Debug Logger.Log("### Initializing GFX Parser")
		?
		
		file = OpenFile("./assets/data/gfx.txt")
		
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
		Local Name:String = line[4..]
		
		line = file.ReadLine()
		
		Local rotatable:Int = line[2..3].ToInt()
		
		DataGfxObjects._Create(Name, rotatable)
	End Function
End Type
