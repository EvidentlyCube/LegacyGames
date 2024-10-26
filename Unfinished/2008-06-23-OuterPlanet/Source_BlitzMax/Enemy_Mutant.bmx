
Type TEnemyMutant Extends TRectObject
	Field frame:Float=0
	Field state:Byte=0
	Field anim:Byte=0
	Field playX:Int=0
	Field time:Byte=20
	Field dir:Int=1
	Method Update()
		If anim=0
			If state=0 
				Local dis:Int=Dist(x,y,Player.x,Player.y)
				Local rpos:Float[]=Level.RayCast(x,y,Player.x-x,Player.y-y)
				If dis<Dist(x,y,rpos[0],rpos[1])
					If dis<150
						state=1
						time=1
					EndIf
				EndIf
				moveX=Sgn(moveX)
				If Level.PreciseCollision(x+Sgn(moveX)*6,y) Or Level.CheckCollision(x+Sgn(moveX)*6,y)=11+moveX Or (Level.PreciseCollision(x+Sgn(moveX)*7,y+40)=0 And Level.CheckCollision(x+Sgn(moveX)*7,y+40<>9))
					moveX:*-1
					anim=1
					frame=0
				End If
				MoveHorizontal()
			ElseIf state=1
				time:-1
				If time=0
					time=20
					Local dis:Int=Dist(x,y,Player.x,Player.y)
					Local rpos:Float[]=Level.RayCast(x,y,Player.x-x,Player.y-y)
					If dis<Dist(x,y,rpos[0],rpos[1])
						If dir<>Sgn(Player.x-x)
							anim=1
							frame=0
						EndIf
						playX=Player.X
					Else
						state=0
					EndIf
					If Sgn(playX-x)>0 Then moveX=2 Else moveX=-2
				EndIf
				If Level.PreciseCollision(x+Sgn(moveX)*15,y) And (Level.PreciseCollision(x,y+phei) Or Level.PreciseCollision(x+wid,y+phei))
					moveY=-9
				EndIf
				MoveHorizontal()
				moveX=Sgn(moveX)*2
				If moveX=0
					If Sgn(playX-x)>0 Then moveX=2 Else moveX=-2
				EndIf
			EndIf
		EndIf
		If moveX<>0 Then dir=Sgn(moveX)
		MoveY:+Level.Gravity
		MoveVertical()
		Draw()
	End Method
	Method Draw()
		Select anim
			Case 0
				frame=(frame+0.2) Mod 6
				Drawing.DrawScaled(dir,1,x+2,y,GFX_E_MUTANT,frame)
			Case 1
				frame:+0.5
				If frame>5.9
					anim=0
					frame=5
					Drawing.DrawScaled(dir,1,x+2,y,GFX_E_MUTANT,Floor(frame)+5)
					frame=0
				Else
					Drawing.DrawScaled(-Sgn(moveX),1,x+2,y,GFX_E_MUTANT,Floor(frame)+5)
				EndIf
		End Select
	EndMethod
	Method Damage(pow:Float,dir:Float=0)
		hp:-pow
		state=1
		If hp<0
			Self.Kill()
		EndIf
	EndMethod
	Method Kill(dir:Float=0)
		Lists.Enemies.Remove(Self)
	EndMethod
	Function MakeNew(x:Int,y:Int)
		Local en:TEnemyMutant=New TEnemyMutant
		en.x=x
		en.y=y
		en.wid=4
		en.hei=23
		en.pwid=5
		en.phei=24
		en.hp=25
		en.moveX=-1
		Lists.Enemies.AddLast(en)
	EndFunction
EndType