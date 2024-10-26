
Type TMarker
	Field x:Int
	Field y:Int
	Field time:Long
	Method Update()
		Drawing.ShapeOval(x-2,y-2,5,5)
		time:-1
		If time<0
			Lists.Markers.Remove(Self)
		EndIf
	EndMethod
EndType

Function Mark(x:Int,y:Int,time:Long)
	Local m:TMarker=New TMarker
	m.x=x
	m.y=y
	m.time=time*60
	Lists.Markers.AddLast(m)
EndFunction