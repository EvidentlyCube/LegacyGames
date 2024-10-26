
Type TEnemySquare Extends TRectObject
	Field dmg:Float=0.5
	Field frm:Byte=0
	Method Damage(pow:Float,dir:Float=0)
		dmg=1
		hp:-pow
		If hp<0
			Self.Kill()
		EndIf
	EndMethod
	Method Kill(dir:Float=0)
		Lists.Enemies.Remove(Self)
	EndMethod
	Method Update()
		MoveX=Sgn(Player.x-x)
		MoveY:+Level.Gravity
		Self.MoveHorizontal()
		Self.MoveVertical()
		Draw()
	End Method
	Method Draw()
		If dmg>0.5 Then dmg:-0.05
		Drawing.ShapeRect(x,y,wid,hei)
	EndMethod
	Function MakeNew(x:Int,y:Int,wid:Short,hei:Short)
		Local en:TEnemySquare=New TEnemySquare
		en.x=x
		en.y=y
		en.wid=wid-1
		en.hei=hei-1
		en.pwid=wid
		en.phei=hei
		en.hp=10
		Lists.Enemies.AddLast(en)
	EndFunction
EndType