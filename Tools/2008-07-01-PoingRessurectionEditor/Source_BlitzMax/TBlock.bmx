'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TBlock
	Global Bricks:TList[64]
	Field X:Int
	Field Y:Int
	Field Block:Int[9]
	Field Char:Int[7,9]
	Field Color:Int[9]
	Field Group:Byte=0
	Field Switch:Byte=0
	Field lay:Byte
	Method Draw()
		SetOrigin(OriginX,OriginY)
		If lay=0
			SetColor(Colors[CRoom,Color[0],0],Colors[CRoom,Color[0],1],Colors[CRoom,Color[0],2])
			DrawImage(GFX_BLOCKS,X,Y,Block[0])
			SetColor(255,255,255)
			DrawImage(GFX_BLOCKS_LAY,X,Y,Block[0])
		ElseIf SelBlock=Self
			DrawImage(GFX_LAYER,X,Y,1)
		Else 
			DrawImage(GFX_LAYER,X,Y,0)
		EndIf
		If D_Sides
			For Local i:Byte=0 To 3
				If Char[i,0]=1 Then DrawImage(GFX_CHARS,X,Y,i)
			Next
		EndIf
		If D_Chars
			For Local i:Byte=4 To 6
				If Char[i,0]=1 Then DrawImage(GFX_CHARS,X,Y,i)
			Next
		EndIf
		If D_Groups Or (D_CurGroup And Edit=2 And group=Selected) Or (D_CurGroup And Edit=2 And switch=Selected-17)
			SetColor(0,0,0)
			If group=0
				DrawRect(x+8,y+5,9,11)
				SetColor(255,255,255)
				DrawText("-",x+8,y+4)
			Else
				DrawRect(x+8,y+5,9,11)
				SetColor(255,255,255)
				DrawText(Chr(64+group),x+8,y+4)
			EndIf
			SetColor(0,0,0)
			If switch=0
				DrawRect(x+8,y+17,9,11)
				SetColor(255,255,255)
				DrawText("-",x+8,y+16)
			Else
				DrawRect(x+8,y+17,9,11)
				SetColor(255,255,255)
				DrawText(switch,x+8,y+16)
			EndIf
		End If
		SetOrigin(0,0)
	EndMethod
	Function Draws()
		For Local i:TBlock=EachIn TBlock.Bricks[CRoom]
			i.Draw()
		Next
	EndFunction
	Method Kill()
		If SelBlock=Self Then SelBlock=Null
		Self.Bricks[CRoom].Remove(Self)
	EndMethod
	Function Which:TBlock(X:Int,y:Int)
		For Local i:TBlock=EachIn Self.Bricks[CRoom]
			If i.X=X And i.Y=Y
				Return i
			End If
		Next
		Return Null
	EndFunction
	Function Free:Byte(X:Int,Y:Int)
		For Local i:TBlock=EachIn Self.Bricks[CRoom]
			If i.X=X And i.Y=Y
				Return 0
			End If
		Next
		Return 1
	EndFunction
	Function MakeNew(X:Short,Y:Short,color:Byte,Block:Byte,lay:Byte=0)
		Local lo:TBlock=New TBlock
		lo.X=x
		lo.Y=y
		lo.Color[0]=color
		lo.Block[0]=Block
		lo.Block[1]=-1
		lo.Block[2]=-1
		lo.Block[3]=-1
		lo.Block[4]=-1
		lo.Block[5]=-1
		lo.Block[6]=-1
		lo.Block[7]=-1
		lo.Block[8]=-1
		lo.lay=lay
		If lay=1 Then SelBlock=lo
		lo.Bricks[CRoom].AddLast(lo)
		D_Changes=1
	EndFunction
EndType