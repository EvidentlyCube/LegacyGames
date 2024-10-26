'This BMX file was edited with BLIde ( http://www.blide.org )

Function Loadb()
	Local link:String=RequestFile("Select level to load","Poing Levels:pnglvl",0,AppDir+"/")
	If link="" Then Return
	If ExtractExt(link)<>"pnglvl" Then Return
	If FileSize(link)=-1 Then Return
	Local s:TStream=OpenStream(link)
	For Local i:TBlock=EachIn TBlock.Bricks[CRoom]
		i.Kill()
	Next
	While Not Eof(s)
		Local cza:Byte=ReadByte(s)
		Print "TEST:"+cza
		Select (cza)
			Case 0
				For Local i:Byte=0 To 7
					Colors[CRoom,i,0]=ReadByte(s)
					Colors[CRoom,i,1]=ReadByte(s)
					Colors[CRoom,i,2]=ReadByte(s)
				Next
			Case 1
				For Local i:Byte=0 To 7
					ColorScore[CRoom,i,0]=ReadByte(s)
					ColorScore[CRoom,i,1]=ReadByte(s)
				Next
			Case 2
				For Local i:Byte=0 To 15
					GroupBonus[CRoom,i]=ReadByte(s)
				Next
			Case 3
				Grav_Dir=ReadShort(s)
				Grav_Pow=ReadByte(S)
			Case 4
				Local lo:TBlock=New TBlock
				lo.X=ReadByte(s)*25
				lo.Y=ReadByte(s)*35
				
				lo.Block[0]=ReadByte(s)
				lo.Color[0]=ReadByte(s)
				For Local z:Byte=0 To 6
					lo.Char[z,0]=ReadByte(s)
				Next
				lo.Group=ReadByte(s)
				lo.Switch=ReadByte(s)
				TBlock.Bricks[CRoom].AddLast(lo)
			Case 5
				Local lo:TBlock=New TBlock
				lo.lay=1
				lo.X=ReadByte(s)*25
				lo.Y=ReadByte(s)*35
				For Local i:Byte=0 To 8
					lo.Block[i]=ReadByte(s)
					If lo.Block[i]=255 Then lo.Block[i]=-1
					lo.Color[i]=ReadByte(s)
					For Local z:Byte=0 To 3
						lo.Char[z,i]=ReadByte(s)
					Next
				Next
				lo.Char[4,0]=ReadByte(s)
				lo.Char[5,0]=ReadByte(s)
				lo.Char[6,0]=ReadByte(s)
				lo.Group=ReadByte(s)
				lo.Switch=ReadByte(s)
				If lo.X<TGameField.wid
					TBlock.Bricks[CRoom].AddLast(lo)
				EndIf
				
		End Select
	Wend
	CloseStream(s)
	For Local i:TBlock=EachIn TBlock.Bricks[CRoom]
		If i.X>=800
			For Local j:TBlock=EachIn TBlock.Bricks[CRoom]
				j.X:-25
			Next
		EndIf
	Next
	For Local i:TBlock=EachIn TBlock.Bricks[CRoom]
		If i.X<0
			i.Kill()
		EndIf
	Next
EndFunction