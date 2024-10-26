Type StateManager
	Const STATE_INGAME:Int = 1
	
	Global _firstActive:TObject
	
	Global _currentState:Int = 1
	Global _stepActive:TObject
	
    Function Init()
        ?Debug Logger.Log("Initializing State Manager")
		?
    End Function
    
	Function Update()
		ControlManager.Flush()
		if ControlManager.AppSuspended() Then return
		Select _currentState
			Case STATE_INGAME
				_Ingame()
		End Select
	End Function
	
	Function _Ingame()
		If ControlManager.AppTerminate() Or ControlManager.KeyHit(KEY_ESCAPE)
			End
		End If
		
		_stepActive = _firstActive
		While _stepActive
			_stepActive.Update()
			_stepActive = _stepActive.getNext()
		WEnd
		
		GraphicManager.Draw()
	End Function
	
	Function GetFirstObject:TObject()
		Return _firstActive   
	End Function
End Type