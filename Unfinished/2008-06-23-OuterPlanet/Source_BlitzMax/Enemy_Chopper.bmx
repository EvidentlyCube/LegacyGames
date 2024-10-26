
Type TEnemyChopper Extends TRectObject
	Field dmg:Float=0
	Field frm:Byte=0
	Field tick:Byte=10
	Field dest:Int[3]
	Method Damage(pow:Float,dir:Float=0)
		If Rand(pow)>2 Then TDebris.MakeNew(x,y,dir+Rand(-40,40),2+RndFloat()*5,80+Rand(50))
		dmg=1
		hp:-pow
		If hp<0
			Self.Kill()
		EndIf
	EndMethod
	Method Kill(dir:Float=0)
		TFallingChopper.MakeNew(x+6,y+3,moveX,moveY)
		TExplosion.Explode(x+6,y+3,[255,255,255],2,0.2,3)
		Lists.Enemies.Remove(Self)
	EndMethod
	Method Update()
		tick:-1
		If tick=0
			tick=rand(10,25)
			Local dis:Int=Dist(x,y,Player.x,Player.y)
			If dis<500 And dis>80
				Local rpos:Float[]=Level.RayCast(x,y,Player.x-x,Player.y-y)
				If Rand(3)=1
					TFireBall.MakeNew(x,y,ATan2(Player.y-y,Player.x-x),5,3,10)
				EndIf
				If dis<Dist(x,y,rpos[0],rpos[1])
					If dis<80
						dest[0]=x
						dest[1]=y
						dest[2]=1
					Else
						dest[0]=Player.x
						dest[1]=Player.y
						dest[2]=0
					EndIf
				Else
					dest[0]=x+Rand(-50,50)
					dest[1]=y+Rand(-50,50)
					dest[2]=0
				EndIf
			ElseIf dis<=80 And dest[2]=0
				Local rpos:Float[]=Level.RayCast(x,y,Player.x-x,Player.y-y)
				If dis<Dist(x,y,rpos[0],rpos[1])
					dest[0]=x
					dest[1]=y
					dest[2]=1
				EndIf
			EndIf
		EndIf
		Local deg:Float=ATan2(dest[1]-y,dest[0]-x)
		moveX:+Cos(deg)/5
		moveY:+Sin(deg)/5
		If moveX>4 Then moveX=4
		If moveX<-4 Then moveX=-4
		If moveY>4 Then moveY=4
		If moveY<-4 Then moveY=-4
		Self.MoveHorizontal()
		Self.MoveVertical()
		Draw()
	End Method
	Method Draw()
		frm=(frm+1)Mod 4
		Drawing.Draw(x+6,y+3,GFX_E_CHOPPER,frm)
		If dmg>0
			SetBlend(LIGHTBLEND)
			Drawing.DrawAlphed(dmg,x+6,y+3,GFX_E_CHOPPER,frm)
			SetBlend(ALPHABLEND)
			dmg:-0.1
		EndIf
	EndMethod
	Function MakeNew(x:Int,y:Int)
		Local en:TEnemyChopper=New TEnemyChopper
		en.x=x
		en.y=y
		en.wid=10
		en.hei=10
		en.pwid=11
		en.phei=11
		en.hp=40
		en.dest=[x,y,0]
		Lists.Enemies.AddLast(en)
	EndFunction
EndType