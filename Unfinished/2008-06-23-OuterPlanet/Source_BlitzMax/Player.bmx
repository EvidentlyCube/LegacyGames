Type TPlayer Extends TRectObject
	Field MAXHP:Float = 100
	Field ACCEL:Float = 0.5
	Field MAXSPEED:Byte = 3
	Field MAXJUMPS:Byte = 1
	Field MAXJUMPHEIGHT:Byte = 11
	Field lockMove:Byte = 0
	Field lockJump:Byte = 0
	Field lockFall:Byte = 0
	Field Jumper:Byte = 0
	Field Jumps:Byte = 1
	Field Legs:TLegs
	Field Gun:TGun
	Field Dir:Float
	Global XMouse:Short
	Global YMouse:Short
	Method New()
		hp=MAXHP
		wid=9
		pwid=wid+1
		hei=19
		phei=hei+1
		x=250
		y=300
		Legs=New TLegs
		Gun=New TGun
	EndMethod
	Method Update() 
		CheckInput()
		MoveHorizontal()
		MoveVertical()
		Level.ResetCanvas()
		Player.reSetMouse()
		SetDir()
	EndMethod
	Method Draw()
		If Dir>90 Or Dir<-90
			Local temp_dir:Float=ATan2(Y+4-YMouse,X+5-XMouse)
			Drawing.SetEffects(1,temp_dir/3,-1)
		Else
			Drawing.SetEffects(1,dir/3)
		EndIf
		Drawing.Draw(Legs.x,Legs.y,GFX_P_Body)
		Drawing.SetEffects()
	EndMethod
	Method CheckInput() 
		If Not lockMove
			If KeyDown(Opts.Key[0]) 
				If Legs.seq<2
					Legs.seq=1
					Legs.frame:+18
				EndIf
				If moveX>=MAXSPEED
					moveX=Max(MAXSPEED,moveX-ACCEL)
				Else 
					moveX:+ACCEL
				EndIf
			Else If KeyDown(Opts.Key[2])
				If Legs.seq<2
					Legs.seq=1
					Legs.frame:+18
				EndIf
				If moveX<=-MAXSPEED
					moveX=Min(-MAXSPEED,moveX+ACCEL)
				Else
					moveX:-ACCEL
				EndIf
			Else
				If Legs.seq<2
					Legs.seq=0
					Legs.frame=0
				EndIf
				If Abs(moveX)<1
					moveX=0
				Else
					moveX:-ACCEL*Sgn(moveX)
				EndIf
			EndIf
		EndIf
		If Not lockJump
			If KeyHit(Opts.Key[3])
				If Level.PreciseCollision(x,y+phei+1) Or Level.PreciseCollision(x+wid,y+phei+1) Or..
					(y<=Floor((y+phei)/25)*25-phei And (Level.CheckCollision(x,y+phei+1)=9 Or Level.CheckCollision(x+wid,y+phei+1)=9))
					Jumps=MAXJUMPS
					moveY=-6
					Jumper=1
					Legs.seq=2
					Legs.frame=0
				ElseIf Jumps
					Jumps:-1
					moveY=-6
					Jumper=1
					Legs.seq=2
					Legs.frame=0
				EndIf
			EndIf
			If Jumper>0
				If Jumper<MAXJUMPHEIGHT And KeyDown(Opts.Key[3])
					moveY=Min(moveY,-6)
					Jumper:+1
				Else 
					Jumper=100
				EndIf
			EndIf
		EndIf
		Select MAx(Level.CheckCollision(x,y+phei+1),Level.CheckCollision(x+wid,y+phei+1))
			Case 7
				Push2(1,0)
			Case 8
				Push2(-1,0)
		EndSelect
		If Not lockFall
			If Not Level.PreciseCollision(x,y+phei+1) And Not Level.PreciseCollision(x+wid,y+phei+1) And..
				Not (y<=Floor((y+phei)/25)*25-phei And (Level.CheckCollision(x,y+phei+1)=9 Or Level.CheckCollision(x+wid,y+phei+1)=9))
				moveY=Min(moveY+Level.Gravity,Level.MAXFALL)
				If Legs.seq<2 
					Legs.seq=2
					Legs.frame=60
				EndIf
			ElseIf Level.CheckCollision(x,y+phei+1)=6 Or Level.CheckCollision(x+wid,y+phei+1)=6
				moveY=Min(moveY+Level.Gravity,Level.MAXFALL)
			EndIf
		Else 
			lockFall:-1 
		EndIf
	EndMethod
	Method Land(ortho:Byte=1)
		Jumper=0
		Jumps=MAXJUMPS
		If ortho=1
			Legs.seq=0
			Legs.frame=0
		EndIf
	EndMethod
	Method HeadButt()
		jumper=100
	EndMethod
	Method SetDir()
		Dir=ATan2(YMouse-Gun.Y,XMouse-gun.X)
		Legs.x=x+5
		Legs.y=y+8+Sin(Legs.frame)
		If Player.Dir>90 Or Player.Dir<-90
			Local temp_dir:Float=ATan2(gun.y-YMouse,gun.x-XMouse)
			Local temp_atan:Float=ATan2(4,-4)
			gun.x=Legs.x+Sin(temp_atan-temp_dir/3)*5.4
			gun.y=Legs.y+Cos(temp_atan-temp_dir/3)*5.4
		Else
			Local temp_atan:Float=ATan2(-4,-4)
			gun.x=Legs.x+Sin(temp_atan-dir/3)*5.4
			gun.y=Legs.y+Cos(temp_atan-dir/3)*5.4
		EndIf
	End Method
	Method Damage(pow:Float,dir:Float=0)
		hp:-pow
	EndMethod
	Function reSetMouse()
		XMouse=MouseX()+Level.TopLeftX
		YMouse=MouseY()+Level.TopLeftY
	EndFunction
EndType

Type TLegs
	Field x:Float
	Field y:Float
	Field frame:Float
	Field seq:Byte
	Method Draw()
		x=Player.x+5
		y=Player.y+10
		SequenceDetermine()
		SetColor(255,255,255)
		Local Change:Int=20
		If Player.Dir>90 Or Player.Dir<-90
			SetScale(-1,1)
			change=-20
		EndIf
		If Seq=0
			Drawing.Draw(x,y,GFX_P_Legs)
		ElseIf Seq=1
			SetRotation(Sin(-frame)*55+change)
			Drawing.Draw(x,y,GFX_P_LegBack)
			SetRotation(Sin(frame)*55+change)
			Drawing.Draw(x,y,GFX_P_LegFront)
		Else
			SetRotation(frame)
			Drawing.Draw(x,y,GFX_P_LegBack)
			SetRotation(-frame)
			Drawing.Draw(x,y,GFX_P_LegFront)
		EndIf
		Drawing.SetEffects()
	EndMethod
	Method SequenceDetermine()
		Select seq
			Case 2
				If Player.MoveY<0 And Frame<60
					Frame:+3
				ElseIf Player.MoveY>0 And Frame>0
					Frame:-0.5
				ElseIf Player.moveY=0
					Seq=0
					Frame=0
				EndIf
		End Select
	EndMethod
EndType
Type TGun
	Field x:Float
	Field y:Float
	Field Dir:Float
	Method Draw()
		dir=ATan2(Player.YMouse-Y+1,Player.XMouse-X+1)
		Local sX:Float=x+Cos(dir)*17
		Local sY:Float=y+Sin(dir)*17
		'dir=ATan2(sy-y,sx-x)
		If Dir>90 Or Dir<-90
			SetRotation(dir+180)
			SetScale(-1,1)
		Else
			SetRotation(dir)
			SetScale(1,1)
		EndIf
		Drawing.Draw(X,Y-1,GFX_P_Gun)
		SetRotation(0)
		SetScale(1,1)
		PlayerWeapons.Update(sX,sY,dir)
	EndMethod
EndType