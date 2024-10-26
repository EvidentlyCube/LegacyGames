Type ControlManager
	Global _suspended :Int
	Global _terminate :Int
	
	Global _keyHolds  :Int[256]
	Global _keyHits   :Int[256]
	
	Global _mouseHolds:Int[4]
	Global _mouseHits :Int[4]
	Global _mouseX    :Int
	Global _mouseY	  :Int
	Global _mouseWheel:Int
	
	Function Init()
		?Debug Logger.Log("Initializing Control Manager")
		?
	
		AddHook(EmitEventHook, _Hook)
	End Function
	
	'Summary: Flushes the keyhits, mousehits and mouse wheel
	Function Flush()
		Local i:Int
		For i = 0 To 255
			_keyHits [i] = False
		Next
		For i = 0 To 3
			_mouseHits [i] = False
		Next
		_mouseWheel = 0
		
		PollSystem()
	End Function
	
	'Summary: Flushes all the keypresses
	Function HardFlush()
		Local i:Int
		For i = 0 To 255
			_keyHits [i] = False
			_keyHolds[i] = False
		Next
		For i = 0 To 3
			_mouseHits [i] = False
			_mouseHolds[i] = False
		Next
		_mouseWheel = 0
	End Function
	
	'Summary: PRIVATE
	Function _Hook:Object( id:Int, data:Object, context:Object )
		Local event:TEvent = TEvent(data)
		If Not event Then Return data
		
		Select (event.id)
			Case EVENT_KEYDOWN
				If Not _keyHolds[event.data]
					_keyHolds[event.data] = True
					_keyHits [event.data] = True
				EndIf
				
			Case EVENT_KEYUP
				_keyHolds[event.data] = False
				_keyHits [event.data] = False
				
			Case EVENT_MOUSEDOWN
				If Not _mouseHolds[event.data]
					_mouseHolds[event.data] = True
					_keyHits   [event.data] = True
				EndIf
				
			Case EVENT_MOUSEUP
				_mouseHolds[event.data] = False
				_keyHits   [event.data] = False
				
			Case EVENT_MOUSEMOVE
				_mouseX = event.x
				_mouseY = event.y
				
			Case EVENT_MOUSEWHEEL
				_mouseWheel = event.data
				
			Case EVENT_APPSUSPEND
				_suspended = True
				
			Case EVENT_APPRESUME
				HardFlush()
				_suspended = False
				
			Case EVENT_APPTERMINATE
				_terminate = True
				  
		End Select
	
		Return data
	End Function
	
	'Summary: Returns true if the Close-window button was hit
	Function AppTerminate:Int()
		If _terminate
			_terminate = False
			Return True
		Else
			Return False
		End If
	End Function
	
	'Summary: Returns true if the game loses focus
	Function AppSuspended:Int()
		Return _suspended
	End Function
	
	'Summary: Returns true if the #Key is held down
	Function KeyDown:Int(Key:Int)
		Return _keyHolds[Key & 255]
	End Function
	
	'Summary: Returns true if the #Key was hit
	Function KeyHit:Int(Key:Int)
		Return _keyHits[Key & 255]
	End Function
	
	'Summary: Returns true if the mouse button is held down
	Function MouseDown:Int(button:Int)
		Return _mouseHolds[button & 3] 
	End Function
	
	'Summary: Returns true if the mouse button was hit
	Function MouseHit:Int(button:Int)
		Return _mouseHits[button & 3]
	End Function
End Type
