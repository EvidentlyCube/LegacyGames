
SuperStrict

Framework brl.max2d
Import brl.Graphics
Import brl.random
import brl.glmax2d
Import brl.pngloader

Global g:TImage=LoadAnimImage("E:\Stuff\Projects\Workon\BlitzMax\SImple PLatformer\Data\blocks.png",25,25,0,50)

Graphics (800,800)

Type kupa
	Field x:Int,y:Int
	Field gfx:Int
	Method Draw()
		DrawImage(g,x,y,gfx)
	End Method
EndType
Local fufu:TList=New TList

Local Level:Int[20,20]
For Local i:Byte=0 Until 20
	For Local j:Byte=0 Until 20
		Local kiko:kupa=New kupa
		kiko.x=i*25
		kiko.y=j*25
		kiko.gfx=Rand(0,49)
		fufu.AddLast(kiko)
	Next	
Next

Local dozo:Long=MilliSecs()
Local koopa:Double[32]
Local kiipa:Double[32]
While Not KeyDown(KEY_ESCAPE)
	Local fifo:Byte=Floor(MouseX()/25)
	dozo=MilliSecs()
	For Local pipa:Byte=0 Until fifo
		For Local i:kupa= EachIn fufu
			i.Draw()
		Next
	Next
	If kiipa[fifo]<500
		koopa[fifo]:+MilliSecs()-dozo
		kiipa[fifo]:+1
	EndIf
	DrawText("Drejwuf:"+fifo*400,100,680)
	DrawText("Milisekund per Drejf:"+koopa[fifo]/kiipa[fifo],100,700)
	Flip
	cls
Wend