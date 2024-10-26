'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TBall
	Field x:Float			'X Position
	Field y:Float			'Y Position
	Field movX:Float		'Move X - X velocity of current Direction
	Field movY:Float		'Move Y - Y velocity of current Direction
	Field newX:Float=0		'X velocity in one step of movement Loop
	Field newY:Float=0		'Y velocity in one step of movement Loop
	Field dir:Float			'Ball Direction
	Field spd:Float			'Ball Speed
	Field rad:Int			'Radius of the Ball
	Field scale:Float		'Scale of the ball (for drawing)
	Field Accelerate:Float=0'Temporary acceleration of ball
	Field Spin:Float=0		'NO of degrees ball will turn every step
	Field modX:Float=0		'Used in collision Check, X position of the ball inside grid
	Field modY:Float=0		'Used in collision Check, Y position of the ball inside grid
	Method Update()
		CountGravity()
		AddSpin(Spin)
		newX=movX+Accelerate
		newY=movY+Accelerate
		Local tempspd:Float=Max(Abs(newX),Abs(newY))
		newX:/tempspd
		newY:/tempspd
		While tempspd>0
			If tempspd<1
				newX:*tempspd
				newY:*tempspd
			EndIf
			tempspd:-1
			Collide()
			ResetDir()
			If (dir>90 Or dir<-90) And Paddle.Collide(x,y,rad)
				dir=(y-(Paddle.y+Paddle.hei/2))*80/((Paddle.hei+2*rad)/2)
				'x=Paddle.x+Paddle.wid+rad
				ResetMovXY()
			EndIf
		Wend
		If spin=0 And (dir=0 Or (dir>85 And dir<95) Or (dir<-85 And dir>-95))
			spin:+1
		EndIf
	EndMethod
	Method Draw()
		SetScale(scale,scale)
		Drawing.Image(GFX_BALL,x,y)
		SetScale(1,1)
	EndMethod
	Method ResetDir()
		dir=ATan2(movY,movX)
	EndMethod
	Method ResetMovXY()
		movX=Cos(dir)*spd
		movY=Sin(dir)*spd
	EndMethod
	Method AddSpin(dirMod:Float=0)
		Local direction:Float=ATan2(movY,movX)
		Local tmpSpd:Float=movX/Cos(dir)
		Dir=direction+dirMod
		movX=Cos(dir)*tmpSpd
		movY=Sin(dir)*tmpSpd
	EndMethod
	Method Bounce(direction:Float=0)
		Dir=ATan2(movY,movX)
		Local tmpSpd:Float=movX/Cos(dir)
		Dir=direction
		movX=Cos(dir)*tmpSpd
		movY=Sin(dir)*tmpSpd
	EndMethod
	Method Collide()
		modX=(x+newX) Mod 25
		modY=(Y+newY) Mod 35
		If modX<=rad
			modX=-1
		ElseIf modX<25-rad
			modX=0
		Else
			modX=1
		EndIf
		If modY<=rad
			modY=-1
		ElseIf modY<35-rad
			modY=0
		Else
			modY=1
		EndIf
		ColH()
		ColV()
		x:+newX
		y:+newY
	End Method
	Method ColH()
		If x+rad<0 
			Lists.Balls.Remove(Self)
		EndIf
		If x+rad>800
			movX:*-1
			newX:*-1
			Return
		ElseIf CurrentRoom.Hits(x+newX,y,Self,Floor(x/25),Floor(y/35))
			Return
		ElseIf modX<>0
			If CurrentRoom.Hits(x+newX,y,Self,Floor(x/25)+modX,Floor(y/35))
				Return
			ElseIf modY<>0
				If CurrentRoom.Hits(x+newX,y,Self,Floor(x/25),Floor(y/35)+modY)
					Return
				ElseIf CurrentRoom.Hits(x+newX,y,Self,Floor(x/25)+modX,Floor(y/35)+modY)
					Return
				EndIf
			EndIf
		ElseIf modY<>0 And CurrentRoom.Hits(x+newX,y,Self,Floor(x/25),Floor(y/35)+modY)
			Return
		EndIf
	EndMethod
	Method ColV()
		If Y+rad+newY>455 Or y-rad+newY<0
			movY:*-1
			newY:*-1
			Return
		ElseIf CurrentRoom.Hits(x,y+newY,Self,Floor(x/25),Floor(y/35))
			Return
		ElseIf modY<>0
			If CurrentRoom.Hits(x,y+newY,Self,Floor(x/25),Floor(y/35)+modY)
				Return
			ElseIf modX<>0
				If CurrentRoom.Hits(x,y+newY,Self,Floor(x/25)+modX,Floor(y/35))
					Return
				ElseIf CurrentRoom.Hits(x,y+newY,Self,Floor(x/25)+modX,Floor(y/35)+modY)
					Return
				EndIf
			EndIf
		ElseIf modX<>0 And CurrentRoom.Hits(x,y+newY,Self,Floor(x/25)+modX,Floor(y/35))
			Return
		EndIf
	EndMethod
	Method CountGravity:Float()
		Return 0
	EndMethod
	Function MakeNew(x:Float, y:Float, dir:Float, speed:Float, rad:Int)
		Local lo:TBall = New TBall
		lo.x=x
		lo.y=y
		lo.dir=dir
		lo.spd=speed
		lo.ResetMovXY()
		lo.rad=rad
		lo.scale=rad/6
		Lists.Balls.AddLast(lo)
	EndFunction
End Type
