
Type TEnemyBlob Extends TRectObject
	Field dmg:Float=0
	Field frm:Int=0
	Method Damage(pow:Float,dir:Float=0)
		dmg=1
		hp:-pow
		If hp<0
			Self.Kill()
		EndIf
	EndMethod
	Method Kill(dir:Float=0)
		For Local i:Byte=0 To 2
			TExplosion.MakeNew(x,y,[0,255,0],RndFloat()-0.5,-RndFloat(),0.3)
		Next
		Lists.Enemies.Remove(Self)
	EndMethod
	Method Update()
		If Not KeyDown(KEY_SPACE)
		If frm=0
			MoveX=Sgn(Player.x-x)
			Self.MoveHorizontal()
			MoveY:+Level.Gravity
			Self.MoveVertical()
		Else
			MoveY:+Level.Gravity
			Self.MoveVertical()
			frm:+20
			If frm>180
				frm=0
				MoveY=Rand(-12,-2)
			End If
		EndIf
		EndIf
		Draw()
	End Method
	Method Draw()
		SetScale(1+Sin(frm)/2,1-Sin(frm)/2)
		Drawing.Draw(x+5,y+6,GFX_E_BLOB)
		If dmg>0
			SetBlend(LIGHTBLEND)
			Drawing.DrawAlphed(dmg,x+5,y+6,GFX_E_BLOB)
			dmg:-0.1
			SetBlend(ALPHABLEND)
		EndIf
		SetScale(1,1)
	EndMethod
	Method Land(ortho:Byte=1)
		If frm=0 Then frm=1
	EndMethod
	Function MakeNew(x:Int,y:Int)
		Local en:TEnemyBlob=New TEnemyBlob
		en.x=x
		en.y=y
		en.wid=10
		en.hei=6
		en.pwid=11
		en.phei=7
		en.hp=4
		Lists.Enemies.AddLast(en)
	EndFunction
EndType