'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TOption
	Global Options:TList=New TList
	Field wid:Int
	Field hei:Int
	Field x:Int
	Field y:Int
	Field CEdit:Byte
	Field CSelected:Int
	Field Shade:Byte
	Field Nam:String=""
	Field Des:String=""
	Function Hover()
		For Local i:TOption=EachIn TOption.options
			If i.Shade=2 And (Edit<>i.CEdit Or Selected<>i.CSelected) Then i.shade=1
			If i.CEdit=0
				SetColor(Colors[CRoom,Colored,0],Colors[CRoom,Colored,1],Colors[CRoom,Colored,2])
				DrawImage(GFX_BLOCKS,i.x,i.y,i.cselected)
				SetColor(255,255,255)
				DrawImage(GFX_BLOCKS_LAY,i.x,i.y,i.cselected)
				SetColor(255,255,255)
			EndIf
			If MouseX()>=i.X And MouseY()>=i.Y And MouseX()<i.X+i.wid And MouseY()<i.Y+i.hei
				If i.shade=1 Then i.shade=2
				If mhit1
					Edit=i.CEdit
					Selected=i.CSelected
				EndIf
				If i.CEdit=0
					SetBlend(LIGHTBLEND)
					SetAlpha(0.5)
					DrawRect(i.x,i.y,i.wid,i.hei)
					SetAlpha(1)
					SetBlend(ALPHABLEND)
				EndIf
			End If
			If i.shade=1
				SetColor(0,0,0)
				SetAlpha(0.5)
				DrawRect(i.x,i.y,i.wid,i.hei)
				SetAlpha(1)
				SetColor(255,255,255)
			EndIf
		Next
	EndFunction
	Function Make(X:Int,Y:Int,cedit:Byte,csel:Int,shad:Byte,nam:String,des:String,wid:Int=25,hei:Int=35)
		Local lo:TOption=New TOption
		lo.x=x
		lo.y=y
		lo.CEdit=cedit
		lo.CSelected=csel
		lo.Shade=shad
		lo.Nam=nam
		lo.Des=des
		lo.wid=wid
		lo.hei=hei
		TOption.Options.addlast(lo)
	EndFunction
End Type
Type TOColor
	Global Options:TList=New TList
	Field wid:Int
	Field hei:Int
	Field x:Int
	Field y:Int
	Field Color:Byte
	Function Hover()
		For Local i:TOColor=EachIn TOColor.options
			If MouseX()>=i.X And MouseY()>=i.Y And MouseX()<i.X+i.wid And MouseY()<i.Y+i.hei
				If mhit1
					Colored=i.color
				EndIf
				SetAlpha(0.5)
				DrawRect(i.x-5,i.y,5,i.hei)
				DrawRect(i.x+i.wid,i.y,5,i.hei)
				SetAlpha(1)
			End If
			SetColor(Colors[CRoom,i.color,0],Colors[CRoom,i.color,1],Colors[CRoom,i.color,2])
			DrawImage(GFX_BRICK,i.X,i.Y)
			SetColor(255,255,255)
			If Colored=i.color
				DrawRect(i.x-5,i.y,5,i.hei)
				DrawRect(i.x+i.wid,i.y,5,i.hei)
			EndIf
		Next
	EndFunction
	Function Make(X:Int,Y:Int,col:Byte,wid:Int=20,hei:Int=20)
		Local lo:TOColor=New TOColor
		lo.x=x
		lo.y=y
		lo.color=col
		lo.wid=wid
		lo.hei=hei
		TOColor.Options.addlast(lo)
	EndFunction
End Type
Type TOGroup
	Global Options:TList=New TList
	Field wid:Int
	Field hei:Int
	Field x:Int
	Field y:Int
	Field group:Byte
	Function Hover()
		For Local i:TOGroup=EachIn TOGroup.options
			Local shade:Byte=0
			If MouseX()>=i.X And MouseY()>=i.Y And MouseX()<i.X+i.wid And MouseY()<i.Y+i.hei
				If mhit1
					Edit=2
					Selected=i.group
				EndIf
				shade=1
			End If
			If Edit<>2 Or Selected<>i.group
				SetColor(0,0,0)
				If shade=1 Then SetAlpha(0.2) Else SetAlpha(0.5)
				DrawRect(i.x,i.y,i.wid,i.hei)
				SetAlpha(1)
				SetColor(255,255,255)
			EndIf
		Next
	EndFunction
	Function Make(X:Int,Y:Int,group:Byte,wid:Int=15,hei:Int=15)
		Local lo:TOGroup=New TOGroup
		lo.x=x
		lo.y=y
		lo.group=group
		lo.wid=wid
		lo.hei=hei
		TOGroup.Options.addlast(lo)
	EndFunction
End Type
Type TColorBar
	Global X:Int=885
	Global Y:Int=349
	Global wid:Int=40
	Global hei:Int=255
	Global space:Int=45
	Function Hover()
		If MouseX()>=X And MouseY()>=Y And MouseX()<X+wid And MouseY()<Y+hei
			If MouseDown(1)
				Colors[CRoom,Colored,0]=MouseY()-y
				D_Changes=1
			EndIf
		EndIf
		If MouseX()>=X+space And MouseY()>=Y And MouseX()<X+space+wid And MouseY()<Y+hei
			If MouseDown(1)
				Colors[CRoom,Colored,1]=MouseY()-y
				D_Changes=1
			EndIf
		EndIf
		If MouseX()>=X+space*2 And MouseY()>=Y And MouseX()<X+wid+space*2 And MouseY()<Y+hei
			If MouseDown(1)
				Colors[CRoom,Colored,2]=MouseY()-y
				D_Changes=1
			EndIf
		EndIf
		For Local j:Short=0 To 255
			SetColor(j,Colors[CRoom,Colored,1],Colors[CRoom,Colored,2])
			DrawRect(x,y+j,wid,1)
			SetColor(Colors[CRoom,Colored,0],j,Colors[CRoom,Colored,2])
			DrawRect(x+space,y+j,wid,1)
			SetColor(Colors[CRoom,Colored,0],Colors[CRoom,Colored,1],j)
			DrawRect(x+space*2,y+j,wid,1)
		Next
		SetColor(0,0,0)
		DrawRect(x,y+Colors[CRoom,Colored,0],wid,1)
		SetColor(0,0,0)
		DrawRect(x+space,y+Colors[CRoom,Colored,1],wid,1)
		SetColor(0,0,0)
		DrawRect(x+space*2,y+Colors[CRoom,Colored,2],wid,1)
		SetColor(255,255,255)
	EndFunction
EndType
Type TCurrBlock
	Global Options:TList=New TList
	Field x:Int
	Field y:Int
	Function Hover()
		For Local i:TCurrBlock=EachIn TCurrBlock.Options
			If Edit=0 and Selected<>-1
				DrawImage(GFX_BLOCKS,i.x,i.y,Selected)
				DrawImage(GFX_BLOCKS_LAY,i.x,i.y,Selected)
			EndIf
		Next
	EndFunction
	Function Make(x:Int,y:Int)
		Local lo:TCurrBlock=New TCurrBlock
		lo.x=x
		lo.y=y
		TCurrBlock.Options.AddLast(lo)
	EndFunction
EndType
Type TSetValues
	Global Options:TList=New TList
	Field X:Int
	Field Y:Int
	Field wid:Int
	Field hei:Int
	Field sc:Int
	Field sc2:Int
	Field Edited:Int
	Function Hover()
		
	EndFunction
EndType
Type TGameField
	Global X:Int=14
	Global Y:Int=150
	Global wid:Int=800
	Global Hei:Int=455
	Global GWid:Byte=25
	Global GHei:Byte=35
	Global offset:Byte=1
	Function Hover()
		SetOrigin(OriginX,OriginY)
		If MouseX()>X+offset*GWid And MouseX()<x+wid And MouseY()>Y And MouseY()<y+hei
			Local moX:Short=Floor((MouseX()-x)/25)*25
			Local moY:Short=Floor((MouseY()-y)/35)*35
			Select Edit
				Case 0
					SetColor(Colors[CRoom,Colored,0],Colors[CRoom,Colored,1],Colors[CRoom,Colored,2])
					SetAlpha(0.6)
					DrawImage(GFX_BLOCKS,moX,moY,Selected)
					SetColor(255,255,255)
					DrawImage(GFX_BLOCKS_LAY,moX,moY,Selected)
					SetAlpha(1)
					If MouseDown(1)
						If TBlock.Free(moX,moY)
							If Selected<>53
								TBlock.MakeNew(moX,moY,Colored,Selected)
							Else
								TBlock.MakeNew(moX,moY,Colored,0,1)
							EndIf
						ElseIf TBlock.Which(moX,moY).lay=1
							SelBlock=TBlock.Which(moX,moY)
						EndIf
					EndIf
					If MouseDown(2)
						Local lo:TBlock=TBlock.Which(moX,moY)
						If lo
							lo.Kill()
							D_Changes=1
						EndIf
					End If
				Case 1
					SetAlpha(0.6)
					DrawImage(GFX_CHARS,moX,moY,Selected)
					SetAlpha(1)
					If MouseDown(1)
						Local lo:TBlock= TBlock.Which(moX,moY)
						If lo
							lo.Char[Selected,0]=1
							D_Changes=1
						EndIf
					EndIf
					If MouseDown(2)
						Local lo:TBlock= TBlock.Which(moX,moY)
						If lo
							lo.Char[Selected,0]=0
							D_Changes=1
						EndIf
					End If
				Case 2
					If MouseDown(1)
						Local lo:TBlock= TBlock.Which(moX,moY)
						If lo
							If Selected>16
								lo.Switch=Selected-17
								D_Changes=1
							Else
								lo.Group=Selected
								D_Changes=1
							EndIf
						EndIf
					EndIf
					If MouseDown(2)
						Local lo:TBlock= TBlock.Which(moX,moY)
						If lo
							If Selected>16
								lo.Switch=0
								D_Changes=1
							Else
								lo.Group=0
								D_Changes=1
							EndIf
						EndIf
					End If
			End Select
		EndIf
		SetOrigin(0,0)
	End Function
EndType
Type TColValue
	Global Options:TList=New TList
	Field X:Int
	Field Y:Int
	Field typ:Byte
	Field col:Byte
	Field wid:Byte
	Field hei:Byte
	Field edited:Byte=0
	Function Hover()
		For Local i:TColValue=EachIn Self.Options
			If mHit1=1
				i.edited=0
			EndIf
			If mHit1 And MouseX()>i.X And MouseY()>i.Y And MouseX()<i.X+i.wid And MouseY()<i.Y+i.hei
				i.edited=1
			EndIf
			Local val:Int=-1
				If i.edited
				If KeyHit(KEY_1) Then val=1
				If KeyHit(KEY_2) Then val=2
				If KeyHit(KEY_3) Then val=3
				If KeyHit(KEY_4) Then val=4
				If KeyHit(KEY_5) Then val=5
				If KeyHit(KEY_6) Then val=6
				If KeyHit(KEY_7) Then val=7
				If KeyHit(KEY_8) Then val=8
				If KeyHit(KEY_9) Then val=9
				If KeyHit(KEY_0) Then val=0
				If KeyHit(KEY_BACKSPACE) Then val=10
				If val<>-1
					If val=10
						ColorScore[CRoom,i.col,i.typ]=Floor(ColorScore[CRoom,i.col,i.typ]/10)
						D_Changes=1
					ElseIf ColorScore[CRoom,i.col,i.typ]<100
						ColorScore[CRoom,i.col,i.typ]=ColorScore[CRoom,i.col,i.typ]*10+val
						D_Changes=1
					End If
				If ColorScore[CRoom,i.col,i.typ]>255 Then ColorScore[CRoom,i.col,i.typ]=255
				EndIf
				DrawRect(i.X,i.Y+i.hei-3,i.wid,3)
			EndIf
			DrawText(ColorScore[CRoom,i.col,i.typ],i.x,i.y)
		Next
	EndFunction
	Function Make(x:Int,y:Int,typ:Byte,col:Byte,wid:Byte=34,hei:Byte=20)
		Local lo:TColValue=New TColValue
		lo.X=x
		lo.Y=y
		lo.typ=typ
		lo.col=col
		lo.wid=wid
		lo.hei=hei
		Self.Options.AddLast(lo)
	EndFunction
EndType
Type TGroupValue
	Global X:Int=485
	Global Y:Int=640
	Global wid:Byte=45
	Global hei:Byte=23
	Global edited:Byte=0
	Function Hover()
		If mHit1=1
			edited=0
		EndIf
		If mHit1 And MouseX()>X And MouseY()>Y And MouseX()<X+wid And MouseY()<Y+hei
			edited=1
		EndIf
		Local val:Int=-1
		If Edit=2 And Selected>0 And Selected<17
			If edited 
			If KeyHit(KEY_1) Then val=1
			If KeyHit(KEY_2) Then val=2
			If KeyHit(KEY_3) Then val=3
			If KeyHit(KEY_4) Then val=4
			If KeyHit(KEY_5) Then val=5
			If KeyHit(KEY_6) Then val=6
			If KeyHit(KEY_7) Then val=7
			If KeyHit(KEY_8) Then val=8
			If KeyHit(KEY_9) Then val=9
			If KeyHit(KEY_0) Then val=0
			If KeyHit(KEY_BACKSPACE) Then val=10
				If val<>-1
					If val=10
						GroupBonus[CRoom,Selected-1]=Floor(GroupBonus[CRoom,Selected-1]/10)
						D_Changes=1
					ElseIf GroupBonus[CRoom,Selected-1]<10000
						GroupBonus[CRoom,Selected-1]=GroupBonus[CRoom,Selected-1]*10+val
						D_Changes=1
					End If
				EndIf
				If GroupBonus[CRoom,Selected-1]>65535 Then GroupBonus[CRoom,Selected-1]=65535
				DrawRect(X,Y+hei-3,wid,3)
			EndIf
			DrawText(GroupBonus[CRoom,Selected-1],x,y)
		Else
			DrawImage(GFX_CROSS,x,y)
		EndIf
	EndFunction
EndType

Type TLayer
	Global Options:TList=New TList
	Field x:Int
	Field y:Int
	Field wid:Byte=25
	Field hei:Byte=35
	Field lay:Byte
	Method Hov()
		If SelBlock<>Null
			Print "BLOCK:"+SelBlock.Block[lay]
			DrawImage(GFX_FIELD,x-2,y-2)
			If SelBlock.Block[lay]<>-1
				SetColor(Colors[CRoom,SelBlock.Color[lay],0],Colors[CRoom,SelBlock.Color[lay],1],Colors[CRoom,SelBlock.Color[lay],2])
				DrawImage(GFX_BLOCKS,X,Y,SelBlock.Block[lay])
				SetColor(255,255,255)
				DrawImage(GFX_BLOCKS_LAY,X,Y,SelBlock.Block[lay])
				If D_Sides
					For Local i:Byte=0 To 3
						If SelBlock.Char[i,lay]=1 Then DrawImage(GFX_CHARS,X,Y,i)
					Next
				EndIf
			EndIf
			If MouseX()>x And MouseY()>y And MouseX()<x+wid And MouseY()<y+hei
				Select Edit
					Case 0
						If mHit1 And B_GROUPS[Selected]=1
							SelBlock.Block[lay]=Selected
							SelBlock.Color[lay]=Colored
							D_Changes=1
						EndIf
						If mHit2
							If lay>0
								SelBlock.Block[lay]=-1
								SelBlock.Char[0,lay]=0
								SelBlock.Char[1,lay]=0
								SelBlock.Char[2,lay]=0
								SelBlock.Char[3,lay]=0
								D_Changes=1
							Else
								SelBlock.Kill()
								D_Changes=1
							EndIf
						EndIf
					Case 1
						If mHit1 And Selected<4 And SelBlock.Block[lay]<>-1
							SelBlock.Char[Selected,lay]=1
							D_Changes=1
						EndIf
						If mHit2 And Selected<4 And SelBlock.Block[lay]<>-1
							SelBlock.Char[Selected,lay]=0
							D_Changes=1
						EndIf
				End Select
			EndIf
		EndIf
	EndMethod
	Function Hover()
		For Local i:TLayer=EachIn Self.Options
			i.Hov()
		Next
	EndFunction
	Function Make(x:Int,y:Int,lay:Byte)
		Local lo:TLayer=New TLayer
		lo.x=x
		lo.y=y
		lo.lay=lay
		Self.Options.AddLast(lo)
	EndFunction
EndType

Function DrawDesc()
	DrawText(Int(Floor(CRoom/8)+1)+"-"+(CRoom Mod 8+1),926,17)
	Select Edit
		Case 0
			SetColor(0,0,0)
			DrawText(B_NAME[Selected],83,674)
			DrawText(B_DESC[Selected],83,688)
			If B_GROUPS[Selected] Then DrawText("Yes",83,702) Else DrawText("No",83,702)
			If B_ARMOR[Selected] Then DrawText("Yes",83,716) Else DrawText("No",83,716)
			SetColor(255,255,255)
			DrawText(B_NAME[Selected],81,672)
			DrawText(B_DESC[Selected],81,686)
			If B_GROUPS[Selected] Then DrawText("Yes",81,700) Else DrawText("No",81,700)
			If B_ARMOR[Selected] Then DrawText("Yes",81,714) Else DrawText("No",81,714)
	End Select
EndFunction

Function CheckOpts()
	If mHit1
		If MouseX()>301 And MouseX()<324 And MouseY()>640 And MouseY()<663
			D_Sides:+1-D_Sides*2
		EndIf
		If MouseX()>346 And MouseX()<369 And MouseY()>640 And MouseY()<663
			D_Chars:+1-D_Chars*2
		EndIf
		If MouseX()>391 And MouseX()<414 And MouseY()>640 And MouseY()<663
			D_Groups:+1-D_Groups*2
		EndIf
		If MouseX()>436 And MouseX()<459 And MouseY()>640 And MouseY()<663
			D_CurGroup:+1-D_CurGroup*2
		EndIf
		If MouseX()>840 And MouseX()<875 And MouseY()>150 And MouseY()<185
			D_Grid:+1-D_Grid*2
		EndIf
		If MouseX()>840 And MouseX()<875 And MouseY()>200 And MouseY()<235
			CRoom=(CRoom+1) Mod 64
		EndIf
		If MouseX()>840 And MouseX()<875 And MouseY()>250 And MouseY()<285
			CRoom:-1
			If CRoom<0 Then CRoom:+64
		EndIf
		If MouseX()>700 And MouseX()<777 And MouseY()>628 And MouseY()<663
			save()
		EndIf
		If MouseX()>790 And MouseX()<867 And MouseY()>628 And MouseY()<663
			Loadc()
		EndIf
		If MouseX()>884 And MouseX()<961 And MouseY()>628 And MouseY()<663
			Loadb()
		EndIf
		If MouseX()>840 And MouseX()<875 And MouseY()>570 And MouseY()<605
			If Confirm("Do you really want to clear this Room?")
				For Local i:TBlock=EachIn TBlock.Bricks[CRoom]
					i.Kill()
				Next
			EndIf
		EndIf
	EndIf
	If mHit2
		If MouseX()>840 And MouseX()<875 And MouseY()>200 And MouseY()<235
			CRoom=(CRoom+8) Mod 64
		EndIf
		If MouseX()>840 And MouseX()<875 And MouseY()>250 And MouseY()<285
			CRoom:-8
			If CRoom<0 Then CRoom:+64
		EndIf
		If MouseX()>884 And MouseX()<961 And MouseY()>628 And MouseY()<663
			Saveb()
		EndIf
	EndIf
	If KeyHit(KEY_NUMADD)
		CRoom=(CRoom+1) Mod 64
	End If
	If KeyHit(KEY_NUMSUBTRACT)
		CRoom:-1
		If CRoom<0 Then CRoom:+64
	End If
	If KeyHit(KEY_G)
		D_Grid:+1-D_Grid*2
	EndIf
	If D_Sides Then DrawImage(GFX_CROSS,301,640)
	If D_Chars Then DrawImage(GFX_CROSS,346,640)
	If D_Groups Then DrawImage(GFX_CROSS,391,640)
	If D_CurGroup Then DrawImage(GFX_CROSS,436,640)
End Function

Function DrawGrid()
	If D_Grid
		SetOrigin(OriginX,OriginY)
		SetAlpha(0.4)
		For Local i:Byte=0 To 32
			DrawLine(i*25,0,i*25,455)
		Next
		For Local i:Byte=0 To 13
			DrawLine(0,i*35,800,i*35)
		Next
		SetAlpha(1)
		SetOrigin(0,0)
	EndIf
EndFunction
TOption.Make(45,5,1,4,1,"Destroyed Block","Such Block begins as a destroyed Block")
TOption.Make(75,5,1,3,1,"Top Armor","Brick gets invulnerable from Top")
TOption.Make(105,5,1,6,1,"Invisble","Brick Is invisible unless hit, then becomes visible")
TOption.Make(45,45,1,2,1,"Left Armor","Brick gets invulnerable from Left")
TOption.Make(105,45,1,0,1,"Right Armor","Brick gets invulnerable from Right")
TOption.Make(75,85,1,1,1,"Bottom Armor","Brick gets invulnerable from Bottom")
TOption.Make(105,85,1,5,1,"Inactive","Block remains inactive unless proper switch Block is Hit")

For Local i:Byte=0 To 54
	TOption.Make(170+(i Mod 22)*30,5+Floor(i/22)*40,0,i,0,B_NAME[i],B_DESC[i])
Next
TOption.Make(45,85,0,53,0,"","")

For Local i:Byte=0 To 16
	TOGroup.Make(180+i*25,130,i)
Next

For Local i:Byte=0 To 3
	TOGroup.Make(710+i*25,130,i+17)
Next

For Local i:Byte=0 To 7
	TOColor.Make(895,148+i*25,i)
Next

TCurrBlock.Make(75,45)

For Local i:Int=0 To 7
	TColValue.Make(932,148+25*i,0,i)
	TColValue.Make(978,148+25*i,1,i)
Next

For Local i:Byte=0 To 8
	TLayer.Make(10+30*i,628,i)
Next