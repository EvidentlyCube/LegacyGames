Type TEffect Abstract
	Field x:Int
	Field y:Int
	Method Update() Abstract
	Method Draw() Abstract
EndType

Type TMuzzle Extends TEffect
	Field dir:Float
	Field scale:Float[2]
	Field alpha:Float
	Field muz:Byte
	Function MakeNew(x:Int,y:Int,dir:Float,muzzle:Byte)
		Local muzz:TMuzzle=New TMuzzle
		muzz.x=x
		muzz.y=y
		muzz.dir=dir
		muzz.muz=muzzle
		muzz.scale[0]=RndFloat()+0.5
		muzz.scale[1]=(RndFloat()+0.5)*Sgn(RndFloat()-0.5)
		muzz.alpha=1
		Lists.Effects.AddLast(muzz)
	EndFunction
	Method Update()
		alpha:-0.1
		If alpha<0 Then Lists.Effects.Remove(Self)
		Draw()
	EndMethod
	Method Draw()
		SetBlend(LIGHTBLEND)
		Drawing.SetEffects(alpha,dir,scale[0],scale[1])
		Drawing.Draw(x,y,GFX_MUZZLES[muz])
		Drawing.SetEffects()
		SetBlend(ALPHABLEND)
	EndMethod
EndType

Type TExplosion Extends TEffect
	Field iX:Float, iY:Float
	Field Col:Int[3]
	Field A:Float=1
	Field siz:Float
	Field gfx:Byte=0
	Field red:Float
	Method Update()
		X:+iX
		If Level.PreciseCollision(X,Y) Then iX:*-0.8
		Y:+iY
		If Level.PreciseCollision(X,Y) Then iY:*-0.8
		iX:*0.95-red
		iY:*0.95-red
		A:-red
		If A<=0
			Lists.Effects.Remove(Self)
		EndIf
		Draw()
	EndMethod
	Method Draw()
		SetBlend(LIGHTBLEND)
		SetColor(Col[0],Col[1],Col[2])
		SetAlpha(A)
		SetScale(siz,siz)
		Drawing.Draw(X,Y,GFX_EXPLOSION[gfx],Floor(6-6*A))
		SetScale(1,1)
		SetColor(255,255,255)
		SetAlpha(1)
		SetBlend(ALPHABLEND)
	EndMethod
	Function MakeNew(_x:Int,_y:Int,_col:Int[],_ix:Float,_iy:Float,_siz:Float)
		Local lo:TExplosion=New TExplosion
		lo.x=_x
		lo.y=_y
		lo.Col=_col
		lo.iX=_ix
		lo.iY=_iy
		lo.siz=_siz
		lo.red=0.03+RndFloat()/100-RndFloat()/100
		lo.gfx=Rand(0,6)
		Lists.Effects.AddLast(lo)
	EndFunction
	Function Explode(x:Int,y:Int,col:Int[],speed:Int,size:Float,number:Int=1)
		While number>0
			number:-1
			Local lo:TExplosion=New TExplosion
			lo.x=x
			lo.y=y
			lo.Col=col
			Local dir:Float=RndFloat()*360
			lo.iX=Cos(dir)*RndFloat()*speed
			lo.iY=Sin(dir)*RndFloat()*speed
			lo.siz=size*(RndFloat()+0.5)
			lo.gfx=Rand(0,6)
			lo.red=0.03+RndFloat()/100-RndFloat()/100
			Lists.Effects.AddLast(lo)
		Wend
	EndFunction
EndType
Type TDamExplosion Extends TEffect
	Field iX:Float, iY:Float
	Field Col:Int[3]
	Field A:Float=1
	Field rad:Float
	Field siz:Float
	Field gfx:Byte=0
	Field red:Float
	Method Update()
		X:+iX
		If Level.PreciseCollision(X,Y) Then iX:*-0.8
		Y:+iY
		If Level.PreciseCollision(X,Y) Then iY:*-0.8
		iX:*0.95-red
		iY:*0.95-red
		A:-red
		For Local i:TObject=EachIn Lists.Enemies
			If A>0.5
				If i.HitCircle(x,y,rad)
					i.Damage(RndFloat()*(A+0.5))
					A:-0.01
				EndIf
			Else
				Exit
			EndIf
		Next
		If A<=0
			Lists.Effects.Remove(Self)
		EndIf
		Draw()
	EndMethod
	Method Draw()
		SetBlend(LIGHTBLEND)
		SetColor(Col[0],Col[1],Col[2])
		SetAlpha(A)
		SetScale(siz,siz)
		Drawing.Draw(X,Y,GFX_EXPLOSION[gfx],Floor(6-6*A))
		SetScale(1,1)
		SetColor(255,255,255)
		SetAlpha(1)
		SetBlend(ALPHABLEND)
	EndMethod
	Function MakeNew(_x:Int,_y:Int,_col:Int[],_ix:Float,_iy:Float,_siz:Float)
		Local lo:TDamExplosion=New TDamExplosion
		lo.x=_x
		lo.y=_y
		lo.Col=_col
		lo.iX=_ix
		lo.iY=_iy
		lo.siz=_siz
		lo.red=0.03+RndFloat()/100-RndFloat()/100
		lo.gfx=Rand(0,6)
		Lists.Effects.AddLast(lo)
	EndFunction
	Function Explode(x:Int,y:Int,col:Int[],speed:Int,size:Float,number:Int=1)
		While number>0
			number:-1
			Local lo:TDamExplosion=New TDamExplosion
			lo.x=x
			lo.y=y
			lo.Col=col
			Local dir:Float=RndFloat()*360
			lo.iX=Cos(dir)*Min(Rand(speed),Rand(speed))
			lo.iY=Sin(dir)*Min(Rand(speed),Rand(speed))
			lo.siz=size*(RndFloat()+0.5)
			lo.gfx=Rand(0,6)
			lo.red=0.03+RndFloat()/100-RndFloat()/100
			lo.rad=size*40
			Lists.Effects.AddLast(lo)
		Wend
	EndFunction
EndType

Type TEffectItem Extends TEffect
	Field iX:Float,iy:Float
	Field scale:Float,scaleMod:Float
	Field alpha:Float,alphaMod:Float
	Field rot:Float,rotMod:Float
	Field gfx:TImage,frame:Short
	Field blend:Byte
	Field grav:Byte
	Method Update()
		x:+iX
		y:+iY
		If grav>0 Then iY:+Level.Gravity/grav
		scale:+scaleMod
		alpha:+alphaMod
		rot:+rotMod
		If Alpha<0 Or scale<0 Or y>Level.Height*25 Then Lists.Effects.Remove(Self)
		Draw()
	EndMethod
	Method Draw()
		SetBlend(blend)
		Drawing.SetEffects(alpha,rot,scale,scale)
		Drawing.Draw(x,y,gfx,frame)
		Drawing.SetEffects()
		SetBlend(ALPHABLEND)
	EndMethod
	Function MakeNew(_x:Int,_y:Int,_scale:Float,_alpha:Float,_rot:Float,_blend:Byte,_gfx:TImage,_frame:Short=0,..
					_ix:Float=0,_iy:Float=0,_scaleMod:Float=0,_alphaMod:Float=0,_rotMod:Float=0,_grav:Byte=0)
		Local lo:TEffectItem=New TEffectItem
		lo.x=_x
		lo.y=_y
		lo.scale=_scale
		lo.alpha=_alpha
		lo.rot=_rot
		lo.blend=_blend
		lo.gfx=_gfx
		lo.frame=_frame
		lo.iX=_ix
		lo.iy=_iy
		lo.scaleMod=_scaleMod
		lo.alphaMod=_alphaMod
		lo.rotMod=_rotMod
		lo.grav=_grav
		Lists.Effects.AddLast(lo)
	End Function
EndType
Type TFallingChopper Extends TEffect
	Field x:Float,y:Float
	Field iy:Float,ix:Float
	Field rot:Float=0
	Field rotMod:Float
	Method Update()
		y:+iy
		x:+iX
		iy:+Level.Gravity/2
		If iy>22 Then iy=22
		If Level.PreciseCollision(x,y)
			Lists.Effects.Remove(Self)
			TExplosion.Explode(x-ix,y-iy,[255,255,255],2,0.2,12)
			For Local i:Byte=0 To 8
				TDebris.MakeNew(x-iX,y-iY,Rand(180),4+RndFloat()*6,50+Rand(200))
			Next
		EndIf
		rot:+rotmod
		Draw()
	EndMethod
	Method Draw()
		Drawing.DrawRotated(rot,x,y,GFX_E_CHOPPER)
	EndMethod
	Function Makenew(_x:Int,_y:Int,_ix:Float,_iy:Float)
		Local lo:TFallingChopper=New TFallingChopper
		lo.x=_x
		lo.y=_y
		lo.ix=_ix
		lo.iy=_iy
		lo.rotMod=(RndFloat()-0.5)*40
		Lists.Effects.AddLast(lo)
	EndFunction
EndType

Type TDust Extends TEffect
	Field x:Float
	Field y:Float
	Field ix:Float
	Field iy:Float
	Field Alpha:Float
	Method Update()
		x:+ix
		y:+iy
		alpha:-0.1
		If Alpha<=0
			Lists.Effects.Remove(Self)
		EndIf
		Draw()
	End Method
	Method Draw()
		SetAlpha(alpha)
		Drawing.ShapePlot(x,y)
		SetAlpha(1)
	EndMethod
	Function MakeNew(x:Int,y:Int,no:Byte,dir:Float,dirchange:Float)
		For Local i:Byte=0 Until no
			Local lo:TDust=New TDust
			Local ndir:Float=dir+((RndFloat()*2)-1)*dirchange
			Local spd:Float=RndFloat()*4
			lo.x=x
			lo.y=y
			lo.ix=Cos(ndir)*spd
			lo.iy=Sin(ndir)*spd
			lo.Alpha=RndFloat()+1
			Lists.Effects.AddFirst(lo)
		Next
	EndFunction
EndType
Type TChargeDust Extends TEffect
	Field x:Float
	Field y:Float
	Field spd:Float
	Field alpha:Float=0
	Method Update()
		alpha=1-Dist2(PlayerWeapons.ShootX,PlayerWeapons.Shooty,x,y)/2000
		Local Dir:Float=ATan2(PlayerWeapons.Shooty-y,PlayerWeapons.ShootX-x)
		x:+Cos(Dir)*spd
		y:+Sin(Dir)*spd
		spd:+0.03
		If Alpha>0.95 Or Alpha<0
			Lists.Effects.Remove(Self)
		EndIf
		Draw()
	End Method
	Method Draw()
		SetAlpha(alpha)
		Drawing.ShapePlot(x,y)
		SetAlpha(1)
	EndMethod
	Function MakeNew(x:Int,y:Int)
		Local lo:TChargeDust=New TChargeDust
		lo.x=x
		lo.y=y
		lo.spd=PlayerWeapons.ChargeMoment/300
		Lists.Effects.AddFirst(lo)
	EndFunction
EndType

Type TShield Extends TEffect
	Field x:Int
	Field y:Int
	Field moment:Float
	Field change:Float
	Field param:Float[5]
	Field parch:Float[5]
	Field state:Float[5]
	Method Set(sX:Int,sY:Int)
		change=4
	EndMethod
	Method Update()
		moment:+change
		x=Player.x+5
		y=Player.Y+5
		change:-1
		If moment<=0 
			Lists.Effects.Remove(Self)
			PlayerWeapons.ShieldObject=Null
		EndIf
		If moment>100 Then moment=100
		Draw()
	EndMethod
	Method Draw()
		state[0]:+parch[0]
		state[1]:+parch[1]
		state[2]:+parch[2]
		state[3]:+parch[3]
		state[4]:+parch[4]
		DrawText(parch[0],100,100)
		SetBlend(LIGHTBLEND)
		Drawing.SetEffects((moment+5)/100,0,1.2+Sin(state[0])*param[0],1.2+Sin(state[0])*param[0],Min(255,240+Sin(state[2])*param[2]),Min(255,240+Sin(state[3])*param[3]),Min(255,240+Sin(state[4])*param[4]))
		Drawing.Draw(x,y,GFX_SHIELD)
		Drawing.SetEffects()
		SetBlend(ALPHABLEND)
	EndMethod
	Function MakeNew:TShield(sX:Int,sY:Int)
		Local lo:TShield = New TShield
		lo.x=sX
		lo.y=sY
		lo.change=0.5
		lo.moment=0
		lo.param=[(RndFloat()-0.5)/2,(RndFloat()-0.5)/2,(RndFloat()-0.5)*25,(RndFloat()-0.5)*25,(RndFloat()-0.5)*25]
		lo.state=[1.0*Rand(360),1.0*Rand(360),1.0*Rand(360),1.0*Rand(360),1.0*Rand(360)]
		lo.parch=[1.0*Rand(10),1.0*Rand(20),1.0*Rand(20),1.0*Rand(20),1.0*Rand(20)]
		Lists.Effects.AddLast(lo)
		Return lo
	EndFunction
EndType

Type TTrail Extends TEffect
	Field iX:Float
	Field iY:Float
	Field distance:Float
	Field Alpha:Float=1
	Field da:Byte
	Field dir:Float
	Field red:Float
	Method Update()
		Draw()
		Alpha:-red/da
		If Alpha<=0 Then Lists.Effects.Remove(Self)
	EndMethod
	Method Draw()
		Local ran:Float=RndFloat()/10
		SetBlend(LIGHTBLEND)
		Drawing.SetEffects(Alpha,ATan2(iy-y,ix-x),distance/255)
		Drawing.Draw(x,y,GFX_TRAIL)
		Drawing.SetEffects()
		SetBlend(ALPHABLEND)
	EndMethod
	Function MakeNew(ex:Int,ey:Int,sx:Int,sy:Int,da:Byte=50)
		Local lo:TTrail=New TTrail;
		lo.X=ex
		lo.Y=ey
		lo.iX=sx
		lo.iY=sy
		lo.da=da
		lo.red=Rand(2,20)
		lo.distance=Dist(lo.x,lo.y,lo.ix,lo.iy)
		Lists.Effects.AddLast(lo)
	EndFunction
	Function DrawFlak(x:Float,y:Float,ix:Float,iy:Float)
		SetBlend(LIGHTBLEND)
		Drawing.SetEffects(1,ATan2(iy-y,ix-x),Dist(x,y,ix,iy)/255,1,167,132,57)
		Drawing.Draw(x,y,GFX_TRAIL)
		Drawing.SetEffects()
		SetBlend(ALPHABLEND)
	EndFunction
EndType

Type TDebris Extends TEffect
	Field ix:Float,iy:Float
	Field rot:Float,rotmod:Float
	Field fram:Byte
	Field tim:Float
	Method Update()
		ix:*0.99
		x:+ix
		If Level.PreciseCollision(X,Y)
			x:-ix
			x=Level.RayCast(x,y,ix,0.0)[0]-Sgn(ix)
			iX:*-0.3
			tim:-5
		EndIf
		iY:+Level.Gravity/2
		y:+iy
		If Level.PreciseCollision(X,Y)
			y:-iy
			y=Level.RayCast(x,y,0.0,iy)[1]-Sgn(iy)
			iX:*0.8
			iY:*-0.3
			tim:-5
		EndIf
		Tim:-1
		If Tim<0 Then Hit()
		Draw()
	EndMethod
	Method Draw()
		rot:+rotmod
		SetAlpha(tim/20)
		Drawing.DrawRotated(rot,x,y,GFX_DEBRIS,fram)
		SetAlpha(1)
	EndMethod
	Method Hit()
		Lists.Effects.Remove(Self)
	EndMethod
	Function MakeNew(_x:Int,_y:Int,_dir:Float,spd:Float,_len:Int)
		Local lo:TDebris=New TDebris
		lo.x=_x
		lo.y=_y
		lo.ix=Cos(_dir)*spd
		lo.iy=Sin(_dir)*spd
		lo.rot=Rand(360)
		lo.rotmod=RndFloat()*Rand(-40,40)
		lo.fram=Rand(4)
		lo.tim=_len
		Lists.Effects.AddLast(lo)
	EndFunction
EndType

Type TConveyor Extends TEffect
	Field frame:Float
	Field dir:Float
	Method Update()
		frame:+dir
		If frame<0 Then frame:+5
		If frame>=5 Then frame:-5
		Draw()
	EndMethod
	Method Draw()
		Drawing.Draw(x,y,GFX_CONVEYOR,frame)
	EndMethod
	Function MakeNew(sx:Int,sy:Int,dir:Float)
		Local lo:TConveyor=New TConveyor
		lo.x=sx
		lo.y=sy
		lo.dir=dir/2
		lo.frame=0
		Lists.Fronts.AddLast(lo)
	EndFunction
EndType