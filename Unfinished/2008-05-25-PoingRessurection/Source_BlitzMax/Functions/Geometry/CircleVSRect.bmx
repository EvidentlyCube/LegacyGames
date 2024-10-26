'This BMX file was edited with BLIde ( http://www.blide.org )

Function GeoCircleVSRect:Byte(xa:Float, ya:Float, wi:Float, he:Float,xb:Float,yb:Float,rad:Int)
	wi:-1
	wi:-1
	If GeoLineVSCircle(xa+wi,ya,xa,ya,xb,yb,rad)[0] Or..
	 GeoLineVSCircle(xa+wi,ya+he,xa+wi,ya,xb,yb,rad)[0] Or..
	 GeoLineVSCircle(xa,ya,xa,ya+he,xb,yb,rad)[0] Or..
	 GeoLineVSCircle(xa,ya+he,xa+wi,ya+he,xb,yb,rad)[0]
		Return 1
	EndIf
	Return 0
EndFunction