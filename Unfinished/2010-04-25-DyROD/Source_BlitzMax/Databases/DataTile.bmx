'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type DataTile
	Global _tilesArray:DataTile[]
	
	Field _name:String
	Field _id:Int
	Field _gfx:Int
	Field _flags:String
	
	' ====================================================================
    ' ==
    ' ==                                     P U B L I C   M E T H O D S
    ' ==
    ' ====================================================================
	
	'Summary: Returns true if object can leave tile in the direction specified
	Method canMoveFrom:Int(direction:Int)
		if _FLAG("LEAVE_8") OR _FLAG("LEAVE_"+direction)
			Return false
		End If
		
		Return True
	End Method
	
	'Summary: Returns true if object can enter tile moving in the direction specified
	Method canMoveTo:Int(direction:Int)
		if _FLAG("ENTER_8") OR _FLAG("ENTER_"+direction)
			Return false
		End If
		
		Return True
	End Method
	
	'Summary: Called when object leaves the tile in direciton specified
	Method objectLeft(obj:TObject, direction:Int, tile:TTile)
		
	End Method
	
	'Summary: Called when object enters the tile moving in direction specified
	Method objectEntered(obj:TObject, direction:Int, tile:TTile)
		
	End Method
	
	'Summary: Draws a tile to the display, x and y are in Tile coordinates
	Method Draw(x:Int, y:Int)
		DataGfxTiles.DrawTile(x, y, _gfx)
	End Method
	
	' ====================================================================
    ' ==
    ' ==                                   P R I V A T E   M E T H O D S
    ' ==
    ' ====================================================================
	
	Method _FLAG:Int(flag:String)
		Return _flags.Contains(flag)
	End Method
	
	' ====================================================================
    ' ==
    ' ==                                               F U N C T I O N S
    ' ==
    ' ====================================================================
	
	Function initArray(elements:Int)
		_tilesArray = New DataTile[elements]
	End Function
	
	Function getTileByID:DataTile(id:Int)
		Return _tilesArray[id];
	End Function
End Type
