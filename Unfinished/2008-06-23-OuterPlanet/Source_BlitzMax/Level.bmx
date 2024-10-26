
Type TLevel
	Field Level:TBlock[,,]
	Field Width:Byte
	Field Height:Byte
	Field Gravity:Float=0.4
	Field MAXFALL:Byte=10
	Field TopLeftX:Int
	Field TopLeftY:Int
	
	Method ResetCanvas()
		TopLeftX=Max(0,Min(Width*25-1024,Player.x-507))
		TopLeftY=Max(0,Min(Height*25-768,Player.y-374))
	EndMethod
	Method MakeEmptyLevel(Wid:Byte,Hei:Byte)
		Width=Wid
		Height=Hei
		Level=New TBlock[Width,Height,2]
	EndMethod
	Method LevelFromFile(Link:String)
		Local Stream:TStream=ReadStream(Link)
		Local ver:Byte=ReadByte(Stream)
		If ver<>VERSION Then Notify("The level you tried to load has different version number than expected. Terminate"); End
		Width=ReadByte(Stream)
		Height=ReadByte(Stream)
		MakeEmptyLevel(Width,Height)
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
					If Block.shape=7
						TConveyor.MakeNew(x*25,y*25,-1)
					ElseIf Block.shape=8
						TConveyor.MakeNew(x*25,y*25,1)
					EndIf
				Case 1
					Block=New TBlock
					x=ReadByte(Stream)
					y=ReadByte(Stream)
					Block.gfx=ReadShort(Stream)
					Level[x,y,1]=Block
			EndSelect
		Wend
		CloseStream(Stream)
	EndMethod
	Method LevelFrom2DArray(levGraphic:Byte[,,],levCollision:Byte[,])
		Width=levCollision.dimensions()[0]
		Height=levCollision.dimensions()[1]
		Level=new TBlock[Width,height,2]
		For Local i:Byte=0 Until Width
			For Local j:Byte=0 Until Height
				If levGraphic[i,j,0]
					Level[i,j,0]=New TBlock
					Level[i,j,0].gfx=levGraphic[i,j,0]
					Level[i,j,0].shape=levCollision[i,j]
				Else 
					Level[i,j,0]=Null
				EndIf
				If levGraphic[i,j,1]
					Level[i,j,1]=New TBlock
					Level[i,j,1].gfx=levGraphic[i,j,1]
				Else 
					Level[i,j,1]=Null
				EndIf
			Next
		Next
	EndMethod
	Method SetTile(x:Short,y:Short,layer:Byte=0,gfx:Int=0,shape:Byte=0)
		If gfx>=0
			Level[x,y,layer]=New TBlock
			Level[x,y,layer].gfx=gfx
			Level[x,y,layer].shape=shape
		Else
			Level[x,y,layer]=Null
		EndIf
	EndMethod
	Method DrawLevel()	
		Local ModX:Short=TopLeftX Mod 25
		Local ModY:Short=TopLeftY Mod 25
		Local LeftX:Int=Max(0,Floor(TopLeftX/25))
		Local LeftY:Int=Max(0,Floor(TopLeftY/25))
		For Local i:Short=LeftX To Min(LeftX+41,Width-1)
			For Local j:Short=LeftY To Min(LeftY+31,Height-1)
				If Level[i,j,1]
					SetAlpha(0.3)
					DrawImage(GFX_Blocks,(i-LeftX)*25-ModX,(j-LeftY)*25-ModY,Level[i,j,1].gfx)
					SetAlpha(1)
				EndIf
				If Level[i,j,0]
					DrawImage(GFX_Blocks,(i-LeftX)*25-ModX,(j-LeftY)*25-ModY,Level[i,j,0].gfx)
				EndIf
			Next
		Next
	EndMethod
	Method DrawLevelBottom()	
		Local ModX:Short=TopLeftX Mod 25
		Local ModY:Short=TopLeftY Mod 25
		Local LeftX:Int=Max(0,Floor(TopLeftX/25))
		Local LeftY:Int=Max(0,Floor(TopLeftY/25))
		For Local i:Short=LeftX To Min(LeftX+41,Width-1)
			For Local j:Short=LeftY To Min(LeftY+31,Height-1)
				If Level[i,j,1]
					SetAlpha(0.3)
					DrawImage(GFX_Blocks,(i-LeftX)*25-ModX,(j-LeftY)*25-ModY,Level[i,j,1].gfx)
					SetAlpha(1)
				EndIf
			Next
		Next
	EndMethod
	Method DrawLevelUpper()	
		Local ModX:Short=TopLeftX Mod 25
		Local ModY:Short=TopLeftY Mod 25
		Local LeftX:Int=Max(0,Floor(TopLeftX/25))
		Local LeftY:Int=Max(0,Floor(TopLeftY/25))
		For Local i:Short=LeftX To Min(LeftX+41,Width-1)
			For Local j:Short=LeftY To Min(LeftY+31,Height-1)
				If Level[i,j,0]
					DrawImage(GFX_Blocks,(i-LeftX)*25-ModX,(j-LeftY)*25-ModY,Level[i,j,0].gfx)
				EndIf
			Next
		Next
	EndMethod
	Method CheckCollision:Int(X:Int,Y:Int)
		X=Floor(Float(X)/25)
		Y=Floor(Float(Y)/25)
		If X<0 Or Y<0 Or X>=Width Or Y>=Height Then Return 1
		If Level[X,Y,0]
			Return Level[X,Y,0].shape
		Else 
			Return 0 
		EndIf
	End Method
	Method PreciseCollision:Byte(X:Int,Y:Int) 'Return True if Precise Collision happens
		Local ModX:Byte=X Mod 25
		Local ModY:Byte=Y Mod 25
		X=Floor(Float(X)/25)
		Y=Floor(Float(Y)/25)
		If X<0 Or Y<0 Or X>=Width Or Y>=Height Then Return 1
		If Level[X,Y,0]
			Select Level[X,Y,0].shape
				Case 0 Return 0
				Case 1 Return 0
				Case 2 Return 1
				Case 3 Return 1
				Case 4 Return 1
				Case 5 Return 1
				Case 6 Return 1
				Case 7 Return 1
				Case 8 Return 1
				Case 9 Return 0
				Case 10 Return 0
				Case 11 Return 0
				Case 12 Return 0
				Case 13 If modY<25-modX Then Return 1 Else Return 0
				Case 14 If modY<modX Then Return 1 Else Return 0
				Case 15 If modY>25-modX Then Return 1 Else Return 0
				Case 16 If modY>modX Then Return 1 Else Return 0
			End Select
		Else 
			Return 0 
		EndIf
	End Method
	Method PreciseCollision2:Byte(X:Int,Y:Int) 'Return True if Precise Collision happens
		Local ModX:Byte=X Mod 25
		Local ModY:Byte=Y Mod 25
		X=Floor(Float(X)/25)
		Y=Floor(Float(Y)/25)
		If X<0 Or Y<0 Or X>=Width Or Y>=Height Then Return 2
		If Level[X,Y,0]
			Select Level[X,Y,0].shape
				Case 0 Return 0
				Case 1 Return 1
				Case 2 Return 2
				Case 3 Return 3
				Case 4 Return 4
				Case 5 Return 5
				Case 6 Return 6
				Case 7 Return 7
				Case 8 Return 8
				Case 9 Return 9
				Case 10 Return 10
				Case 11 Return 11
				Case 12 Return 12
				Case 13 If modY<25-modX Then Return 13 Else Return 0
				Case 14 If modY<modX Then Return 14 Else Return 0
				Case 15 If modY>25-modX Then Return 15 Else Return 0
				Case 16 If modY>modX Then Return 16 Else Return 0
			End Select
		Else 
			Return 0 
		EndIf
	End Method
	Method SpikeCollision:Byte(X:Int,Y:Int, dir:Byte)
		Local ModX:Byte=X Mod 25
		Local ModY:Byte=Y Mod 25
		X=Floor(Float(X)/25)
		Y=Floor(Float(Y)/25)
		If X<0 Or Y<0 Or X>=Width Or Y>=Height Then Return 0
		If Level[X,Y,0]
			Select Level[X,Y,0].shape
				Case 0 Return 1
				Case 1 Return 1
				Case 3 If dir=2 Then Return 1
				Case 4 If dir=3 Then Return 1
				Case 5 If dir=0 Then Return 1
				Case 6 If dir=1 Then Return 1
				Case 9 If dir=1 Then Return 1
				Case 10 If dir=2 Then Return 1
				Case 11 If dir=3 Then Return 1
				Case 12 If dir=0 Then Return 1
				Case 13 Return 1
				Case 14 Return 1
				Case 15 Return 1
				Case 16 Return 1
			End Select
			Return 0
		Else 
			Return 1
		EndIf
	EndMethod
	Method VectorCollision:Float[](beginX:Float,beginY:Float,endX:Float,endY:Float,wallX:Int,wallY:Int)
		If wallX<0 Or wallY<0 Or wallX>=Width Or wallY>=Height 
			Local inter:Float[]=GeoLineVSRect(endX,endY,beginX,beginY,0,0,width*25,width*25)
			If Not inter[0] Then Return [1.0,endX,endY]
			Return inter
		EndIf
		If Level[wallX,wallY,0]
			Select Level[wallX,wallY,0].shape
				Case 0 Return [0.0]
				Case 1 Return [0.0]
				Case 2 Return GeoLineVSRect(beginX,beginY,endX,endY,wallX*25,wallY*25,25,25)
				Case 3 Return GeoLineVSRect(beginX,beginY,endX,endY,wallX*25,wallY*25,25,25)
				Case 4 Return GeoLineVSRect(beginX,beginY,endX,endY,wallX*25,wallY*25,25,25)
				Case 5 Return GeoLineVSRect(beginX,beginY,endX,endY,wallX*25,wallY*25,25,25)
				Case 6 Return GeoLineVSRect(beginX,beginY,endX,endY,wallX*25,wallY*25,25,25)
				Case 7 Return GeoLineVSRect(beginX,beginY,endX,endY,wallX*25,wallY*25,25,25)
				Case 8 Return GeoLineVSRect(beginX,beginY,endX,endY,wallX*25,wallY*25,25,25)
				Case 9 Return [0.0]
				Case 10 Return [0.0]
				Case 11 Return [0.0]
				Case 12 Return [0.0]
				Case 13,15 Return GeoLineVSLine(beginX,beginY,endX,endY,wallX*25+25,wallY*25,wallX*25,wallY*25+25)
				Case 14,16 Return GeoLineVSLine(beginX,beginY,endX,endY,wallX*25,wallY*25,wallX*25+25,wallY*25+25)
			End Select
		EndIf
		Return [0.0] 
	EndMethod
	Method OrthogonalCast:Float[](x:Float,y:Float,ix:Float,iy:Float)
		Local inter:Float[]
		Local bX:Float=x
		Local bY:Float=y
		If ix<>0
			While True
				bx:+ix
				inter=VectorCollision(x,y,bx,by,Floor(bx/25),Floor(by/25))
				If inter[0] Then Return [inter[1],inter[2]]
				inter=VectorCollision(x,y,bx,by,Floor(bx/25)-Sgn(ix),Floor(by/25))
				If inter[0] Then Return [inter[1],inter[2]]
			Wend
		Else
			While True
				by:+iy
				inter=VectorCollision(x,y,bx,by,Floor(bx/25),Floor(by/25))
				If inter[0] Then Return [inter[1],inter[2]]
				inter=VectorCollision(x,y,bx,by,Floor(bx/25),Floor(by/25)-Sgn(iy))
				If inter[0] Then Return [inter[1],inter[2]]
			Wend
		EndIf
	EndMethod
	Method RayCast:Float[](x:Float, y:Float, ix:Float, iy:Float) 
		Local angle:Float=ATan2(iy,ix)
		Local inter:Float[]
		If angle Mod 90=0
			Return OrthogonalCast(x,y,Sgn(ix)*25,Sgn(iy)*25)
		Else
			Local aY:Float=0.0
			If iy>0
				aY=Floor(y/25)*25+25
			Else
				aY=Floor(y/25)*25-1
			EndIf
			Local aX:Float=x-(y-aY)/Tan(angle)
			Local Ya:Float=iY*25
			Local Xa:Float=25/Tan(angle)*iy
			inter=VectorCollision(X,Y,aX,aY,Floor(X/25),Floor(Y/25))
			If Not inter[0]
				While True
					DrawOval(ax-2,ay-2,4,4)
					inter=VectorCollision(X,Y,aX+Xa,aY+Ya,Floor(aX/25),Floor(aY/25))
					If inter[0]
						Exit 
					EndIf
					aX:+Xa
					aY:+Ya
				Wend
			EndIf
			Local tY:Float[]=[inter[1],inter[2]]
			
			aX=0.0
			If ix>0
				aX=Floor(x/25)*25+25
			Else
				aX=Floor(x/25)*25-1
			EndIf
			aY=y-(x-aX)*Tan(angle)
			Xa=ix*25
			Ya=25*Tan(angle)*ix
			inter=VectorCollision(X,Y,aX,aY,Floor(X/25),Floor(Y/25))
			If Not inter[0]
				While True
					inter=VectorCollision(X,Y,aX+Xa,aY+Ya,Floor(aX/25),Floor(aY/25))
					If inter[0] Then Exit
					aX:+Xa
					aY:+Ya
				Wend
			EndIf
			Local tX:Float[]=[inter[1],inter[2]]
			If Dist2(x,y,tX[0],tX[1])>Dist2(x,y,tY[0],tY[1])
				Return tY
			Else
				return tX
			EndIf 
		EndIf
	EndMethod
EndType

Type TBlock
	Field gfx:Short
	Field shape:Byte=0
	Method Set(gfx:Short,shape:Byte)
		Self.gfx=gfx
		Self.shape=shape
	EndMethod
EndType

Global Level:TLevel=New TLevel
If True
	Local filename:String=RequestFile("Select Level to Load","Outer Planet Level:oplvl",False,CurrentDir()+"/Levels/")
	If FileSize(filename)=-1 Then Notify("The level you have selected to load doesn't exist. Terminate");End
	If filename=-1 Then Notify("The level you have selected to load doesn't exist. Terminate");End
	Level.LevelFromFile(filename)
EndIf