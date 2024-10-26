'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TBrainMonsterRoach
	Global _instance:TBrainMonsterRoach
	
	Method Update()
		
	End Method
	
	Function GetInstance:TBrainMonsterRoach()
		if not _instance
			_instance = new TBrainMonsterRoach
		End If
		
		Return _instance
	End Function
	
	Function Create:TObject(room)
		
	End Function
End Type
