'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TBrainPlayer Extends TBrain
	Method Update(updated:TObject)
		Local currentRoom:TRoom = updated.GetRoom()
		
		If ControlManager.KeyHit(Settings.KEY_RIGHT)
			updated.moveTo(0)
			
		ElseIf ControlManager.KeyHit(Settings.KEY_DOWN_RIGHT)
			updated.moveTo(1)
			   
		ElseIf ControlManager.KeyHit(Settings.KEY_DOWN)
			updated.moveTo(2)
			   
		ElseIf ControlManager.KeyHit(Settings.KEY_DOWN_LEFT)
			updated.moveTo(3)
			   
		ElseIf ControlManager.KeyHit(Settings.KEY_LEFT)
			updated.moveTo(4)
			   
		ElseIf ControlManager.KeyHit(Settings.KEY_UP_LEFT)
			updated.moveTo(5)
			   
		ElseIf ControlManager.KeyHit(Settings.KEY_UP)
			updated.moveTo(6)
			   
		ElseIf ControlManager.KeyHit(Settings.KEY_UP_RIGHT)
			updated.moveTo(7)
		
		ElseIf ControlManager.KeyHit(Settings.KEY_ROTATE_CCW)
			updated.rotate(-1)

		ElseIf ControlManager.KeyHit(Settings.KEY_ROTATE_CW)
			updated.rotate(1)

		End If
		
		if updated.GetRoom() <> currentRoom
			GraphicManager.RedrawTiles() 
		End If
	End Method
	
	Function Create(room:TRoom, x:Int, y:Int, direction:Int)
		Local player:TObject = TObject.Create(x, y, room, room.GetLevel(), New TBrainPlayer, DataGfxObjects.FetchGraphic("PLAYER001", true) , True)
		
		player._direction = direction
		
		room.getTileAt(x, y).setObject(player)
		
		Engine.      _player      = player
		StateManager._firstActive = player
	End Function
End Type
