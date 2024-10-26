'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type DataGfxObjects
	'Summary: A map containing all the graphics
	Global _graphicsMap:TMap = New TMap
	
	'Summary: Amount of graphic files loaded and ready to use
	Global _totalLoaded:Int = 0
	
	'Summary: Amount of graphics being currently assigned to objects
	Global _totalUsed  :Int = 0
	
	'Summary: In Millisecs(), when the last clean occured
	Global _lastClean  :Int = 0
	
	Field _rotatable:Byte
	Field _name     :String
	Field _useCount :Int = 0
	Field _image    :TImage
	
	' ====================================================================
    ' ==
    ' ==                                     P U B L I C   M E T H O D S
    ' ==
    ' ====================================================================
	
	Method Draw(x:Int, y:Int, direction:Int)
		if Not _image
			_Load() 
		End If
		DrawImage(_image, x * Settings.TILE_WIDTH + Settings.PLAYFIELD_OFFSET_X, y * Settings.TILE_HEIGHT + Settings.PLAYFIELD_OFFSET_Y, direction * _rotatable)
	End Method
	
	Method IncreaseCount()
		_useCount :+ 1
		If _useCount = 1 
			_totalUsed :+ 1
			If Not _image
				_Load()
			End If
		End If
	End Method
	
	Method DecreaseCount()
		_useCount :- 1
		
		If _useCount = 0
			_totalUsed :- 1	
			If _totalLoaded > 64
				Clean()
			End If
		End If
	End Method
	
	' ====================================================================
    ' ==
    ' ==                                   P R I V A T E   M E T H O D S
    ' ==
    ' ====================================================================
	
	Method _Load()
		_totalLoaded :+ 1
		
		?Debug Logger.Log("Loading image at path: " + GraphicManager.IMAGES_OBJECTS_PATH + _name + ".png")
		?
		
		If _rotatable
			_image = LoadAnimImage(GraphicManager.IMAGES_OBJECTS_PATH + _name + ".png", 25, 25, 0, 8)
		Else 
			_image = LoadImage(GraphicManager.IMAGES_OBJECTS_PATH + _name + ".png")
		End If
	End Method
	
	Method _Unload()
		_totalLoaded :- 1
		
		_image = Null
	End Method
	
	
	' ====================================================================
    ' ==
    ' ==                                 P U B L I C   F U N C T I O N S
    ' ==
    ' ====================================================================
	
	Function FetchGraphic:DataGfxObjects(name:String, rotatable:Byte)
		Local gfx:DataGfxObjects = DataGfxObjects( _graphicsMap.ValueForKey(name)  )
		If gfx
			Return gfx
		Else 
			Return _Create(Name, rotatable)
		End If
	End Function
	
	Function Clean()
		If _lastClean + 10000 < MilliSecs()
			Local i:DataGfxObjects 
			For i = EachIn _graphicsMap
				If i._useCount = 0
					i._Unload()
				End If
			Next  
			
			_lastClean = MilliSecs() 
		End If
	End Function
	
	' ====================================================================
    ' ==
    ' ==                               P R I V A T E   F U N C T I O N S
    ' ==
    ' ====================================================================
	
	Function _Create:DataGfxObjects(Name:String, rotatable:Byte)
		?Debug Logger.Log("New TGfx Created: " + Name + " : " + rotatable)
		?
	
		Local this:DataGfxObjects = New DataGfxObjects
		this._name                = name
		this._rotatable           = rotatable
		
		_graphicsMap.Insert(Name, this)
		
		Return this
	End Function
End Type
