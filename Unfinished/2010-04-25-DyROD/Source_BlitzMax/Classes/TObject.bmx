Type TObject
    ' ########################################################################################################################################################################################################################################################
    ' ####
    ' ####                                                                                                                                                                                                                                 C O N S T A N T S
    ' ####
    ' ########################################################################################################################################################################################################################################################
	
	Const MOVE_STATE_FREE  :Int = 0
	Const MOVE_STATE_OBJECT:Int = 1
	Const MOVE_STATE_FROM  :Int = 2
	Const MOVE_STATE_TO    :Int = 3
	Const MOVE_STATE_WEAPON:Int = 4
    
    ' ########################################################################################################################################################################################################################################################
    ' ####
    ' ####                                                                                                                                                                                                                                 V A R I A B L E S
    ' ####
    ' ########################################################################################################################################################################################################################################################
    
    
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '                                                                                                                                                                                                                        NUMERIC
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    'Summary: X position of the object in the current room. 
    Field _x:Byte
    
    
    'Summary: Y position of the object in the current room. 
    Field _y:Byte
    
    'Summary: A flag which indicates if the object is awake and active or not.
    Field _isAwake:Byte = False
	
	'Summary: Variable which indicates current direction.
	Field _direction:Int = 0
	
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '                                                                                                                                                                                                                      REFERENCE
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    'Summary: Pointer to the room instance in which the object currently resides.
    Field _room:TRoom
	
	'Summary: Link to the graphics instance of this object.
	Field _gfx:DataGfxObjects
	
	'Summary: Link to the level in which the object currently resides.
	Field _level:TLevel
	
	'Summary: A link to the next Active Object if applicable
	Field _next:TObject
	
	'Summary: A link to the brain instance of the monster
	Field _brain:TBrain
    
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '                                                                                                                                                                                                                           DATA
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    ' ########################################################################################################################################################################################################################################################
    ' ####
    ' ####                                                                                                                                                                                                                       P U B L I C   M E T H O D S
    ' ####
    ' ########################################################################################################################################################################################################################################################
    Function Create:TObject(x:Int, y:Int, room:TRoom, level:TLevel, brain:TBrain, graphics:DataGfxObjects , awake:Byte = False)
		?Debug Logger.Log("Initializing ")
		?
	
		Local this:TObject = New TObject
		this._x       = x
        this._y       = y
        this._room    = room
		this._level   = level
		this._brain   = brain
        this._isAwake = awake
		this._gfx     = graphics
        
        If this._isAwake
            this.wake()
        EndIf
		
		Return this
	End Function
    
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '                                                                                                                                                                                                                         ACTION
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    'Summary: Updates the object if it is activated - update means that the object will perform actions if it can. Returns true if the object is to be removed from active objects stack
    Method Update:Int()	
		_brain.Update(Self)
		
		Return False
    End Method
    
    
    'Summary: Moves the object in direction specified by the direction parameter.
    Method moveTo(direction:Int)
        Local newX:Int = _x + xFromDirection(direction)
        Local newY:Int = _y + yFromDirection(direction)
        
        Local currentTile:TTile = _room.getTileAt(_x,   _y)
        Local newTile    :TTile = _room.GetTileAt(newX, newY)
	
		if currentTile.canMoveFrom(direction) And newTile.canMoveTo(direction)
			currentTile.setObject(null)
	        newTile    .setObject(Self)
			
			_room = _room.GetRoomAt(newX, newY)
			
	        _x = wrapX(newX)
	        _y = wrapY(newY)
		End If 
    End Method
	
	'Summary: Causes the object to rotate in specified direction
	Method rotate(direction:Int)
		_direction = (_direction + direction) mod 8
		While _direction < 0
			_direction :+ 8
		WEnd
		
	End Method
	
	'Summary: Draws the current object to playfield
	Method Draw()
		_gfx.Draw(_x, _y, _direction)
	End Method
    
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '                                                                                                                                                                                                                      MODIFIERS
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
	'Summary: Awakens the object
    Method wake()
        _isAwake = true
        
        _level.addActiveObject(self)
    End Method
    
    ' ----------------------------
    '              STATE CHECKING
    ' ----------------------------
	
    'Summary: Checks if the object is ready to perform any action.
    '@return True if the object can perform actions. 
    Method canAct:Byte()
        return true
    End Method
	
	Method getMoveState:Int(direction:Int)
		Local currentTile:TTile = _room.GetTileAt(_x, _y)
        Local newTile:TTile     = _room.GetTileAt(_x + xFromDirection(direction) , _y + yFromDirection(direction)) 
		
		if Not currentTile.canMoveFrom(direction)
			Return MOVE_STATE_FROM
		
		ElseIf Not newTile.canMoveTo(direction)
			Return MOVE_STATE_TO  
			
		ElseIf newTile.GetObject()
			Return MOVE_STATE_OBJECT
			
		Else
			Return MOVE_STATE_FREE
			
		End If
	End Method
    
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '                                                                                                                                                                                                                       CHECKERS
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    ' ########################################################################################################################################################################################################################################################
    ' ####
    ' ####                                                                                                                                                                                                                     P R I V A T E   M E T H O D S
    ' ####
    ' ########################################################################################################################################################################################################################################################
    
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '                                                                                                                                                                                                                         ACTION
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	'Summary: Moves the object in specified direction
	Method moveInDirection(direction:Int)
		Local currentTile:TTile     = _room.getTileAt( _x, _y)
		Local destinationTile:TTile = _room.getTileAt( _x + xFromDirection(direction), _y + yFromDirection(direction) ) 
		
		If currentTile.canMoveFrom(direction) And destinationTile.canMoveTo(direction)
			currentTile.objectLeft(Self, direction)
			destinationTile.objectEntered(Self, direction)
			
			_x :+ xFromDirection(direction)
			_y :+ yFromDirection(direction)
		End If
	End Method
    
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '                                                                                                                                                                                                                      MODIFIERS
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '                                                                                                                                                                                                                       CHECKERS
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    ' ########################################################################################################################################################################################################################################################
    ' ####
    ' ####                                                                                                                                                                                                                 G E T T E R S   /   S E T T E R S
    ' ####
    ' ########################################################################################################################################################################################################################################################
    
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '                                                                                                                                                                                                                        NUMERIC
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    'Summary: X position of the object in the current room
    Method GetX:Byte()
		Return _x
	End Method
    
    'Summary: Y position of the object in the current room
    Method GetY:Byte()
		Return _y
	End Method
    
    'Summary: The global X coordinate, that is the X position in the whole level, not just room.
    Method GetGlobalX:Byte()
		Return _room.GetX() * Settings.ROOM_WIDTH + _x
	End Method
    
    'Summary: The global X coordinate, that is the X position in the whole level, not just room.
    Method GetGlobalY:Byte()
		Return _room.GetY() * Settings.ROOM_HEIGHT + _y
	End Method
    
    'Summary: Checks if current object is awake.
    Method isAwake:Byte()
		Return _isAwake   
	End Method
    
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '                                                                                                                                                                                                                      REFERENCE
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    'Summary: Pointer to the room instance in which the object currently resides.
    Method GetRoom:TRoom()
		Return _room
	End Method
	
	'Summary: Returns the next object in the active objects stack
	Method GetNext:TObject()
		Return _next
	End Method
	
	'Summary: Sets the next object in the active objects stack
	Method SetNext(val:TObject)
		_next = val
	End Method
    
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '                                                                                                                                                                                                                           DATA
    ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
End Type