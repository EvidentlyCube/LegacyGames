SuperStrict

Framework brl.glmax2d
Import brl.basic
'Import brl.blitz
'Import brl.max2d
'Import brl.math
'Import brl.linkedlist
'Import brl.keycodes
Import brl.pngloader
'Import brl.graphics
'Import brl.glgraphics

' LOAD FILES

Incbin "1x1.png"
Incbin "1x2.png"
Incbin "1x3.png"
Incbin "1x4.png"
Incbin "1x5.png"
Incbin "1x6.png"
Incbin "1x7.png"
Incbin "1x8.png"
Incbin "1x9.png"
Incbin "1x1.png"
Incbin "2x1.png"
Incbin "3x1.png"
Incbin "4x1.png"
Incbin "5x1.png"
Incbin "6x1.png"
Incbin "7x1.png"
Incbin "8x1.png"
Incbin "9x1.png"
Incbin "2x2.png"
Incbin "3x2.png"
Incbin "2x3.png"
Incbin "3x3.png"
Incbin "block.png"
Incbin "blueLeft.png"
Incbin "blueRight.png"
Incbin "blueDown.png"
Incbin "blueUp.png"
Incbin "blueFlower.png"
Incbin "redLeft.png"
Incbin "redRight.png"
Incbin "redDown.png"
Incbin "redUp.png"
Incbin "redFlower.png"
Incbin "yellowLeft.png"
Incbin "yellowRight.png"
Incbin "yellowDown.png"
Incbin "yellowUp.png"
Incbin "yellowFlower.png"



' LOAD DESCRIPTORS
TBlockDescriptor.add($0A, 1, 1, "block.png")
TBlockDescriptor.add($6E, 1, 1, "blueLeft.png")
TBlockDescriptor.add($70, 1, 1, "blueRight.png")
TBlockDescriptor.add($71, 1, 1, "blueDown.png")
TBlockDescriptor.add($6F, 1, 1, "blueUp.png")
TBlockDescriptor.add($D2, 1, 1, "blueFlower.png")
TBlockDescriptor.add($64, 1, 1, "redLeft.png")
TBlockDescriptor.add($66, 1, 1, "redRight.png")
TBlockDescriptor.add($67, 1, 1, "redDown.png")
TBlockDescriptor.add($65, 1, 1, "redUp.png")
TBlockDescriptor.add($C8, 1, 1, "redFlower.png")
TBlockDescriptor.add($78, 1, 1, "yellowLeft.png")
TBlockDescriptor.add($7A, 1, 1, "yellowRight.png")
TBlockDescriptor.add($7B, 1, 1, "yellowDown.png")
TBlockDescriptor.add($79, 1, 1, "yellowUp.png")
TBlockDescriptor.add($DC, 1, 1, "yellowFlower.png")

TBlockDescriptor.add($32, 1, 1, "1x1.png")
TBlockDescriptor.add($34, 1, 2, "1x2.png")
TBlockDescriptor.add($38, 1, 3, "1x3.png")
TBlockDescriptor.add($33, 2, 1, "2x1.png")
TBlockDescriptor.add($37, 3, 1, "3x1.png")
TBlockDescriptor.add($36, 2, 2, "2x2.png")
TBlockDescriptor.add($3A, 2, 3, "2x3.png")
TBlockDescriptor.add($39, 3, 2, "3x2.png")
TBlockDescriptor.add($3B, 3, 3, "3x3.png")
TBlockDescriptor.add($4A, 1, 4, "1x4.png")
TBlockDescriptor.add($4B, 1, 5, "1x5.png")
TBlockDescriptor.add($4C, 1, 6, "1x6.png")
TBlockDescriptor.add($4D, 1, 7, "1x7.png")
TBlockDescriptor.add($4E, 1, 8, "1x8.png")
TBlockDescriptor.add($4F, 1, 9, "1x9.png")
TBlockDescriptor.add($40, 4, 1, "4x1.png")
TBlockDescriptor.add($41, 5, 1, "5x1.png")
TBlockDescriptor.add($42, 6, 1, "6x1.png")
TBlockDescriptor.add($43, 7, 1, "7x1.png")
TBlockDescriptor.add($44, 8, 1, "8x1.png")
TBlockDescriptor.add($45, 9, 1, "9x1.png")




Graphics(672, 480);
SetVirtualResolution(336, 240)

SetBlend(ALPHABLEND)

Global current:TBlockDescriptor = TBlockDescriptor(TBlockDescriptor.all.First())

Global effectAlphaSinus:Int = 0
  
repeat
	if AppTerminate() or ((KeyDown(KEY_LCONTROL) or KeyDown(KEY_RCONTROL)) And KeyDown(KEY_F4))
		doClose()
	End If
	
	if MouseZ() > 0 Or KeyHit(KEY_W)
		current = TBlockDescriptor.getNext(current);
		FlushMouse();
		
	Else if MouseZ() < 0 Or KeyHit(KEY_Q)
		current = TBlockDescriptor.getPrev(current);
		FlushMouse();
	End If
	
	if KeyHit(KEY_L)
		loadLevel()
	End If
	
	if KeyHit(KEY_S)
		saveLevel()
	End If
	
	if KeyHit(KEY_1) Then current = TBlockDescriptor.getId(0)
	if KeyHit(KEY_2) Then current = TBlockDescriptor.getId(1)
	if KeyHit(KEY_3) Then current = TBlockDescriptor.getId(6)
	if KeyHit(KEY_4) Then current = TBlockDescriptor.getId(11)
	if KeyHit(KEY_5) Then current = TBlockDescriptor.getId(16)
	
	' EFFECT STUFF
	
	effectAlphaSinus :+ 3
	
	TBlock.drawAll()
	
	Local mx:Byte = Max(0, Min(13, Floor(MouseX() / 48)))
	Local my:Byte = Max(0, Min(9, Floor(MouseY() / 48)))
	
	current.saneMousePosition(mx, my)
	
	if MouseDown(1)
		current.placeBlock(mx, my)
	End If
	
	if MouseDown(2)
		TBlock.removeAt(mx, my)
	End If
	
	SetAlpha(0.5 + Sin(effectAlphaSinus) * 0.15)
	current.draw(mx, my)
	SetAlpha(1)
	
	Flip
	Cls
Forever



Function loadLevel()
	Local file:String = RequestFile("Select level:")
	
	if FileSize(file) = -1
		Return
	EndIf
	
	TBlock.all.Clear()
	
	Local stream:TStream = ReadFile(file)
	stream.ReadByte()
	stream.ReadByte()
	stream.ReadByte()
	stream.ReadByte()
	For Local j:Byte = 0 until 10
		For Local i:Byte = 0 until 14
			TBlockDescriptor.loadBlock(stream.ReadByte(), i, j)
			stream.ReadByte()
			stream.ReadByte()
			stream.ReadByte()
		Next
	Next
	stream.Close()
	
	FlushKeys()
End Function

Function saveLevel()
	Local file:String = RequestFile("Select level:", "", true)
	
	Local stream:TStream = WriteFile(file)
	stream.WriteByte(3)
	stream.WriteByte(0)
	stream.WriteByte(0)
	stream.WriteByte(0)
	For Local j:Byte = 0 until 10
		For Local i:Byte = 0 until 14
			stream.WriteByte(TBlock.getSaveIdAt(i, j))
			stream.WriteByte(0)
			stream.WriteByte(0)
			stream.WriteByte(0)
		Next
	Next
	stream.Close()
	
	FlushKeys()
EndFunction

Function doClose()
	End
End Function

Type TBlock
	Field gfx:TImage
	Field x:Byte
	Field y:Byte
	Field width:Byte
	Field height:Byte
	Field savefileId:Byte
	
	Global all:TList = new TList
	
	Function drawAll()
		For Local i:TBlock = eachin TBlock.all
			i.draw()
		Next
	End Function
	
	Function getSaveIdAt:Int(x:Byte, y:Byte)
		For Local i:TBlock = eachin TBlock.all
			if i.x = x And i.y = y
				Return i.savefileId
			End If
		Next
		
		Return 0
	End Function
	
	Method draw()
		DrawImage(gfx, x * 24, y * 24)
	End Method
	
	Method addMe()
		For Local i:TBlock = eachin TBlock.all
			if i.x < x + width and i.x + i.width > x and i.y < y + height and i.y + i.height >y
				all.Remove(i)
			EndIf
		Next
		
		all.AddLast(self)
	End Method
	
	Function removeAt(x:Byte, y:Byte)
		For Local i:TBlock = eachin TBlock.all
			if i.x = x And i.y = y
				all.Remove(i)
				return
			EndIf
		Next
	End Function
EndType

Type TBlockDescriptor
	Field id:Byte
	Field savefileId:Byte
	Field width:Byte
	Field height:Byte
	Field gfx:TImage
	
	Method saneMousePosition(x:Byte Var, y:Byte var)
		While x + width  > 14
			x :- 1
		Wend 
		
		While y + height > 10 
			y :- 1
		Wend
	End Method
	
	Method draw(x:Byte, y:Byte)
		DrawImage(gfx, x * 24, y * 24)
	End Method
	
	Method placeBlock(x:Byte, y:Byte)
		Local block:TBlock = new TBlock
		block.x = x
		block.y = y
		block.width = width
		block.height = height
		block.savefileId = savefileId
		block.gfx = gfx
		block.addMe()
	End Method
	
	Global all:TList = new TList
	
	Function getId:TBlockDescriptor(id:Byte)
		For Local i:TBlockDescriptor = eachin all
			if i.id = id
				Return i
			End If
		Next
		
		Return TBlockDescriptor(all.First())
	End Function
	
	Function add(saveID:Byte, width:Byte, height:Byte, gfxName:String)
		Local instance:TBlockDescriptor = new TBlockDescriptor
		instance.id = all.Count()
		instance.savefileId = saveID
		instance.width = width
		instance.height = height
		instance.gfx = LoadImage("incbin::" + gfxName, MASKEDIMAGE);
		
		all.AddLast(instance)
	EndFunction
	
	Function getNext:TBlockDescriptor(current:TBlockDescriptor)
		if all.Last()  = current
			Return TBlockDescriptor(all.First())
		Else
			Return TBlockDescriptor(all.FindLink(current).NextLink().value())
		EndIf
	End Function
	
	Function getPrev:TBlockDescriptor(current:TBlockDescriptor)
		if all.First() = current
			Return TBlockDescriptor(all.Last())
		Else
			Return TBlockDescriptor(all.FindLink(current).PrevLink().value())
		EndIf
	End Function
	
	Function loadBlock(id:Byte, x:Byte, y:Byte)
		id = sanitizeBlock(id)
		if id = 0
			return
		End If
		For Local i:TBlockDescriptor = eachin all
			if i.savefileId = id
				i.placeBlock(x, y)
				return
			End If
		Next
	End Function
	
	Function sanitizeBlock:Byte(id:Byte)
		Select(id)
			Case 53
				Return $36
			Case 62
				Return $33
			Case 63
				Return $37
			Case 72
				Return $34
			Case 73
				return $38
		EndSelect
		
		Return id
	End Function
EndType