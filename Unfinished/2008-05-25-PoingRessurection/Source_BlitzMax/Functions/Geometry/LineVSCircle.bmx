'This BMX file was edited with BLIde ( http://www.blide.org )

Function GeoLineVSCircle:Float[](x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, rad:Float) 
	'x1,y1,x2,y2,x3,y3,rad,retur
	'x1,y1 - Starting point of line
	'x2,y2 - Ending point of first line
	'x3,y3 - Position of Circle's center
	'rad   - Radius of the circle
	Local a:Double=(x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)
	Local b:Double=2*((x2-x1)*(x1-x3)+(y2-y1)*(y1-y3))
	Local c:Double=x3*x3+y3*y3+x1*x1+y1*y1-2*(x3*x1+y3*y1)-rad*rad
	Local delta:Float=b*b-4*a*c
	If delta>=0
		Local u1:Float=0.0
		u1=(-b-Sqr(delta))/(2*a)
		If u1>=0 And u1<=1
			Return [1.0,x1+u1*(x2-x1),y1+u1*(y2-y1)]
		EndIf
	EndIf
	Return [0.0]
EndFunction