
SuperStrict

Framework brl.glmax2d
Import brl.stream
Import brl.Graphics
Import brl.pngloader

Graphics 600,600

Global gfx:TImage[5]
gfx[0]=LoadImage("gfx1.png")
gfx[1]=LoadImage("gfx2.png")
gfx[2]=LoadImage("gfx3.png")
gfx[3]=LoadImage("gfx6.png")
gfx[4]=LoadImage("gfx9.png")

Global lev:Byte[30,30]

SetBlend(ALPHABLEND)
If FileSize("./levels.txt")=-1 Then CreateFile("./levels.txt")
Local s:TStream=OpenStream("./levels.txt",1,1)

If FileSize("./levels2.txt")=-1 Then CreateFile("./levels2.txt")
Local s2:TStream=OpenStream("./levels2.txt",1,1)
While True
	Local str:String=s.ReadLine()
	If str="" Then exit
		For Local j:Byte=0 Until 20
			For Local i:Byte=0 Until 20
				lev[i,j]=Byte(str[i+j*20..i+j*20+1])
			Next
		Next
		str=""
		For Local j:Byte=0 Until 20
			For Local i:Byte=0 Until 20
				str:+lev[i,j]
			Next
		Next
		s2.WriteLine(str)
Wend
s2.Close()

s.Seek(s.Size()-1)
While Not KeyDown(KEY_ESCAPE)
	SetAlpha(0.3)
	DrawRect(270,270,60,60)
	SetAlpha(1)
	Local px:Byte=Floor(MouseX()/30)
	Local py:Byte=Floor(MouseY()/30)
	For Local i:Byte=0 Until 30
		For Local j:Byte=0 Until 30
			If lev[i,j]>0 Then DrawImage(gfx[lev[i,j]-1],i*30,j*30)
		Next
	Next
	If KeyDown(KEY_1) Then lev[px,py]=0
	If KeyDown(KEY_2) Then lev[px,py]=1
	If KeyDown(KEY_3) Then lev[px,py]=2
	If KeyDown(KEY_4) Then lev[px,py]=3
	If KeyDown(KEY_5) Then lev[px,py]=4
	If KeyDown(KEY_6) Then lev[px,py]=5
	SetAlpha(0.5)
	DrawRect(px*30,py*30,30,30)
	SetAlpha(1)
	If KeyHit(KEY_S)
		Local str:String=""
		For Local j:Byte=0 Until 20
			For Local i:Byte=0 Until 20
				str:+lev[i,j]
			Next
		Next
		s.WriteLine(str)
	End If
	If KeyHit(KEY_C)
		For Local j:Byte=0 Until 20
			For Local i:Byte=0 Until 20
				lev[i,j]=0
			Next
		Next
	EndIf
	Flip
	Cls
Wend

s.Close()