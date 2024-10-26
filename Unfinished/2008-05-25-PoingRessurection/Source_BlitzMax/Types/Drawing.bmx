'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
 bbdoc:Undocumented type
End Rem
Type Drawing
	Function Bricks()
		For Local i:TBrick=EachIn CurrentRoom.Room
			i.Draw()
		Next
	EndFunction
	Function Screen()
		SetOrigin(0,0)
		DrawImage(GFX_GAMENU,0,0)
	EndFunction
	Function Image(img:TImage,x:Int,y:Int,frm:Short=0)
		SetOrigin(25,94)
		DrawImage(img,x,y,frm)
	EndFunction
	Function Rect(x:Int,y:Int,wid:Int,hei:Int)
		SetOrigin(25,94)
		DrawRect(x,y,wid,hei)
	EndFunction
	Function Circle(x:Int,y:Int,rad:Byte)
		SetOrigin(25,94)
		DrawOval(x-rad,y-rad,rad*2,rad*2)
	EndFunction
	Function Line(x:Int,y:Int,x2:Int,y2:Int)
		SetOrigin(25,94)
		DrawLine(x,y,x2,y2)
	EndFunction
End Type