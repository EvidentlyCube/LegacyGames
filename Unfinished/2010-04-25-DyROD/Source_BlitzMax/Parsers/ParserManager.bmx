'This BMX file was edited with BLIde ( http://www.blide.org )

Type ParserManager
	'Summary: Initializes the manager and all the parsers
	Function Init()
		?Debug Logger.Log("### Initializing ParserManager")
		?
		DataGfxTiles.Init()
		
		ParserGfxObjects.Init()
		ParserTiles     .Init()
		ParserRoom	    .Init()
		ParserLevel	 	.Init()
		
		
		GraphicManager.RedrawTiles()
	End Function
	
	'Summary: Returns amount of data chunks (parts separated by ":") in string
	Function chunkCount:Int(chunk:String)
		Return chunk.Length - chunk.Replace(":", "").Length
	End Function
	
	'Summary: Returns the data n-th data chunk (part separated by ":") without white-space characters
	Function chunkGet:String(chunk:String, n:Int, noStripping:Byte = false)
		While n > 0
			chunk = chunk[chunk.Find(":") + 1..]
			n :- 1
		Wend
		If chunk.Find(":") >= 0
			 chunk = chunk[..chunk.Find(":")]
		End If
		if noStripping
			Return chunk
		Else 
			Return StripAll(chunk)
		End If
		
	End Function
	
	'Summary: Strips all whitespace characters from string
	Function StripAll:String(chunk:String)
		Return chunk.Replace(" ", "").Replace(Chr(10), "").Replace(Chr(13), "")
	End Function
End Type
