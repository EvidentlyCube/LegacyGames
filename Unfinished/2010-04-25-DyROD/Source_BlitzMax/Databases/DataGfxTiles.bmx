'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type DataGfxTiles
	'Summary: Hold
	Global _graphic:TImage
	
	Function Init()
		_graphic = LoadAnimImage("./assets/gfx/tiles_1.png", 25, 25, 0, 11)
	EndFunction
	
	Function DrawTile(x:Int, y:Int, frame:Int)
		DrawImage(_graphic, x * Settings.TILE_WIDTH + Settings.PLAYFIELD_OFFSET_X, y * Settings.TILE_HEIGHT + Settings.PLAYFIELD_OFFSET_Y, frame)
	EndFunction
End Type
