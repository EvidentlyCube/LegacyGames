'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TEyeEvent
	Field Ball:TBall
	Field Action:Byte
	Field var1:Float
	Field var2:Float
	Field var3:Float
	Field var4:Float
	Field var5:Float
	Function MakeNew:TEyeEvent(a:TBall,b:Byte,c:Float=0,d:Float=0,e:Float=0,f:Float=0,g:Float=0)
		Local lo:TEyeEvent=New TEyeEvent
		lo.Ball=a
		lo.Action=b
		lo.var1=c
		lo.var2=d
		lo.var3=e
		lo.var4=f
		lo.var5=g
		return lo
	EndFunction
End Type
