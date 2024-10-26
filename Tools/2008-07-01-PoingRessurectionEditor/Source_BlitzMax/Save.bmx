'This BMX file was edited with BLIde ( http://www.blide.org )

Function save()
	Local file:String=RequestFile("Select File to Save","Poing Levelset:plset",1,AppDir+"/")
	If file="" Then Return
	If FileSize(file)=-1
		CreateFile(file)
	Else
		DeleteFile(file)
		CreateFile(file)
	EndIf
	Local s:TStream=OpenStream(file,1,1)
	For Local czax:Byte=0 To 63
		CRoom=czax
		WriteByte(s,10)					'Record Room ID
		WriteByte(s,CRoom)
		WriteByte(s,0) 					'Record Colors
		For Local i:Byte=0 To 7
			WriteByte(s,Colors[CRoom,i,0])
			WriteByte(s,Colors[CRoom,i,1])
			WriteByte(s,Colors[CRoom,i,2])
		Next
		WriteByte(s,1) 					'Record Color Values
		For Local i:Byte=0 To 7
			WriteByte(s,ColorScore[CRoom,i,0])
			WriteByte(s,ColorScore[CRoom,i,1])
		Next
		WriteByte(s,2) 					'Record Group Values
		For Local i:Byte=0 To 15
			WriteByte(s,GroupBonus[CRoom,i])
		Next
		WriteByte(s,3) 					'Record Gravity Settings
		WriteShort(s,Grav_Dir)
		WriteByte(s,Grav_Pow)
		'Record Blocks
		For Local i:TBlock=EachIn TBlock.Bricks[CRoom]
			If i.lay=0
				WriteByte(s,4)			'Record single block
				WriteByte(s,i.X/25)
				WriteByte(s,i.Y/35)
				WriteByte(s,i.Block[0])
				WriteByte(s,i.Color[0])
				For Local z:Byte=0 To 6
					WriteByte(s,i.Char[z,0])
				Next
				WriteByte(s,i.Group)
				WriteByte(s,i.Switch)
			Else
				WriteByte(s,5)			'Record layered block
				WriteByte(s,i.X/25)
				WriteByte(s,i.Y/35)
				For Local k:Byte=0 To 8
					WriteByte(s,i.Block[k])
					WriteByte(s,i.Color[k])
					For Local z:Byte=0 To 3
						WriteByte(s,i.Char[z,k])
					Next
				Next
				WriteByte(s,i.Char[4,0])
				WriteByte(s,i.Char[5,0])
				WriteByte(s,i.Char[6,0])
				WriteByte(s,i.Group)
				WriteByte(s,i.Switch)
			EndIf
		Next
	Next
	CloseStream(s)
EndFunction