
Function Round:Int(x:Float)
	if x mod 1>0.5 then return Ceil(x) else return Floor(x)	
EndFunction

Function Dist:Float(x1:Float, y1:Float, x2:Float, y2:Float) 
	Return Sqr((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
EndFunction

Function Dist2:Float(x1:Float, y1:Float, x2:Float, y2:Float) 
	Return (x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)
EndFunction

Function CalcAngle:Float(Ang1:Float,Ang2:Float)
	If Ang1=Ang2
		Return 0.0
	Else
		Local fDif:Float=(Ang2-Ang1)   
		If fDif>=180.0
			fDif=fDif-180.0    'Correct the half
			fDif=180.0-fDif    'Invert the half
			fDif=0-fDif        'Reverse direction
			Return fDif
		Else
			If fDif<=-180.0
				fDif=fDif+180.0    'Correct the half
				fDif=180.0+fDif    
				Return fDif
			EndIf
		EndIf
		Return fDif
	EndIf
End Function