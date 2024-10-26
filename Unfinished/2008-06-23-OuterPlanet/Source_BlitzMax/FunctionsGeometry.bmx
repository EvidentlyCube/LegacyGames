

Function GeoLineVSLine:Float[](x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, x4:Float, y4:Float) 
	'x1,y1,x2,y2,x3,y3,x4,y4,retur
	'x1,y1 - Starting point of first line
	'x2,y2 - Ending point of first line
	'x3,y3 - Starting point of Ending line
	'x4,y4 - Ending point of Ending line
	'retur - whether to store outcoming intersection points in TempA[]
	Local ua:Float=((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3))/((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1))
	Local ub:Float=((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3))/((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1))
	
	If (Ua<1 And Ua>0 And Ub<1 And Ub>0) Or (Ua=0 And Ub=0)
		Return [1.0,(x1+ua*(x2-x1)),(y1+ua*(y2-y1))]
	Else
		Return [0.0]
	EndIf
EndFunction

Function GeoLineVSCircle:Float[](x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, rad:Float) 
	'x1,y1,x2,y2,x3,y3,rad,retur
	'x1,y1 - Starting point of line
	'x2,y2 - Ending point of first line
	'x3,y3 - Position of Circle's center
	'rad   - Radius of the circle
	'retur - whether to store outcoming intersection points in TempA[]
	Local a:Double=(x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)
	Local b:Double=2*((x2-x1)*(x1-x3)+(y2-y1)*(y1-y3))
	Local c:Double=x3*x3+y3*y3+x1*x1+y1*y1-2*(x3*x1+y3*y1)-rad*rad
	Local delta:Float=b*b-4*a*c
	If delta>=0
		Local sqrd:Float=Sqr(delta)
		Local u1:Float=(-b-sqrd)/(2*a)
		Local u2:Float=(-b+sqrd)/(2*a)
		If u1>u2
			Local t:Float=u1
			u1=u2
			u2=t
		EndIf
		If u1>=0 And u1<=1
			Return [1.0,x1+u1*(x2-x1),y1+u1*(y2-y1)]
		ElseIf u2>=0 And u2<=1
			Return [1.0,x1+u2*(x2-x1),y1+u2*(y2-y1)]
		EndIf
	EndIf
	Return [0.0]
EndFunction
rem
Function GeoLineVSCircle:Byte(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, rad:Float) 
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
		Local sqrd:Float=Sqr(delta)
		Local u1:Float=(-b-sqrd)/(2*a)
		Local u2:Float=(-b+sqrd)/(2*a)
		If (u1>=0 And u1<=1) Or (u2>=0 And u2<=1)
			Return 1
		EndIf
	EndIf
	Return 0
EndFunction
Endrem

Function GeoLineVSRect:Float[](x1:Float,y1:Float,x2:Float,y2:Float,x3:Float,y3:Float,wid:Short,hei:Short)
	Local Intersect:Float[]
	Select(String(Int(Sgn(x2-x1)))+String(Int(Sgn(y2-y1))))
		Case "-1-1"
			Intersect=GeoLineVSLine(x1,y1,x2,y2,x3+wid,y3,x3+wid,y3+hei)
			If Not Intersect[0] Then Return GeoLineVSLine(x1,y1,x2,y2,x3,y3+hei,x3+wid,y3+hei) Else Return Intersect
		Case "-10"
			Return GeoLineVSLine(x1,y1,x2,y2,x3+wid,y3,x3+wid,y3+hei)
		Case "-11"
			Intersect=GeoLineVSLine(x1,y1,x2,y2,x3,y3,x3+wid,y3)
			If Not Intersect[0] Then Return GeoLineVSLine(x1,y1,x2,y2,x3+wid,y3,x3+wid,y3+hei) Else Return Intersect
		Case "0-1"
			Return GeoLineVSLine(x1,y1,x2,y2,x3,y3+hei,x3+wid,y3+hei)
		Case "01"
			Return GeoLineVSLine(x1,y1,x2,y2,x3,y3,x3+wid,y3)
		Case "1-1"
			Intersect=GeoLineVSLine(x1,y1,x2,y2,x3,y3+hei,x3+wid,y3+hei)
			If Not Intersect[0] Then Return GeoLineVSLine(x1,y1,x2,y2,x3,y3,x3,y3+hei) Else Return Intersect
		Case "10"
			Return GeoLineVSLine(x1,y1,x2,y2,x3,y3,x3,y3+hei)
		Case "11"
			Intersect=GeoLineVSLine(x1,y1,x2,y2,x3,y3,x3,y3+hei)
			If Not Intersect[0] Then Return GeoLineVSLine(x1,y1,x2,y2,x3,y3,x3+wid,y3) Else Return Intersect
		Case "00" 
			Return [0.0]
	EndSelect
	Return [0.0]
EndFunction