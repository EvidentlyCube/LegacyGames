'This BMX file was edited with BLIde ( http://www.blide.org )

Global Colors:Byte[64,8,3]
For Local i:Byte=0 To 63
	Colors[i,0,0]=255
	Colors[i,0,1]=255
	Colors[i,0,2]=255
	Colors[i,1,0]=255
	Colors[i,1,1]=0
	Colors[i,1,2]=0
	Colors[i,2,0]=0
	Colors[i,2,1]=255
	Colors[i,2,2]=0
	Colors[i,3,0]=0
	Colors[i,3,1]=128
	Colors[i,3,2]=255
	Colors[i,4,0]=255
	Colors[i,4,1]=255
	Colors[i,4,2]=0
	Colors[i,5,0]=255
	Colors[i,5,1]=0
	Colors[i,5,2]=255
	Colors[i,6,0]=0
	Colors[i,6,1]=255
	Colors[i,6,2]=255
	Colors[i,7,0]=200
	Colors[i,7,1]=200
	Colors[i,7,2]=200
Next
Global ColorScore:Byte[64,8,2]
For Local i:Byte=0 To 63
	ColorScore[i,0,0]=0
	ColorScore[i,0,1]=0
	ColorScore[i,1,0]=0
	ColorScore[i,1,1]=0
	ColorScore[i,2,0]=0
	ColorScore[i,2,1]=0
	ColorScore[i,3,0]=0
	ColorScore[i,3,1]=0
	ColorScore[i,4,0]=0
	ColorScore[i,4,1]=0
	ColorScore[i,5,0]=0
	ColorScore[i,5,1]=0
	ColorScore[i,6,0]=0
	ColorScore[i,6,1]=0
	ColorScore[i,7,0]=0
	ColorScore[i,7,1]=0
Next
Global GroupBonus:Short[64,16]
For Local i:Byte=0 To 63
	GroupBonus[i,0]=0
	GroupBonus[i,1]=0
	GroupBonus[i,2]=0
	GroupBonus[i,3]=0
	GroupBonus[i,4]=0
	GroupBonus[i,5]=0
	GroupBonus[i,6]=0
	GroupBonus[i,7]=0
	GroupBonus[i,8]=0
	GroupBonus[i,9]=0
	GroupBonus[i,10]=0
	GroupBonus[i,11]=0
	GroupBonus[i,12]=0
	GroupBonus[i,13]=0
	GroupBonus[i,14]=0
	GroupBonus[i,15]=0
Next

For Local i:Byte=0 To 63
	TBlock.Bricks[i]=New TList
Next

Global CRoom:Int=0
Global D_Groups:Byte=1
Global D_CurGroup:Byte=1
Global D_Sides:Byte=1
Global D_Chars:Byte=1
Global D_Grid:Byte=1
Global D_Changes:Byte=0

Global Name:String=""
Global Desc:String=""

Global Edit:Byte=0
'0-Block
'1-TopLeftChara
'2-Group

Global OriginX:Int=14
Global OriginY:Int=150
Global mHit1:Byte
Global mHit2:Byte

Global Selected:Int=0
Global SelBlock:TBlock
Global Colored:Byte=0
Global CAN:Byte=1
Global Grav_Dir:Short=0
Global Grav_Pow:Byte=0


Global GFX_HUD:TImage=LoadImage("./Data/editormenu.png")
Global GFX_BRICK:TImage=LoadImage("./Data/colorbrick.png")
Global GFX_BLOCKS:TImage=LoadAnimImage("./Data/bricks1.png",25,35,0,55)
Global GFX_BLOCKS_LAY:TImage=LoadAnimImage("./Data/bricks2.png",25,35,0,55)
Global GFX_CHARS:TImage=LoadAnimImage("./Data/chars.png",25,35,0,7)
Global GFX_LAYER:TImage=LoadAnimImage("./Data/layer.png",25,35,0,2)
Global GFX_CROSS:TImage=LoadImage("./Data/cross.png")
Global GFX_FIELD:TImage=LoadImage("./Data/field.png")