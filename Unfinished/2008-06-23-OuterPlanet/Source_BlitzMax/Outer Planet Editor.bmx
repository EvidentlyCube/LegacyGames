'---------------------------------------------------------------------------------------------------
' This program was written with BLIde (www.blide.org)
' Application:
' Author:
' License:
'---------------------------------------------------------------------------------------------------
SuperStrict
Framework brl.GLMax2d
Import BRL.Math
Import BRL.Graphics
Import BRL.filesystem
Import BRL.Random
Import brl.PNGLoader
Import brl.JPGLoader
Import brl.StandardIO
Import brl.Hook
Import brl.event

Const VERSION:Byte=2

SetGraphicsDriver GLMax2DDriver() 
Local g:TGraphics = CreateGraphics(1024, 768, 0, 0, GRAPHICS_BACKBUFFER) 
SetGraphics g

SetBlend(ALPHABLEND)

EnablePolledInput
Global Level:TBlock[,,]

Global GFX_Blocks:TImage=LoadAnimImage("./Data/blocks.png",25,25,0,221)
Global GFX_Shape:TImage=LoadAnimImage("./Data/shapes.png",25,25,0,17)


Type TBlock
	Field gfx:Short
	Field shape:Byte
EndType

Global Width:Short=40
Global Height:Short=30
Global TopLeftX:Int
Global TopLeftY:Int
Global Mode:Byte=0
Global Block:Byte=0
Global Shape:Byte=0
Global Selects:Byte=0
Global levellink:String
If AppArgs.Length>1 And String(AppArgs[1])<>""
	levellink=AppArgs[1]
Else
	levellink=RequestFile("Select Level to Load, or Cancel to create empty level!","Outer Planet Level File:oplvl",False,CurrentDir()+"/")
EndIf
If levellink<>"" 
	LevelFromFile(levellink)
Else
	
	
	While Not KeyHit(KEY_ENTER)
		DrawText("Set Width 40-255 using arrow Keys:",100,100)
		If KeyHit(KEY_UP) Then Width:-10
		If KeyHit(KEY_DOWN) Then Width:+10
		If KeyHit(KEY_LEFT) Then Width:-1
		If KeyHit(KEY_RIGHT) Then Width:+1
		Width=Min(255,Max(40,Width))
		DrawText(Width,100,120)
		Flip
		Cls
	Wend
	While Not KeyHit(KEY_ENTER)
		DrawText("Set Height 40-255 using arrow Keys:",100,100)
		If KeyHit(KEY_UP) Then Height:-10
		If KeyHit(KEY_DOWN) Then Height:+10
		If KeyHit(KEY_LEFT) Then Height:-1
		If KeyHit(KEY_RIGHT) Then Height:+1
		Height=Min(255,Max(30,Height))
		DrawText(Height,100,120)
		Flip
		Cls
	Wend
	
	Level=New TBlock[Width,Height,2]
EndIf
While Not KeyDown(KEY_ESCAPE)
	If KeyHit(KEY_1) Then Mode=0
	If KeyHit(KEY_2) Then Mode=1
	If KeyHit(KEY_3) Then Mode=2
	If Mode=0
		DrawText("BACKGROUND",5,5)
	ElseIf Mode=1
		DrawText("FOREGROUND",5,5)
	Else
		DrawText("SHAPES",5,5)
	EndIf
	If KeyDown(KEY_SPACE) Then Selects=Max(1,Mode) Else Selects=0
	If KeyDown(KEY_W) Then TopLeftY:-25
	If KeyDown(KEY_S) Then TopLeftY:+25
	If KeyDown(KEY_A) Then TopLeftX:-25
	If KeyDown(KEY_D) Then TopLeftX:+25
	TopLeftX=Max(0,Min(Width*25-1024,TopLeftX))
	TopLeftY=Max(0,Min(Height*25-768,TopLeftY))
	Local ModX:Short=TopLeftX Mod 25
	Local ModY:Short=TopLeftY Mod 25
	DrawText(Width+"x"+Height,5,15)
	DrawText((TopLeftX/25)+"x"+(TopLeftY/25),5,25)
	DrawText(((TopLeftX+MouseX())/25)+"x"+((TopLeftY+MouseY())/25),5,35)
	If Selects=0
		Local LeftX:Int=Max(0,Floor(TopLeftX/25))
		Local LeftY:Int=Max(0,Floor(TopLeftY/25))
		For Local i:Short=LeftX To Min(LeftX+40,Width-1)
			For Local j:Short=LeftY To Min(LeftY+30,Height-1)
				If Level[i,j,1]
					if mode>0 Then SetAlpha(0.5)
					DrawImage(GFX_Blocks,(i-LeftX)*25-ModX,(j-LeftY)*25-ModY,Level[i,j,1].gfx)
					SetAlpha(1)
				EndIf
				If Mode>0
					If Level[i,j,0]
						DrawImage(GFX_Blocks,(i-LeftX)*25-ModX,(j-LeftY)*25-ModY,Level[i,j,0].gfx)
						If mode=2
							SetAlpha(0.5)
							DrawImage(GFX_Shape,(i-LeftX)*25-ModX,(j-LeftY)*25-ModY,Level[i,j,0].shape)
							SetAlpha(1)
						EndIf
					EndIf
				EndIf
			Next
		Next
		Local zuX:Int=Floor((MouseX()+TopLeftX)/25)
		Local zuY:Int=Floor((MouseY()+TopLeftY)/25)
		If Mode<2
			If zuX>=0 And zuX<Width And zuY>=0 And zuY<Height
				SetAlpha(0.5)
				DrawImage(GFX_Blocks,Floor(MouseX()/25)*25-modX,Floor(MouseY()/25)*25-modY,Block)
				SetAlpha(1)
				If MouseDown(1)
					Local da:TBlock=New TBlock
					da.gfx=Block
					Level[zuX,zuY,1-Mode]=da
				EndIf
				If MouseDown(2)
					Level[zuX,zuY,1-Mode]=Null
				End If
			EndIf
		Else
			If zuX>=0 And zuX<Width And zuY>=0 And zuY<Height
				SetAlpha(0.5)
				DrawImage(GFX_Shape,Floor(MouseX()/25)*25-modX,Floor(MouseY()/25)*25-modY,Shape)
				SetAlpha(1)
				If MouseDown(1)
					If Level[zuX,zuY,0] Then Level[zuX,zuY,0].Shape=Shape
				EndIf
				If MouseDown(2)
					If Level[zuX,zuY,0] Then Level[zuX,zuY,0].Shape=0
				End If
			EndIf
		EndIf
	ElseIf Selects=1
		For Local i:Short=0 Until GFX_Blocks.frames.Length
			DrawImage(GFX_Blocks,125+(i Mod 20)*25,125+Floor(i/20)*25,i)
		Next
		Local gix:Int=Floor((MouseX()-125)/25)
		Local giy:Int=Floor((MouseY()-125)/25)
		If gix+giy*20>=0 And gix+giy*20<GFX_Blocks.frames.Length
			SetAlpha(0.5)
			DrawRect(gix*25+125,giy*25+125,25,25)
			SetAlpha(1)
			If MouseHit(1)
				Block=gix+giy*20
			EndIf
		EndIf
	Else
		For Local i:Short=0 Until GFX_Shape.frames.Length
			DrawImage(GFX_Shape,125+(i Mod 20)*25,125+Floor(i/20)*25,i)
		Next
		Local gix:Int=Floor((MouseX()-125)/25)
		Local giy:Int=Floor((MouseY()-125)/25)
		If gix+giy*20>=0 And gix+giy*20<GFX_Shape.frames.Length
			SetAlpha(0.5)
			DrawRect(gix*25+125,giy*25+125,25,25)
			SetAlpha(1)
			If MouseHit(1)
				Shape=gix+giy*20
			EndIf
		EndIf
	EndIf
	Flip 1
	Cls
Wend

If levellink<>""
	SaveToFile(RequestFile("Select File to Save, or Cancel to create random filename in levels dir!","Outer Planet Level File:oplvl",True,levellink))
Else
	SaveToFile(RequestFile("Select File to Save, or Cancel to create random filename in levels dir!","Outer Planet Level File:oplvl",True,CurrentDir()+"/"))
EndIf

Function SaveToFile(Link:String)
	If Link=""
		Link="./Levels/"+"backup_"+CurrentDate().Replace(" ","'")+"_"+CurrentTime().Replace(":","'")+".oplvl"
		While FileSize(Link)<>-1
			Link="./Levels/"+"backup_"+CurrentDate().Replace(" ","'")+"_"+CurrentTime().Replace(":","'")+".oplvl"
		Wend
	EndIf
	If FileSize(Link)=-1
		CreateFile(Link)
	Else 
		DeleteFile(Link)
		CreateFile(Link)
	EndIf
	Local Stream:TStream=WriteStream(Link)
	WriteByte(Stream,VERSION)
	WriteByte(Stream,Width)
	WriteByte(Stream,Height)
	For Local i:Short=0 Until Width
		For Local j:Short=0 Until Height
			If Level[i,j,1]
				WriteByte(Stream,1)
				WriteByte(Stream,i)
				WriteByte(Stream,j)
				WriteShort(Stream,Level[i,j,1].gfx)
			EndIf
			If Level[i,j,0]
				WriteByte(Stream,0)
				WriteByte(Stream,i)
				WriteByte(Stream,j)
				WriteShort(Stream,Level[i,j,0].gfx)
				WriteByte(Stream,Level[i,j,0].Shape)
			EndIf
		Next
	Next
	CloseStream(Stream)
EndFunction

Function LevelFromFile(Link:String)
	Local Stream:TStream=ReadStream(Link)
	Local Vers:Byte=ReadByte(Stream)
	print Vers
	If Vers<VERSION Then Notify("Version of loaded level is lower than version of editor");end
	If Vers>VERSION
		Notify("Version of loaded level is bigger than version of editor - terminating!")
		End
	EndIf
	Width=ReadByte(Stream)
	Height=ReadByte(Stream)
	Level=New TBlock[Width,Height,2]
	Local Block:TBlock
	Local x:Int
	Local y:Int
	While Not Eof(Stream)
		Select ReadByte(Stream)
			Case 0
				Block=New TBlock
				x=ReadByte(Stream)
				y=ReadByte(Stream)
				Block.gfx=ReadShort(Stream)
				Block.shape=ReadByte(Stream)
				Level[x,y,0]=Block
			Case 1
				Block=New TBlock
				x=ReadByte(Stream)
				y=ReadByte(Stream)
				Block.gfx=ReadShort(Stream)
				Level[x,y,1]=Block
		EndSelect
	Wend
	CloseStream(Stream)
EndFunction