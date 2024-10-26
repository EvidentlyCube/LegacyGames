'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TRoom
	Field GravityDir:Float				'Direction of gravity in the room
	Field GravitySpd:Float				'Power of gravity in the room
	Field Room:TBrick[32,13]			'Array of Bricks
	Field Colors:Byte[8,3]				'RGB values of all 8 colors
	Field ColorValue:Short[8,2]			'Score and Bonus values for all colors
	
	Method New()
		For Local i:Byte=0 Until 8
			For Local j:Byte=0 Until 3
				Colors[i,j]=255
			Next
			ColorValue[i,0]=10
			ColorValue[i,1]=5
		Next
	EndMethod
	Method Hits:Float(_x:Float,_y:Float,_Ball:TBall,_bX:Byte,_bY:Int)
		If _bx<0 Or _bx>31 Or _by<0 Or _by>12 Then Return 0
		If Room[_bX,_bY]=Null Then Return 0
		Select (Room[_bX,_bY].shape)
			Case 0
				Return 0
			Case 1
				Return Room[_bX,_bY].checkHit(_x,_y,_ball)
		End Select
	EndMethod
End Type
