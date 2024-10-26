'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TBrick
	Field X:Short						'X position of Block
	Field Y:Short						'Y position of Block
	Field shape:Byte					'Shape ID of block, used for TRoom.Hits() Method
	Field Color:Byte					'Color ID of block. Can be 0-7 
	Field PointsType:Byte				'Score Type. 0=Score 1=Bonus
	Method Draw() Abstract				'Draw Method
	Method CheckHit:Byte(_x:Float,_y:Float,Ball:TBall) Abstract	'Checks for hit and alters the ball movmenet if indeed hit
	Method Hit(energy:Int,temperature:Int) Abstract			'Hits
End Type

Type TBrickBase Extends TBrick
	Method Draw()
		Drawing.Image(GFX_BLOCKS_A,x,y,0)
	EndMethod
	Method CheckHit:Byte(_x:Float,_y:Float,Ball:TBall)
		Local rad:Byte=Ball.rad
		If GeoCircleVSRect(x,y,25,35,_x,_y,rad)
			If _x<x Or _x>x+25 And Ball.modX=Sgn(ball.newX)
				Ball.movX:*-1
				Ball.newX:*-1
				Ball.ResetDir()
				Ball.Spin:/2
				RunHooks(HookID_Eyes,TEyeEvent.MakeNew(Ball,0,CurrentRoom.ColorValue[color,PointsType]))
			EndIf
			If _y<y Or _y>y+35 And Ball.modY=Sgn(ball.newY)
				Ball.movY:*-1
				Ball.newY:*-1
				Ball.ResetDir()
				Ball.Spin:/2
				RunHooks(HookID_Eyes,TEyeEvent.MakeNew(Ball,0,CurrentRoom.ColorValue[color,PointsType]))
			EndIf
			Hit()
			Return 1
		EndIf
		Return 0
	EndMethod
	Method Hit(energy:Int=0,temperature:Int=0)
		CurrentRoom.Room[X/25,Y/35]=Null
	EndMethod
	Function MakeNew(x:Byte,y:Byte,color:Byte,PointsType:Byte)
		Local lo:TBrickBase=New TBrickBase
		lo.X=x*25
		lo.Y=y*35
		lo.shape=1
		lo.Color=Max(0,Min(7,color))
		lo.PointsType=Max(0,Min(1,PointsType))
		CurrentRoom.Room[x,y]=lo
	EndFunction
EndType
