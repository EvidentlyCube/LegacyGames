'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type Geometry
	Function Distance:Float(x1:Int, y1:Int, x2:Int, y2:Int)
		Return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
	End Function
End Type
