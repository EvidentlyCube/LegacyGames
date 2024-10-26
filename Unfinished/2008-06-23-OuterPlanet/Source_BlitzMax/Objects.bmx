
'TObject - A class containing all interactive objects (ie. Enemies and Player)

Type TObject Abstract
	Field hp:Float
	Field x:Int
	Field y:Int
	Field wid:Byte
	Field hei:Byte
	Field pwid:Byte
	Field phei:Byte
	Field moveX:Float
	Field moveY:Float
	Method Update() Abstract
	Method Draw() Abstract
	Method HitLine:Float[](xa:Float, ya:Float, xb:Float, yb:Float) Abstract
	Method HitRect:Byte(xa:Float, ya:Float, wi:Float, he:Float) Abstract
	Method HitPoint:Byte(xa:Float, ya:Float) Abstract
	Method HitCircle:Byte(xa:Float,ya:Float,radi:Byte) Abstract
	Method Kill(dir:Float=0) Abstract
	Method Damage(pow:Float,dir:Float=0) Abstract
	Method MoveHorizontal()
		If Round(moveX)>0
			MoveRight()
		ElseIf Round(moveX)<0
			MoveLeft()
		EndIf
	EndMethod
	Method MoveVertical()
		If Round(moveY)>0
			MoveDown()
		ElseIf Round(moveY)<0
			MoveUp()
		EndIf
	EndMethod
	Method MoveLeft()
		Local changed:Byte=1
		Local newX:Float=x+moveX
		Local Block:Byte
		Local Fla:Byte=0
		While changed
			fla=0
			changed=0
			If Not Level.PreciseCollision(x,y-2) Then y:-2;fla=1
			Block=Level.PreciseCollision2(newX,y+hei)
			Select Block
				Case 2,4,5,6,7,8
					If Level.CheckCollision(X,Y+hei)<>16
						newX=Floor(newX/25)*25+25
						moveX=newX-X
						changed=1
					Else
						newX=Floor(X/25)*25+(y+hei) Mod 25
						moveX=newX-X
						'moveY=0
						fla=0
					EndIf
				Case 3
					If Level.SpikeCollision(newX,y,2)
						X=Floor(newX/25)*25+25
						moveX=0
						newX=X
						changed=0
						Self.Push(10,0)
						Damage(2)
					Else
						newX=Floor(newX/25)*25+25
						moveX=newX-X
						changed=1
					EndIf
				Case 10
					If x>=Floor(newX/25)*25+25
						newX=Floor(newX/25)*25+25
						moveX=newX-X
						changed=1
					EndIf
				Case 16
					newX=Floor(newX/25)*25+(y+hei) Mod 25
					moveX=newX-X
					'moveY=0
					fla=0
			EndSelect
			If fla=1 
				If Not Level.PreciseCollision(newX,y+hei+2)
					y:+2
				Else
					moveY:+2
				EndIf
			EndIf
			Block=Level.PreciseCollision2(newX,y)
			Select Block
				Case 2,4,5,6,7,8
					If Level.CheckCollision(X,Y+hei)<>13
						newX=Floor(newX/25)*25+25
						moveX=newX-X
						changed=1
					Else
						newX=Floor(X/25)*25+25-(y Mod 25)
						moveX=newX-X
						'moveY=0
						fla=0
					EndIf
				Case 3
					If Level.SpikeCollision(newX,y+hei,2)
						X=Floor(newX/25)*25+25
						moveX=0
						newX=X
						changed=0
						Self.Push(10,0)
						Damage(2)
					Else
						newX=Floor(newX/25)*25+25
						moveX=newX-X
						changed=1
					EndIf
				Case 10
					If x>=Floor(newX/25)*25+25
						newX=Floor(newX/25)*25+25
						moveX=newX-X
						changed=1
					EndIf
				Case 13
					newX=Floor(newX/25)*25+25-(y Mod 25)
					moveX=newX-X
					'moveY=0
					fla=0
			EndSelect
		Wend
		x:+moveX
	EndMethod
	Method MoveRight()
		Local changed:Byte=1
		Local newX:Float=x+wid+moveX
		Local Block:Byte
		Local Fla:Byte=0
		While changed
			fla=0
			changed=0
			If Not Level.PreciseCollision(x,y-2) Then y:-2;fla=1
			Block=Level.PreciseCollision2(newX,y+hei)
			Select Block
				Case 2,3,4,6,7,8
					If Level.CheckCollision(X,Y+hei)<>15
						newX=Floor(newX/25)*25-1
						moveX=newX-X-wid
						changed=1
					Else
						newX=Floor(X/25)*25+25-(y+hei) Mod 25
						moveX=newX-X-wid
						'moveY=0
						fla=0
					EndIf
				Case 5
					If Level.SpikeCollision(newX,y,0)
						X=Floor(newX/25)*25-pwid
						moveX=0
						newX=X
						changed=0
						Self.Push(-10,0)
						Damage(2)
					Else
						newX=Floor(newX/25)*25-1
						moveX=newX-X-wid
						changed=1
					EndIf
				Case 12
					If x<=Floor(newX/25)*25-pwid
						newX=Floor(newX/25)*25-1
						moveX=newX-X-wid
						changed=1
					EndIf
				Case 15
					newX=Floor(newX/25)*25+25-(y+hei) Mod 25
					moveX=newX-X-wid
					'moveY=0
					fla=0
			EndSelect
			If fla=1 
				If Not Level.PreciseCollision(newX,y+hei+2)
					y:+2
				Else
					moveY:+2
				EndIf
			EndIf
			Block=Level.PreciseCollision2(newX,y)
			Select Block
				Case 2,3,4,6,7,8
					If Level.CheckCollision(X,Y+hei)<>14
						newX=Floor(newX/25)*25-1
						moveX=newX-X-wid
						changed=1
					Else
						newX=Floor(X/25)*25+y Mod 25
						moveX=newX-X-wid
						'moveY=0
						fla=0
					EndIf
				Case 5
					If Level.SpikeCollision(newX,y+hei,0)
						X=Floor(newX/25)*25-pwid
						moveX=0
						newX=X
						changed=0
						Self.Push(-10,0)
						Damage(2)
					Else
						newX=Floor(newX/25)*25-1
						moveX=newX-X-wid
						changed=1
					EndIf
				Case 12
					If x<=Floor(newX/25)*25-pwid
						newX=Floor(newX/25)*25-1
						moveX=newX-X-wid
						changed=1
					EndIf
				Case 14
					newX=Floor(newX/25)*25+y Mod 25
					moveX=newX-X-wid
					'moveY=0
					fla=0
			EndSelect
		Wend
		x:+moveX
	EndMethod
	Method MoveUp()
		Local changed:Byte=1
		Local newY:Float=Y+moveY
		Local Block:Byte
		While changed
			changed=0
			Block=Level.PreciseCollision2(x,newY)
			'Mark(x,newY,1)
			Select Block
				Case 2,3,5,6,7,8
					newY=Floor(newY/25)*25+25
					moveY=newY-Y
					changed=1
					If Level.CheckCollision(x,newY)<>13 Then headButt()
				Case 4
					If Level.SpikeCollision(x+wid,newY-1,3)
						headbutt()
						y=Floor(newY/25)*25+25
						newY=y
						moveY=0
						changed=0
						Push(0,10)
						Damage(2)
					Else
						newY=Floor(newY/25)*25+25
						moveY=newY-Y
						changed=1
						headButt()
					EndIf
				Case 11
					If y>=Floor(newY/25)*25+25
						newY=Floor(newY/25)*25+25
						moveY=newY-Y
						changed=1
						headButt()
					EndIf
				Case 13
					newY=Floor(newY/25)*25+25-x Mod 25
					moveY=newY-Y
					Headbutt()
			EndSelect
			Block=Level.PreciseCollision2(x+wid,newY)
			Select Block
				Case 2,3,5,6,7,8
					newY=Floor(newY/25)*25+25
					moveY=newY-Y
					changed=1
					If Level.CheckCollision(x+wid,newY)<>15 Then headButt()
				Case 4
					If Level.SpikeCollision(x,newY-1,3)
						y=Floor(newY/25)*25+25
						newY=y
						moveY=0
						changed=0
						Push(0,10)
						Damage(2)
					Else
						newY=Floor(newY/25)*25+25
						moveY=newY-Y
						changed=1
						headButt()
					EndIf
				Case 11
					If y>=Floor(newY/25)*25+25
						newY=Floor(newY/25)*25+25
						moveY=newY-hei-Y
						changed=1
						headButt()
					EndIf
				Case 14
					newY=Floor(newY/25)*25+(x+wid) Mod 25
					moveY=newY-Y
			EndSelect
		Wend
		y:+moveY
	End Method
	Method MoveDown()
		Local changed:Byte=1
		Local newY:Float=Y+hei+moveY
		Local Block:Byte
		While changed
			changed=0
			Block=Level.PreciseCollision2(x,newY)
			'Mark(x,newY,1)
			Select Block
				Case 2,3,4,5
					newY=Floor(newY/25)*25-1
					moveY=newY-hei-Y
					changed=1
					If Level.CheckCollision(x,newY)<>16 Then Land()
				Case 7
					newY=Floor(newY/25)*25-1
					moveY=newY-hei-Y
					changed=1
					If Level.CheckCollision(x,newY)<>16 Then Land()
					Push2(1,0)
				Case 8
					newY=Floor(newY/25)*25-1
					moveY=newY-hei-Y
					changed=1
					If Level.CheckCollision(x,newY)<>16 Then Land()
					Push2(-1,0)
				Case 6
					If Level.SpikeCollision(x+wid,newY+1,1)
						y=Floor(newY/25)*25-phei
						newY=y+hei
						moveY=0
						changed=0
						Push(0,-10)
						Damage(2)
					Else
						newY=Floor(newY/25)*25-phei
						moveY=newY-hei-Y
						changed=1
						Land()
					EndIf
				Case 9
					If y<=Floor(newY/25)*25-phei
						newY=Floor(newY/25)*25-1
						moveY=newY-hei-Y
						changed=1
						Land()
					EndIf
				Case 16
					newY=Floor(newY/25)*25+x Mod 25
					moveY=newY-hei-Y
					If moveX<0
						Land(0)
						'moveX=0
					Else 
						Land()
					EndIf
			EndSelect
			Block=Level.PreciseCollision2(x+wid,newY)
			Select Block
				Case 2,3,4,5
					newY=Floor(newY/25)*25-1
					moveY=newY-hei-Y
					changed=1
					If Level.CheckCollision(x+wid,newY)<>15 Then Land()
				Case 7
					newY=Floor(newY/25)*25-1
					moveY=newY-hei-Y
					changed=1
					If Level.CheckCollision(x,newY)<>16 Then Land()
					Push(1,0)
				Case 8
					newY=Floor(newY/25)*25-1
					moveY=newY-hei-Y
					changed=1
					If Level.CheckCollision(x,newY)<>16 Then Land()
					Push(-1,0)
				Case 6
					If Level.SpikeCollision(x,newY+1,1)
						y=Floor(newY/25)*25-1
						newY=y+hei
						moveY=0
						changed=0
						Push(0,-10)
						Damage(2)
					Else
						newY=Floor(newY/25)*25-1
						moveY=newY-hei-Y
						changed=1
						Land()
					EndIf
				Case 9
					If y<=Floor(newY/25)*25-phei
						newY=Floor(newY/25)*25-1
						moveY=newY-hei-Y
						changed=1
						Land()
					EndIf
				Case 15
					newY=Floor(newY/25)*25+25-(x+wid) Mod 25
					moveY=newY-hei-Y
					If moveX>0
						Land(0)
						'moveX=0
					Else 
						Land()
					EndIf
			EndSelect
		Wend
		y:+moveY
	End Method
	Rem
	Method MoveHorizontal()
		If Round(moveX)<0
			MoveLeft(Round(MoveX))
		Else If Round(moveX>0)
			MoveRight(Round(MoveX))
		EndIf
	EndMethod
	Method MoveVertical()
		If Round(moveY)<0
			MoveUp(Round(MoveY))
		Else If Round(moveY>0)
			MoveDown(Round(MoveY))
		EndIf
	EndMethod

	Method MoveUp(movY:Float)
		Local Obey:Byte=0
		Local Coll:Byte[2]
		Local Finish:Byte=False
		While Not Finish
			Coll[0]=Level.CheckCollision(x,y+movY)
			Coll[1]=Level.CheckCollision(x+wid,y+movY)
			If Coll[0]=1 Then Obey=0 ElseIf Coll[1]=1 Then Obey=1 ElseIf Coll[0]=0 Then Obey=1 Else Obey=0
			Select(Coll[Obey])
				Case 0,4,5 y:+movY;Finish=True
				Case 1 y=Floor((y+movY)/25)*25+25;
					movY=0;
					moveY=0;
					HeadButt()
					Finish=False
				Case 2
					y:+movY
					movY=0
					If y Mod 25<25-x Mod 25
						y=Floor(y/25)*25+25-x Mod 25
						moveY=0
						HeadButt()
					EndIf
					Finish=True
				Case 3
					y:+movY
					movY=0
					If y Mod 25<(x+wid) Mod 25
						y=Floor(y/25)*25+(x+wid) Mod 25
						moveY=0
						HeadButt()
					End If
					Finish=True
			EndSelect
		Wend
	EndMethod
	Method MoveDown(movY:Float)
		Local Obey:Byte=0
		Local Coll:Byte[2]
		Local Finish:Byte=False
		While Not Finish
			Coll[0]=Level.CheckCollision(x,y+hei+movY)
			Coll[1]=Level.CheckCollision(x+wid,y+hei+movY)
			If Coll[0]=1 Then Obey=0 ElseIf Coll[1]=1 Then Obey=1 ElseIf Coll[0]=0 Then Obey=1 Else Obey=0
			Select(Coll[Obey])
				Case 0,2,3 y:+movY;Finish=True
				Case 1 y=Floor((y+movY+hei)/25)*25-phei;
					movY=0;
					moveY=0;
					Land()
					Finish=False
				Case 4
					y:+movY
					movY=0
					If (y+hei) Mod 25>25-(x+wid) Mod 25
						y=Floor((y+hei)/25)*25-hei+25-(x+wid) Mod 25
						moveY=0
						Land()
					EndIf
					Finish=True
				Case 5
					y:+movY
					movY=0
					If (y+hei) Mod 25>x Mod 25
						y=Floor((y+hei)/25)*25-hei+x mod 25
						moveY=0
						Land()
					End If
					Finish=True
			EndSelect
		Wend
	EndMethod
	Method MoveLeft(movX:Float)
		Local Obey:Byte=0
		Local Coll:Byte[2]
		Local Finish:Byte=False
		Local which:Byte=0
		While Not Finish
			Coll[0]=Level.CheckCollision(x+movX,y)
			Coll[1]=Level.CheckCollision(x+movX,y+hei)
			If Coll[0]=0 Then which=1
			Select(Coll[which])
				Case 0,3,4 x:+movX;Finish=True
				Case 1 
					If Coll[1]=1 And Not Level.CheckCollision(x+movX,y+hei-5)
						y=Floor((y+hei)/25)*25-phei
						x:+moveX
					Else
						x=Floor(x/25)*25;movX=0;moveX=0
					EndIf
					Finish=False
				Case 5 
					x:+movX
					movX=0
					If Coll[0]>Coll[1] Then Obey=1
					If Obey=1
						y=Floor(y/25)*25-phei+(x Mod 25)
						movex:/2
					ElseIf (y+hei) Mod 25>x Mod 25
						y=Floor((y+hei)/25)*25-phei+(x Mod 25)
						movex:/2
					EndIf
					Finish=True
				Case 2
					x:+movX
					movX=0
					If Coll[0]<Coll[1] Then Obey=1
					If Obey=1
						y=Floor((y+hei)/25)*25+(25-x Mod 25)
						movex:/2
					ElseIf y Mod 25<25-(x Mod 25)
						y=Floor(y/25)*25+(25-x Mod 25)
						movex:/2
					EndIf
					Finish=True
			EndSelect
		Wend
	EndMethod
	Method MoveRight(movX:Float)
		Local Obey:Byte=0
		Local Coll:Byte[2]
		Local Finish:Byte=False
		Local which:Byte=0
		While Not Finish
			Coll[0]=Level.CheckCollision(x+movX+wid,y)
			Coll[1]=Level.CheckCollision(x+movX+wid,y+hei)
			If Coll[0]=0 Then which=1
			Select(Coll[which])
				Case 0,2,5 x:+movX;Finish=True
				Case 1 
					If Coll[1]=1 And Not Level.CheckCollision(x+movX+wid,y+hei-5)
						y=Floor((y+hei)/25)*25-phei
						x:+moveX
					Else
						x=Floor((x+movX+wid)/25)*25-pwid;movX=0;moveX=0
					EndIf
					Finish=False
				Case 4 
					x:+movX
					movX=0
					If Coll[0]>Coll[1] Then Obey=1
					If Obey=1
						y=Floor(y/25)*25-hei+(25-(x+wid) Mod 25)
						movex:/2
					ElseIf (y+hei) Mod 25>25-(x+wid) Mod 25
						y=Floor((y+hei)/25)*25-phei+(25-(x+wid) Mod 25)
						movex:/2
					EndIf
					Finish=True
				Case 3
					x:+movX
					movX=0
					If Coll[0]<Coll[1] Then Obey=1
					If Obey=1
						y=Floor((y+hei)/25)*25+((x+wid) Mod 25)
						movex:/2
					ElseIf y Mod 25<(x+wid) Mod 25
						y=Floor(y/25)*25+((x+wid) Mod 25)
						movex:/2
					EndIf
					Finish=True
			EndSelect
		Wend
	EndMethod
	EndRem
	Method Land(ortho:Byte=1) 
	EndMethod
	Method HeadButt() 
	EndMethod
	Method Push(px:Float,py:Float)
		movex:+px
		movey:+py
	EndMethod
	Method Push2(px:Float,py:Float)
		If px<>0
			If Not Level.PreciseCollision(x+wid/2+(wid/2)*Sgn(px)+px,y) And Not Level.PreciseCollision(x+wid/2+(wid/2)*Sgn(px)+px,y+hei)
				x:+px
			EndIf
		ElseIf py<>0
			If Not Level.PreciseCollision(x,y+hei/2+(hei/2)*Sgn(py)+py) And Not Level.PreciseCollision(x+wid,y+hei/2+(hei/2)*Sgn(py)+py)
				y:+py
			EndIf
		End If
	EndMethod
EndType

Type TRectObject Extends TObject Abstract
	Method HitLine:Float[](xa:Float, ya:Float, xb:Float, yb:Float) 
		Return GeoLineVSRect(xa,ya,xb,yb,x,y,wid,hei)
	EndMethod
	Method HitRect:Byte(xa:Float, ya:Float, wi:Float, he:Float)
		Local tempx:Int=xa-x
		Local tempy:Int=ya-y
		If tempx>=-wi And tempx<=pwid And tempy>=-he And tempy<=phei
			Return 1
		EndIf
		Return 0
	EndMethod
	Method HitPoint:Byte(xa:Float, ya:Float) 
		Local tempx:Int=xa-x
		Local tempy:Int=ya-y
		If tempx>=0 And tempx<=pwid And tempy>=0 And tempy<=phei
			Return 1
		EndIf
		Return 0
	EndMethod
	Method HitCircle:Byte(xa:Float,ya:Float,radi:Byte)
		If GeoLineVSCircle(x,y,x+wid,y,xa,ya,radi)[0] Or..
		 GeoLineVSCircle(x+wid,y,x+wid,y+hei,xa,ya,radi)[0] Or..
		 GeoLineVSCircle(x,y,x,y+hei,xa,ya,radi)[0] Or..
		 GeoLineVSCircle(x,y+hei,x+wid,y+hei,xa,ya,radi)[0]
			Return 1
		EndIf
		Return 0
	EndMethod
	Method Kill(dir:Float=0)
	EndMethod
	Method Damage(pow:Float,dir:Float=0)
	EndMethod
EndType

Type TCircbject Extends TObject Abstract
	Field rad:Byte
	Method HitLine:Float[](xa:Float, ya:Float, xb:Float, yb:Float) 
		Return GeoLineVSCircle(xa,ya,xb,yb,x,y,rad)
	EndMethod
	Method HitRect:Byte(xa:Float, ya:Float, wi:Float, he:Float)
		If GeoLineVSCircle(xa,ya,xa+wi,ya,x,y,rad)[0] Or..
		 GeoLineVSCircle(xa+wi,ya,xa+wi,ya+he,x,y,rad)[0] Or..
		 GeoLineVSCircle(xa,ya,xa,ya+he,x,y,rad)[0] Or..
		 GeoLineVSCircle(xa,ya+he,xa+wi,ya+he,x,y,rad)[0]
			Return 1
		EndIf
		Return 0
	EndMethod
	Method HitPoint:Byte(xa:Float, ya:Float) 
		If Dist2(x,y,xa,ya)<=rad*rad
			Return 1
		EndIf
		Return 0
	EndMethod
	Method HitCircle:Byte(xa:Float,ya:Float,radi:Byte)
		If Dist2(xa,ya,xa,ya)<=(rad+radi)*(rad+radi)
			Return 1
		EndIf
		Return 0
	EndMethod
	Method Kill(dir:Float=0)
	EndMethod
	Method Damage(pow:Float,dir:Float=0)
	EndMethod
EndType

