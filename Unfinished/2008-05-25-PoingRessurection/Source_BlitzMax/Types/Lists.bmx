'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type Lists
	Global Balls:TList = New TList
	Function TraceBalls()
		For Local i:TBall = EachIn Balls
			i.Update()
			i.Draw()
		Next
	EndFunction
End Type
