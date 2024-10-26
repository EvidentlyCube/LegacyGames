SuperStrict
Private
Global keyStates:Byte[256] , keyHits:Byte[256] 
Global mouseStates:Byte[4] , mouseHits:Byte[4] , mouseLocation:Int[4] 

Function Hook:Object(id:Int, data:Object, context:Object) 
	Local ev:TEvent = TEvent(data) 
	If Not ev Return data
	Select (ev.id) 
		Case EVENT_KEYDOWN
			If Not keyStates[ev.data]
				keyStates[ev.data]=1
				keyHits[ev.data]:+1
			EndIf
			If ev.data=KEY_ESCAPE 
				End
			EndIf
		Case EVENT_KEYUP
			keyStates[ev.data]=0
		Case EVENT_MOUSEDOWN
			If Not mouseStates[ev.data]
				mouseStates[ev.data]=1
				mouseHits[ev.data]:+1
			EndIf
		Case EVENT_MOUSEUP
			mouseStates[ev.data]=0
		Case EVENT_MOUSEMOVE
			mouseLocation[0]=ev.x
			mouseLocation[1]=ev.y
		Case EVENT_MOUSEWHEEL
			mouseLocation[2]:+ev.data
	End Select
	Return data
EndFunction
AddHook (EmitEventHook, Hook) 
Public

Function KeyHit:Byte(key:Byte) 
	PollSystem
	Local n:Byte = keyHits[key] 
	keyHits[key]=0
	Return n
End Function
Function KeyDown:Byte(key:Byte) 
	PollSystem
	Return keyStates[key]
End Function
Function FlushKeys() 
	PollSystem
	For Local i:Byte = 0 Until 256
		keyStates[i] = 0
		keyHits[i]=0
	Next
End Function
Function MouseX:Int() 
	PollSystem
	Return mouseLocation[0] 
End Function
Function MouseY:Int() 
	PollSystem
	Return mouseLocation[1]
End Function
Function MouseZ:Int() 
	PollSystem
	Local n:Byte = mouseLocation[2] 
	mouseLocation[2] = 0
	Return n
End Function
Function FlushMouse() 
	PollSystem
	For Local i:Byte = 0 Until 4
		mouseStates[i]=0
		mouseHits[i]=0
	Next
	mouseLocation[2]=0
End Function
Function MouseHit:Byte(button:Byte) 
	PollSystem
	Local n:Byte = mouseHits[button] 
	mouseHits[button]=0
	Return n
End Function
Function MouseDown:Byte(button:Byte) 
	PollSystem
	Return mouseStates[button]
End Function