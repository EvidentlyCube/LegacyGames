
SuperStrict

Graphics 1200,375

Global wid:Int=500
Global hei:Int=15
Global level:Int[wid,hei]

For Local i:Short=0 Until wid
	For Local j:Short=0 Until hei
		Level[i,j]=-1
	Next
Next

If FileSize("./level.lev")>-1
	Local file:TStream=ReadStream("./level.lev")
	wid=ReadShort(file)
	hei=ReadShort(file)
	level=New Int[wid,hei]
	For Local i:Short=0 Until wid
		For Local j:Short=0 Until hei
			Level[i,j]=-1
		Next
	Next
	For Local i:Short=0 Until wid
		For Local j:Short=0 Until hei
			level[i,j]=ReadByte(file)
			If level[i,j]=222 Then level[i,j]=-1
		Next
	Next
	While Not file.Eof()
		Local lo:Stuff=New Stuff
		lo.posX=file.ReadShort()
		lo.posY=file.ReadShort()
		lo.gfx=file.ReadShort()
		Stuff.stuffs.addLast(lo)
	Wend
	CloseStream(file)
EndIf


Global gfx1:TImage=LoadAnimImage("./Pack.png",25,25,0,62)
Global gfx2:TImage[70]
For Local i:Byte=0 Until 70
	gfx2[i]=LoadImage("./gfx/"+i+".png")
Next
Global push:Int[70,2]
setstuff()

Global blocksString:String="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

Global pos:Short=0

Global mode:Byte=0
Global moder:Byte=0
Global obj:Byte=0

Global mX:Byte
Global mY:Byte

SetBlend(ALPHABLEND)

While Not KeyDown(KEY_ESCAPE)
	mX=Floor(MouseX()/25)
	mY=Min(hei-1,Floor(MouseY()/25))
	
	If KeyHit(KEY_1)
		If mode=1
			obj=Min(61,mX+mY*6)
			mode=0
			moder=0
		Else
			mode=1
		EndIf
	EndIf
	If KeyHit(KEY_2)
		If mode=2
			Local miX:Int=Floor(MouseX()/50)
			Local miY:Int=Floor(MouseY()/50)
			obj=Min(69,miX+miY*15)
			mode=0
			moder=1
		Else
			mode=2
		EndIf
	EndIf
	
	If mode=0
		Stuff.Draw()
		For Local i:Short=0 Until 48
			For Local j:Byte=0 Until 15
				If level[pos+i,j]>=0
					DrawImage(gfx1,i*25,j*25,level[pos+i,j])
				EndIf
			Next
		Next
		SetAlpha(0.5)
		If moder=0
			DrawImage(gfx1,mX*25,mY*25,obj)
		ElseIf moder=1
			DrawImage(gfx2[obj],mX*25-push[obj,0],mY*25-push[obj,1])
		EndIf
		SetAlpha(1)

	ElseIf mode=1
		For Local i:Byte=0 Until 62
			DrawImage(gfx1,(i Mod 6)*25,Floor(i/6)*25,i)
		Next
	ElseIf mode=2
		For Local i:Byte=0 Until 70
			DrawImageRect(gfx2[i],(i Mod 15)*50,Floor(i/15)*50,48,48)
		Next
	EndIf
	If KeyDown(KEY_RIGHT) And pos<wid-49
		pos:+1
	EndIf
	If KeyDown(KEY_LEFT) And pos>0
		pos:-1
	EndIf
	If MouseDown(1)
		If moder=0
			level[pos+mX,mY]=obj
		ElseIf moder=1
			toStuff()
		EndIf
	ElseIf MouseDown(2)
		If moder=0
			level[pos+mX,mY]=-1
		ElseIf moder=1 And (MouseHit(2) Or KeyDown(KEY_SPACE))
			Stuff.Del()
		EndIf
	EndIf
	If KeyHit(KEY_F11)
		export()
	EndIf
	Flip
	Cls
Wend

If FileSize("./level.lev")>-1
	DeleteFile("./level.lev")
EndIf

Local file:TStream=WriteStream("./level.lev")
If Not file Then RuntimeError("cacza")
WriteShort(file,wid)
WriteShort(file,hei)
For Local i:Short=0 Until wid
	For Local j:Short=0 Until hei
		If level[i,j]=-1
			WriteByte(file,222)
		Else
			WriteByte(file,level[i,j])
		EndIf
	Next
Next
For Local i:stuff=EachIn Stuff.stuffs	
	file.WriteShort(i.posX)
	file.WriteShort(i.posY)
	file.WriteShort(i.gfx)
Next
CloseStream(file)




Type Stuff
	Field posX:Short
	Field posY:Short
	Field gfx:Short
	Global stuffs:TList=CreateList()
	Function Draw()
		For Local i:Stuff=EachIn Stuff.stuffs
			DrawImage(gfx2[i.gfx],(i.posX-pos)*25-push[i.gfx,0] ,i.posY*25-push[i.gfx,1])
		Next
	EndFunction
	Function Del()
		Local j:TLink=stuffs.lastlink()
		While True
			If j=Null Then Return
			Local i:Stuff=Stuff(j.value())
			If MouseX()+pos*25>i.posX*25-push[i.gfx,0] And MouseX()+pos*25<i.posX*25+gfx2[i.gfx].width And MouseY()>i.posY*25-push[i.gfx,1] And MouseY()<i.posY*25+gfx2[i.gfx].height
				stuffs.remove(i)
				Return
			EndIf
			j=j.PrevLink()
		Wend
	EndFunction
	Function check:Byte(x:Short,y:Short,typ:Short)
		For Local i:Stuff=EachIn stuff.stuffs
			If i.posX=x And i.posY=y And i.gfx=typ Then Return 1
		Next
		Return 0
	EndFunction
	Method exportus:String()
		Select (gfx)
			Case (0) Return "Mario.instObjects.push(new Cannon("+posX*25+","+posY*25+"))"
			Case (1)  Return "Mario.instEnemies.push(new Goomba("+posX*25+","+posY*25+"))"
			Case (2)  Return "Mario.instEnemies.push(new TroopaGreen("+posX*25+","+posY*25+"))"
			Case (3)  Return "Mario.instEnemies.push(new TroopaRed("+posX*25+","+posY*25+"))"
			Case (4)  Return "Mario.instEnemies.push(new PPlant("+posX*25+","+posY*25+"))"
			Case (5)  Return "Mario.instEnemies.push(new PPlant("+posX*25+","+posY*25+",-1))"
			Case (6)  Return "Mario.instEnemies.push(new Spiny("+posX*25+","+posY*25+"))"
			Case (7)  Return "Mario.instEnemies.push(new BBeetle("+posX*25+","+posY*25+"))"
			Case (8)  Return "Mario.instEnemies.push(new Lakitu("+posX*25+","+posY*25+"))"
			Case (9)  Return "Mario.instEnemies.push(new FlyGreen("+posX*25+","+posY*25+"))"
			Case (10)  Return "Mario.instEnemies.push(new FlyRed("+posX*25+","+posY*25+"))"
			Case (11) Return "Mario.instEnemies.push(new JumperThrower("+posX*25+","+posY*25+"))"
			Case (12) Return "Mario.instEnemies.push(new HammerTroopa("+posX*25+","+posY*25+"))"
			Case (13) Return "Mario.instEnemies.push(new HammerTroopa("+posX*25+","+posY*25+",true))"
			Case (14) Return "Mario.instEnemies.push(new PStatic("+posX*25+","+posY*25+"))"
			Case (15) Return "Mario.instEnemies.push(new PFlame("+posX*25+","+posY*25+"))"
			Case (16) Return "Mario.instEnemies.push(new PFlame("+posX*25+","+posY*25+",-1))"
			Case (17) Return "Mario.instObjects.push(new Lava("+posX*25+","+posY*25+"))"
			Case (18) Return "Mario.instObjects.push(new Mill("+posX*25+","+posY*25+"))"
			Case (19) Return "Player.ResetPlayer("+posX*25+","+posY*25+")"
			Case (20) Return "Mario.instObjects.push(new Finish("+posX*25+","+posY*25+"))"
			Case (21) Return "Mario.instObjects.push(new Elevator("+posX*25+","+posY*25+",100,'elevator_4'))"
			Case (22) Return "Mario.instObjects.push(new Elevator("+posX*25+","+posY*25+",75,'elevator_3'))"
			Case (23) Return "Mario.instObjects.push(new Elevator("+posX*25+","+posY*25+",50,'elevator_2'))"
			Case (24) Return "Mario.instObjects.push(new Elevator("+posX*25+","+posY*25+",25,'elevator_1'))"
			Case (25) Return "Mario.instBlocks.push(new Brick("+posX*25+","+posY*25+"))"
			Case (26) Return "Mario.instBlocks.push(new BrickMulti("+posX*25+","+posY*25+"))"
			Case (27) Return "Mario.instBlocks.push(new Bonus("+posX*25+","+posY*25+",0))"
			Case (28) Return "Mario.instBlocks.push(new Bonus("+posX*25+","+posY*25+",1))"
			Case (29) Return "Mario.instBlocks.push(new Bonus("+posX*25+","+posY*25+",2))"
			Case (30) Return "Mario.instBlocks.push(new Bonus("+posX*25+","+posY*25+",3))"
			Case (31) Return "Mario.instBlocks.push(new Bonus("+posX*25+","+posY*25+",4))"
			Case (32) Return "Mario.instBlocks.push(new Bonus("+posX*25+","+posY*25+",5))"
			Case (33) Return "Mario.instBlocks.push(new Bonus("+posX*25+","+posY*25+",1,true))"
			Case (34) Return "Mario.instBlocks.push(new Bonus("+posX*25+","+posY*25+",2,true))"
			Case (35) Return "Mario.instBlocks.push(new Bonus("+posX*25+","+posY*25+",3,true))"
			Case (36) Return "Mario.instBlocks.push(new Bonus("+posX*25+","+posY*25+",4,true))"
			Case (37) Return "Mario.instBlocks.push(new Bonus("+posX*25+","+posY*25+",5,true))"
			Case (38) Return "Mario.instObjects.push(new Coin("+posX*25+","+posY*25+"))"
			Case (39) Return "Mario.layerWall.addChild(AddGraphic("+posX*25+","+posY*25+",'back_fence_1'))"
			Case (40) Return "Mario.layerWall.addChild(AddGraphic("+posX*25+","+posY*25+",'back_fence_2'))"
			Case (41) Return "Mario.layerWall.addChild(AddGraphic("+posX*25+","+posY*25+",'back_fence_3'))"
			Case (42) Return "Mario.instEffects.push(new Grass("+posX*25+","+posY*25+",'l'))"
			Case (43) Return "Mario.instEffects.push(new Grass("+posX*25+","+posY*25+",'m'))"
			Case (44) Return "Mario.instEffects.push(new Grass("+posX*25+","+posY*25+",'r'))"
			Case (45) Return "Mario.layerWall.addChild(AddGraphic("+posX*25+","+posY*25+",'back_tree_1'))"
			Case (46) Return "Mario.layerWall.addChild(AddGraphic("+posX*25+","+posY*25+",'back_tree_2'))"
			Case (47) Return "Mario.layerWall.addChild(AddGraphic("+posX*25+","+posY*25+",'back_tree_3'))"
			Case (48) Return "Mario.layerWall.addChild(AddGraphic("+posX*25+","+posY*25+",'back_tree_4'))"
			Case (49) Return "Mario.layerWall.addChild(AddGraphic("+posX*25+","+posY*25+",'back_tree_5'))"
			Case (50) Return "Mario.instEffects.push(new Cloud("+posX*25+","+posY*25+"))"
			Case (51) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_clouds_1',"+ran(0.05)+"))"
			Case (52) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_clouds_2',"+ran(0.05)+"))"
			Case (53) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_clouds_3',"+ran(0.05)+"))"
			Case (54) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_clouds_4',"+ran(0.4)+"))"
			Case (55) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_clouds_5',"+ran(0.4)+"))"
			Case (56) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_clouds_6',"+ran(0.4)+"))"
			Case (57) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_clouds_7',"+ran(0.4)+"))"
			Case (58) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_clouds_8',"+ran(0.6)+"))"
			Case (59) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_column_1',"+ran(0.6)+"))"
			Case (60) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_column_2',"+ran(0.3)+"))"
			Case (61) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_column_3',"+ran(0.3)+"))"
			Case (62) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_column_4',"+ran(0.6)+"))"
			Case (63) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_forest_1',"+ran(0.2)+"))"
			Case (64) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_forest_2',"+ran(0.1)+"))"
			Case (65) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_forest_3',"+ran(0)+"))"
			Case (66) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_forest_4',"+ran(0.65)+"))"
			Case (67) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_hill',"+ran(0.3)+"))"
			Case (68) Return "Mario.instEffects.push(new Background("+posX*25+","+posY*25+",'back_hill_big',"+ran(0.55)+"))"
			Case (69) Return "Mario.instEffects.push(new Lantern("+posX*25+","+posY*25+"))"
		EndSelect
	EndMethod
EndType

Function toStuff()
	If Stuff.check(mx+pos,my,obj) Then Return
	Local lo:Stuff=New Stuff
	lo.posX=mX+pos
	lo.posY=mY
	lo.gfx=obj
	Print "czacza"
	If obj>37 Then Stuff.Stuffs.addFirst(lo) Else Stuff.Stuffs.addLast(lo)
	
EndFunction

Function setStuff()
	push[2,1]=12
	push[3,1]=12
	push[4,0]=-12
	push[4,1]=12
	push[5,0]=-12
	push[7,1]=2
	push[8,1]=13
	push[9,1]=10
	push[10,1]=11
	push[12,0]=1
	push[12,1]=13
	push[13,0]=1
	push[13,1]=13
	push[15,0]=-12
	push[15,1]=12
	push[16,0]=-12
	push[17,1]=2
	push[19,1]=23
EndFunction

Function export()
	If FileSize("./level.txt")>-1
		DeleteFile("./level.txt")
	EndIf
	Local file:TStream=WriteStream("./level.txt")
	Local lene:Short=mX+pos
	For Local i:Byte=0 Until hei
		Local txt:String="Mario.level["+i+"]="+Chr(34)
		For Local j:Short=0 Until lene
			If level[j,i]=-1
				txt:+" "
			Else
				Local char:Byte=level[j,i]
				txt:+blocksString[char..char+1]
				Print blocksString[char..char+1]
			EndIf
		Next
		txt:+Chr(34)+";"
		file.WriteLine(txt)
	Next
	file.WriteLine("Mario.levelWid=Mario.level[0].length;");
	file.WriteLine("Mario.levelHei=Mario.level.length;");
	file.WriteLine("Mario.drawLevel();");
	file.WriteLine("Mario.Hud.Time=320;");
	For Local i:Stuff=EachIn Stuff.stuffs
		file.WriteLine(i.exportus())
	Next
	CloseStream(file)
EndFunction

Function ran:Float(gu:Float)
	Local cza:Float=RndFloat()/3*100
	cza=Floor(cza)
	cza=cza/100
	cza:+gu
	Return cza
EndFunction