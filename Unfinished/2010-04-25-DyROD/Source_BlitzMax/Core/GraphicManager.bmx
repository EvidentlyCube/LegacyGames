'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type GraphicManager
	Global _driver:TGraphicsDriver = GLMax2DDriver()
	Global _graphicsObject:TGraphics
	
	Global _tiles:TImage
	
	Global _drawingObject:TObject
	
	Const SCREEN_WIDTH :Int = 1024
	Const SCREEN_HEIGHT:Int = 768
	Const SCREEN_DEPTH :Int = 0
	
	Const IMAGES_OBJECTS_PATH  :String = "./assets/gfx/objects/"
	
	Function Init()
		?Debug Logger.Log("Initializing Graphic Manager")
		?
	
		SetGraphicsDriver( _driver )
		
		_graphicsObject = CreateGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_DEPTH, 60, GRAPHICS_BACKBUFFER) 
		SetGraphics( _graphicsObject )
		SetBlend( ALPHABLEND )
		
		EnablePolledInput()
		
		?Debug Logger.Log("Generating backImage for _tiles")
		?
		_tiles = CreateImage(Settings.ROOM_WIDTH_PIXELS, Settings.ROOM_HEIGHT_PIXELS, 1, DYNAMICIMAGE)
	End Function
	
	Function Draw()
		_DrawHud()
		
		DrawImage(_tiles, Settings.PLAYFIELD_OFFSET_X, Settings.PLAYFIELD_OFFSET_Y)
		
		_drawingObject = StateManager.GetFirstObject()
		
		While _drawingObject
			_drawingObject.Draw()
			_drawingObject = _drawingObject.GetNext()   
		WEnd
		
		Flip 1
		Cls
	End Function
	
	Function _DrawHud()
		SetColor(66, 66, 66)
		
		DrawRect(0,   0, 224, 768)
		DrawRect(224, 0, 800, 68)
		
		SetColor(255, 255, 255)
	End Function
	
	Function RedrawTiles()
		Local tiles:TTile[] = Engine.GetCurrentRoom().GetTiles()
		
		Local i:Int
		Local l:Int = tiles.Length
		
		for i = 0 Until l
			tiles[i].Draw(i mod Settings.ROOM_WIDTH, Floor(i / Settings.ROOM_WIDTH))
		Next
		
		LockImage(_tiles)
		
		GrabImage(_tiles, Settings.PLAYFIELD_OFFSET_X, Settings.PLAYFIELD_OFFSET_Y)
		
		UnlockImage(_tiles)
	End Function
End Type