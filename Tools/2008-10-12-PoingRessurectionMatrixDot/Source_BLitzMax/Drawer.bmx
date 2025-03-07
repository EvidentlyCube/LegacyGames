

Graphics 1134,400

Global c:TColorRGB=ColorCreateRGB(136,101,49)
Global loops:Byte=0
frame.frames.AddFirst(New frame)

SetBlend(ALPHABLEND)
While Not KeyDown(KEY_ESCAPE)
	If MouseX()>10 And MouseY()>10
		If MouseDown(1) Then frame.put((MouseX()-10)/16,(MouseY()-10)/16,1)
		If MouseDown(2) Then frame.put((MouseX()-10)/16,(MouseY()-10)/16,0)
	EndIf
	If KeyHit(KEY_NUMADD) Then frame.Make() ElseIf KeyHit(KEY_NUMSUBTRACT) Then frame.Dele()
	If KeyHit(KEY_LEFT) Then frame.curframe:-1
	If KeyHit(KEY_RIGHT) Then frame.curframe:+1
	If KeyHit(KEY_C) Then frame.cop()
	If KeyHit(KEY_V) Then frame(frame.frames.ValueAtIndex(frame.curframe)).pas()
	If KeyHit(KEY_S) Then frame.anispeed=Max(frame.anispeed-1,1)
	If KeyHit(KEY_D) Then frame.anispeed=Min(frame.anispeed+1,250)
	If KeyHit(KEY_L) Then loops=1-loops
	If KeyHit(KEY_F1) Then Savefi()
	If KeyHit(KEY_F2) Then Loadfi()
	If KeyHit(KEY_F3) Then Importfi()
	SetColor(31,30,16)
	For Local i:Short=0 Until 490
		DrawRect(10+(i Mod 70)*16,10+Floor(i/70)*16,10,10)
		DrawRect(10+(i Mod 70)*8,160+Floor(i/70)*8,6,6)
		DrawRect(10+(i Mod 70)*8,250+Floor(i/70)*8,6,6)
	Next
	frame.check()
	frame(frame.frames.ValueAtIndex(frame.curframe)).Draw(True)
	frame(frame.frames.ValueAtIndex(frame.curframe)).Draw(False,10,160)
	frame.update()
	frame(frame.frames.ValueAtIndex(frame.aniframe)).Draw(False,10,250)
	If KeyDown(KEY_DOWN)
		Local czop:Int=frame.curframe-1
		If czop<0 Then czop=frame.frames.Count()-1
		SetAlpha(0.7)
		frame(frame.frames.ValueAtIndex(czop)).Draw(True)
		SetAlpha(1)
	EndIf
	If KeyDown(KEY_UP)
		Local czop:Int=frame.curframe+1
		If czop=frame.frames.Count() Then czop=0
		SetAlpha(0.7)
		frame(frame.frames.ValueAtIndex(czop)).Draw(True)
		SetAlpha(1)
	EndIf
	SetColor(255,255,255)
	DrawText("Loop:"+loops+" (Toggle with L - 1=true 0=false)",620,150)
	DrawText((frame.curframe+1)+"/"+frame.frames.Count(),620,180)
	DrawText("Animation speed:"+frame.anispeed,620,195)
	DrawText("S,D - Change animation Speed",620,210)
	DrawText("C,V - Copy, Paste frame content",620,225)
	DrawText("Numpad +,- - Insert/delete frame",620,240)
	DrawText("Arrow Left, Right - Change frame",620,255)
	DrawText("Arrow Up,Down - Onion Skin",620,270)
	DrawText("1/2/3/Mouse Whell - change color",620,285)
	DrawText("F1 - Save,  F2 - Load, F3 - Import SPR",620,300)
	Flip
	Cls
Wend

Type frame
	Global frames:TList=New TList
	Global curframe:Int=0
	Global aniframe:Int=0
	Global anispeed:Int=10
	Global anicount:Int=0
	Global copy:frame
	Field ar:Byte[70,7]
	Method New()
		For Local i:Byte=0 Until 70
			For Local j:Byte=0 Until 7
				ar[i,j]=0
			Next
		Next
	EndMethod
	Method Draw(zoom:Byte=False,bx:Short=10,by:Short=10)
		For Local i:Byte=0 Until 70
			For Local j:Byte=0 Until 7
				If ar[i,j]>0
					If zoom
						drawezoom(ar[i,j],i,j)
					Else
						drawe(ar[i,j],i,j,bx,by)
					EndIf
				EndIf
			Next
		Next
	EndMethod
	Function update()
		anicount:+1
		While anicount>=anispeed
			anicount:-anispeed
			aniframe:+1
			If aniframe=frames.Count()
				aniframe=0
			EndIf
		WEnd
	EndFunction
	Function put(x:Byte,y:Byte,co:Byte)
		If x>69 Or y>6 Then Return
		Local cur:frame=frame(frames.ValueAtIndex(curframe))
		cur.ar[x,y]=co
	EndFunction
	Function check()
		If curframe=frames.Count()
			curframe=0
		ElseIf curframe<0
			curframe=frames.Count()-1
		EndIf
		If aniframe>=frames.Count()
			aniframe=0
		EndIf
	EndFunction
	Function Make()
		Check()
		Local link:TLink=frames.FindLink(frames.ValueAtIndex(curframe))
		frames.InsertAfterLink(New frame,link)
		curframe:+1
	EndFunction
	Function cop()
		copy=frame(frames.ValueAtIndex(curframe))
	EndFunction
	Method pas()
		For Local i:Byte=0 Until 70
			For Local j:Byte=0 Until 7
				ar[i,j]=copy.ar[i,j]
			Next
		Next
	EndMethod
	Function Dele()
		
		frames.Remove(frames.ValueAtIndex(curframe))
		If frames.Count()=0 Then frames.AddFirst(New frame)
		check()
	EndFunction
EndType

Function drawe(co:Byte,x:Byte,y:Byte,bx:Short=10,by:Short=10)
	c.SetDrawing()
	DrawRect(bx+x*8,by+y*8,6,6)
EndFunction
Function drawezoom(co:Byte,x:Byte,y:Byte)
	c.SetDrawing()
	DrawRect(10+x*16,10+y*16,12,12)
EndFunction

REM

System zapisu:
Pierwsze bajty
1. 00-FF - Speed animacji
2. 00 - Loop; 01 - Don't loop

Klatka animacji:
1,2,3.Kolor 1,2,3: 	00 - skipnij do następnego koloru
					01-FF - narysuj następny pixel X kratek dalej 



ENDREM

Function Savefi()
	Local file:String=RequestFile("Select file to save","poinganim",True,"./")
	If file="" Then Notify("No file selected, Save aborted"); Return;
	If FileSize(file)>-1 Then DeleteFile(file)
	CreateFile(file)
	Local s:TStream=OpenStream(file,1,1)
	s.WriteByte(frame.anispeed)
	s.WriteByte(loops)
	For Local f:frame=EachIn frame.frames
		Local v:Byte=0
		For Local a:Short=0 Until 490
			v:+1
			If v=250 Then Exit
			If f.ar[a Mod 70,Floor(a/70)]>0
				s.WriteByte(v)
				v=0
			EndIf
		Next
		s.WriteByte(0)
		v=0
	Next
	s.Close()
EndFunction

Function Loadfi()
	Local file:String=RequestFile("Select file to load","poinganim",False,"./")
	If file="" Then Notify("No file selected, Load aborted"); Return;
	frame.frames.Clear()
	Local s:TStream=OpenStream(file,1,1)
	frame.anispeed=s.ReadByte()
	loops=s.ReadByte()
	While Not s.Eof()
		Local f:frame=New frame
		frame.frames.AddLast(f)
		Local re:Byte
		Local pos:Int
		pos=-1
		Repeat
			re=s.ReadByte()
			If re=0
				Exit
			Else
				pos:+re
				f.ar[pos Mod 70,Floor(pos/70)]=1
			EndIf
		Forever
	Wend
	s.Close()
End Function

Function Importfi()
	Local file:String=RequestFile("Select SPR to import","spr",False,"./")
	If file="" Then Notify("No file selected, Load aborted"); Return;
	frame.frames.Clear()
	Local s:TStream=OpenStream(file,1,1)
	frame.anispeed=10
	loops=0
	s.Seek(11+256*3)
	While Not s.Eof()
		Local f:frame=New frame
		frame.frames.AddLast(f)
		Local re:Byte
		Local pos:Int
		pos=-1
		For Local bi:Int=0 Until 490
			re=s.ReadByte()
			pos:+1
			f.ar[pos Mod 70,Floor(pos/70)]=re
		Next
		If Not s.Eof()
			s.Seek(s.Pos()+2+256*3)
		EndIf
	Wend
	s.Close()
End Function