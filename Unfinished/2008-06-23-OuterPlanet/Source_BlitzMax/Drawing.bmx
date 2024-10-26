
Type Drawing
	Global WaitPos:Float=-80
	Function Draw(x:Int,y:Int,image:TImage,frame:Short=0)
		x:-Level.TopLeftX
		y:-Level.TopLeftY
		If x>-image.width And x<1024+image.width And y>-image.height And y<768+image.height
			DrawImage(image,x,y,frame)
		EndIf
	EndFunction
	Function ShapeLine(x1:Int,y1:Int,x2:Int,y2:Int)
		x1:-Level.TopLeftX
		y1:-Level.TopLeftY
		x2:-Level.TopLeftX
		y2:-Level.TopLeftY
		DrawLine(x1,y1,x2,y2)
	EndFunction
	Function ShapePlot(x:Int,y:Int)
		x:-Level.TopLeftX
		y:-Level.TopLeftY
		plot(x,y)
	EndFunction
	Function ShapeOval(x:Int,y:Int,wid:Int,hei:Int)
		x:-Level.TopLeftX
		y:-Level.TopLeftY
		DrawOval(x,y,wid,hei)
	EndFunction
	Function ShapeRect(x:Int,y:Int,wid:Int,hei:Int)
		x:-Level.TopLeftX
		y:-Level.TopLeftY
		DrawRect(x,y,wid,hei)
	EndFunction
	Function DrawRotated(angle:Float,x:Int,y:Int,image:TImage,frame:Short=0)
		x:-Level.TopLeftX
		y:-Level.TopLeftY
		SetRotation(angle)
		If x>-image.width And x<1024+image.width And y>-image.height And y<768+image.height
			DrawImage(image,x,y,frame)
		EndIf
		SetRotation(0)
	EndFunction
	Function DrawScaled(scalex:Float,scaley:Float,x:Int,y:Int,image:TImage,frame:Short=0)
		x:-Level.TopLeftX
		y:-Level.TopLeftY
		SetScale(scalex,scaley)
		If x>-image.width And x<1024+image.width And y>-image.height And y<768+image.height
			DrawImage(image,x,y,frame)
		EndIf
		SetScale(1,1)
	EndFunction
	Function DrawAlphed(alpha:Float,x:Int,y:Int,image:TImage,frame:Short=0)
		x:-Level.TopLeftX
		y:-Level.TopLeftY
		SetAlpha(alpha)
		If x>-image.width And x<1024+image.width And y>-image.height And y<768+image.height
			DrawImage(image,x,y,frame)
		EndIf
		SetAlpha(1)
	EndFunction
	Function SetEffects(alpha:Float=1,rotation:Float=0,scalex:Float=1,scaley:Float=1,r:Byte=255,g:Byte=255,b:Byte=255)
		SetScale(scalex,scaley)
		SetAlpha(alpha)
		SetRotation(rotation)
		SetColor(r,g,b)
	EndFunction
	Function DrawCross(_x:Int,_y:Int)
		Draw(_x,_y,GFX_CROSS)
	EndFunction
	Function DrawHud()
		If PlayerWeapons.WeaponWaitMax>10 And PlayerWeapons.WeaponWait>0
			WaitPos:*0.5
		Else
			WaitPos=Max(-80,WaitPos*2-1)
		EndIf
		DrawImage(GFX_HUD_BACK,0,10)
		DrawImage(GFX_HUD_BACK,0,130)
		DrawImage(GFX_HUD_BACK,WaitPos,250)
		DrawImage(GFX_HUD_BARS1,13,30,0)
		DrawImage(GFX_HUD_BARS1,13,150,1)
		DrawImage(GFX_HUD_BARS1,Waitpos+13,270,2)
		SetScale(1,Player.hp/Player.MAXHP)
		DrawImage(GFX_HUD_BARS2,13,95,0)
		SetScale(1,PlayerWeapons.Ammo[PlayerWeapons.Weapon]/PlayerWeapons.MaxAmmo[PlayerWeapons.Weapon])
		DrawImage(GFX_HUD_BARS2,13,215,1)
		SetScale(1,Float(PlayerWeapons.WeaponWait)/PlayerWeapons.WeaponWaitMax)
		DrawImage(GFX_HUD_BARS2,WaitPos+13,335,2)
		SetScale(1,1)
		SetColor(0,0,0)
		TextCenter(Short(Player.hp),22,98)
		TextCenter(Short(PlayerWeapons.Ammo[PlayerWeapons.Weapon]),22,218)
		TextCenter(Short(PlayerWeapons.WeaponWait),WaitPos+22,338)
		SetColor(255,255,255)
		TextCenter(Short(Player.hp),21,97)
		TextCenter(Short(PlayerWeapons.Ammo[PlayerWeapons.Weapon]),21,217)
		TextCenter(Short(PlayerWeapons.WeaponWait),WaitPos+21,337)
	EndFunction
	Function TextLeft(txt:String,x:Int,y:Int)
		Local wide:Int
		For Local i:Short=0 Until txt.Length
			Local char:Int=Asc(txt[i..i+1])-32
			wide:-GFX_FONT_SPACES[char]
			DrawImage(GFX_FONT,x+wide,y,char)
			wide:+13
		Next
	EndFunction
	Function TextCenter(txt:String,x:Int,y:Int)
		Local wide:Int
		For Local i:Short=0 Until txt.Length
			wide:-GFX_FONT_SPACES[Asc(txt[i..i+1])-32]-13
		Next
		wide:/-2
		For Local i:Short=0 Until txt.Length
			Local char:Int=Asc(txt[i..i+1])-32
			wide:-GFX_FONT_SPACES[char]
			DrawImage(GFX_FONT,x+wide,y,char)
			wide:+13
		Next
	EndFunction
EndType