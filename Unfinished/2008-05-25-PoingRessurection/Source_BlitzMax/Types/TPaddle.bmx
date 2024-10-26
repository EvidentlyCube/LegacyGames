'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
 bbdoc:Undocumented type
End Rem
Type TPaddle
	Field x:Int
	Field y:Int
	Field wid:Int
	Field hei:Int
	Method Update()
		y:+(MouseY()-SCREEN_HEIGHT/2)*2
		y=Max(0,Min(y,455-hei))
		MoveMouse(SCREEN_WIDTH/2,SCREEN_HEIGHT/2)
	EndMethod
	Method Collide:Byte(_x:Float,_y:Float,_rad:Int)
		If _x-_rad<=x+wid And _x>=x+wid And _y+_rad>=y And _y-_rad<=y+hei
			Return 1
		EndIf
		Return 0
	End Method
	Method Draw()
		SetScale(1,Float(hei)/100)
		Drawing.Image(GFX_PADDLE,x,y)
		SetScale(1,1)
	EndMethod
	Function MakeNew:TPaddle(_x:Int,_y:Int,_w:Int,_h:Int)
		Local lo:TPaddle=New TPaddle
		lo.x=_x
		lo.y=_y
		lo.wid=_w
		lo.hei=_h
		Return lo
	EndFunction
End Type
