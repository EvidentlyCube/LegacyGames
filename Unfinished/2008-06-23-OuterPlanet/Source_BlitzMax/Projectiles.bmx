Type TProjectile Abstract
	Field x:Float
	Field y:Float
	Field dir:Float
	Method Update()	Abstract
	Method Hit(hp:Int) Abstract
	Method Draw() Abstract
EndType

Type TBlaster Extends TProjectile
	Field diamX:Float
	Field diamY:Float
	Field speed:Float
	Field moveX:Float
	Field moveY:Float
	Field radius:Float
	Field endX:Float
	Field endY:Float
	Field pow:Int
	Field finDist:Float
	Field range:Int
	Field frame:Byte=0
	Method Update()
		Local id:TObject
		Local Distance:Float=1000
		Local Pos:Float[]=[0.0,endX,endY]
		Local line1:Float[]
		Local line2:Float[]
		Local line3:Float[]
		finDist:-speed
		If finDist>0
			Pos[0]=1
			Pos[1]=x+moveX*speed
			Pos[2]=y+moveY*speed
		EndIf
		For Local i:TObject=EachIn Lists.Enemies
			If i.HitCircle(x,y,radius)
				id=i
				Pos[0]=2
				Pos[1]=x
				Pos[2]=y
				Exit
			EndIf
			line1=i.HitLine(X-diamY,Y-diamX,Pos[1]+diamY,Pos[2]+diamX)
			line2=i.HitLine(X+diamX,Y+diamY,Pos[1]+diamX,Pos[2]+diamY)
			line3=i.HitLine(X-diamX,Y-diamY,Pos[1]-diamX,Pos[2]-diamY)
			If line1[0]=0 Then line1[0]=1000 Else line1[0]=Dist2(x+diamY,y+diamX,line1[1]-diamY,line1[2]-diamX)
			If line2[0]=0 Then line2[0]=1000 Else line2[0]=Dist2(x+diamX,y+diamY,line2[1],line2[2])
			If line3[0]=0 Then line3[0]=1000 Else line3[0]=Dist2(x-diamX,y-diamY,line3[1],line3[2])
			If line1[0]<line2[0]
				If line1[0]>line3[0] And line3[0]<1000
					line1=[line3[0],line3[1]+diamX,line3[2]+diamY]
				ElseIf line1[0]<1000
					line1=[line1[0],line1[1]-diamY,line1[2]-diamX]
				EndIf
			ElseIf line2[0]<line3[0] And line2[0]<1000
				line1=[line2[0],line2[1]-diamX,line2[2]-diamY]
			ElseIf line3[0]<1000
				line1=[line3[0],line3[1]+diamX,line3[2]+diamY]
			EndIf
			If line1[0]<Distance
				Distance=line1[0]
				Id=i
				Pos=line1
				Pos[0]=2
			EndIf
		Next
		Select Pos[0]
			Case 1
				x:+moveX*speed
				y:+moveY*speed
			Case 0
				x=Pos[1]
				y=Pos[2]
				Hit(999)
			Case 2
				x=Pos[1]
				y=Pos[2]
				Local enemyHP:Int=id.hp
				id.Damage(pow,dir)
				Hit(enemyHP)
		End Select
		range:-Speed
		Speed:*1.08
		If range<0
			Hit(999)
		EndIf
		Draw()
	EndMethod
	Method Hit(hp:Int)
		pow:-hp
		For Local i:Byte=0 To 5+radius
			TEffectItem.MakeNew(x,y,radius/4,1,0,LIGHTBLEND,GFX_PLASMA,Rand(2),Cos(Rand(360))*speed/4,Sin(Rand(360))*speed/4,-RndFloat()/20,-RndFloat()/20-0.01,Rand(40))
		Next
		If pow>0
			For Local i:TObject=EachIn Lists.Enemies
				If i.HitCircle(x,y,radius)
					Local enemyHP:Int=i.hp
					i.Damage(pow,dir)
					pow:-EnemyHP
				EndIf
				If pow<=0
					Exit
				EndIf
			Next
		EndIf
		If pow<=0 Then Lists.Bullets.Remove(Self)
	EndMethod
	Method Draw()
		SetBlend(LIGHTBLEND)
		frame:+1
		If frame>2 Then frame=0
		SetScale(radius/2,radius/2)
		Drawing.Draw(x,y,GFX_PLASMA,frame)
		'Drawing.ShapeOval(x-radius,y-radius,radius*2,radius*2)
		SetScale(1,1)
		SetBlend(ALPHABLEND)
	EndMethod
	Function MakeNew:Byte(_x:Int,_y:Int,_dir:Float,_spd:Float,_rad:Byte=2,_pow:Byte=1,_range:Short=5000)
		Local lo:TBlaster=New TBlaster
		lo.x=_x
		lo.y=_y
		lo.dir=_dir
		lo.moveX=Cos(_dir)
		lo.moveY=Sin(_dir)
		lo.speed=_spd
		lo.radius=_rad
		lo.range=_range
		lo.diamX=Cos(_dir+90)*_rad
		lo.diamY=Sin(_dir+90)*_rad
		Local dis1:Float[]=Level.RayCast(lo.x+lo.moveX*lo.radius,lo.y+lo.moveY*lo.radius,lo.moveX,lo.moveY)
		Local dis2:Float[]=Level.RayCast(lo.x+lo.diamX,lo.y+lo.diamY,lo.moveX,lo.moveY)
		Local dis3:Float[]=Level.RayCast(lo.x-lo.diamX,lo.y-lo.diamY,lo.moveX,lo.moveY)
		Local dists:Float[]=[Dist(lo.x,lo.y,dis1[0],dis1[1]),Dist(lo.x+lo.diamX,lo.y+lo.diamY,dis2[0],dis2[1]),Dist(lo.x-lo.diamX,lo.y-lo.diamY,dis3[0],dis3[1])]
		If dists[0]<dists[1]
			If dists[0]<dists[2]
				lo.endX=dis1[0]
				lo.endY=dis1[1]
			Else
				lo.endX=dis3[0]+lo.diamX
				lo.endY=dis3[1]+lo.diamY
			EndIf
		Else If dists[1]<dists[2]
			lo.endX=dis2[0]-lo.diamX
			lo.endY=dis2[1]-lo.diamY
		Else
			lo.endX=dis3[0]+lo.diamX
			lo.endY=dis3[1]+lo.diamY
		EndIf
		lo.finDist=Dist(_x,_y,lo.endX,lo.endY)
		lo.pow=_pow
		For Local i:TObject=EachIn Lists.Enemies
			If i.HitCircle(_x,_y,_rad)
				Local hp:Int=i.hp
				i.Damage(_pow,_dir)
				lo.Hit(hp)
				Return(0)
			EndIf
		Next
		Lists.Bullets.AddLast(lo)
		return(1)
	EndFunction
EndType

Type TMissile Extends TProjectile
	Field diamX:Float
	Field diamY:Float
	Field speed:Float
	Field moveX:Float
	Field moveY:Float
	Field endX:Float
	Field endY:Float
	Field pow:Int
	Field radius:Int
	Field finDist:Int
	Method Update()
		Local id:TObject
		Local Distance:Float=1000
		Local Pos:Float[]=[0.0,endX,endY]
		Local line1:Float[]
		Local line2:Float[]
		finDist:-speed
		If finDist>0
			Pos[0]=1
			Pos[1]=x+moveX*speed
			Pos[2]=y+moveY*speed
		EndIf
		For Local i:TObject=EachIn Lists.Enemies
			If i.HitCircle(x,y,radius)
				id=i
				Pos[0]=2
				Pos[1]=x
				Pos[2]=y
				Exit
			EndIf
			line1=i.HitLine(X+diamX,Y+diamY,Pos[1]+diamX,Pos[2]+diamY)
			line2=i.HitLine(X-diamX,Y-diamY,Pos[1]-diamX,Pos[2]-diamY)
			If line1[0]=0 Then line1[0]=1000 Else line1[0]=Dist2(x+diamX,y+diamY,line1[1],line1[2])
			If line2[0]=0 Then line2[0]=1000 Else line2[0]=Dist2(x-diamX,y-diamY,line2[1],line2[2])
			If line1[0]<line2[0] And line1[0]<1000
				line1=[line1[0],line1[1]-diamX,line1[2]-diamY]
			ElseIf line2[0]<1000
				line1=[line2[0],line2[1]+diamX,line2[2]+diamY]
			EndIf
			If line1[0]<Distance
				Distance=line1[0]
				Id=i
				Pos=line1
				Pos[0]=2
			EndIf
		Next
		Select Pos[0]
			Case 1
				x:+moveX*speed
				y:+moveY*speed
			Case 0
				x=Pos[1]
				y=Pos[2]
				Hit(999)
			Case 2
				x=Pos[1]
				y=Pos[2]
				id.Damage(40,dir)
				Hit(0)
		End Select
		Speed:*1.08
		Draw()
	EndMethod
	Method Hit(hp:Int)
		TDamExplosion.Explode(x,y,[255,255,255],10,0.3,40)
		Lists.Bullets.Remove(Self)
	EndMethod
	Method Draw()
		Drawing.DrawRotated(dir,x,y,GFX_ROCKET)
		'Drawing.ShapeOval(x-radius,y-radius,radius*2,radius*2)
	EndMethod
	Function MakeNew:Byte(_x:Int,_y:Int,_dir:Float,_spd:Float,_rad:Byte=2)
		Local lo:TMissile=New TMissile
		lo.x=_x
		lo.y=_y
		lo.dir=_dir
		lo.moveX=Cos(_dir)
		lo.moveY=Sin(_dir)
		lo.speed=_spd
		lo.radius=2
		lo.diamX=Cos(_dir+90)*1.5
		lo.diamY=Sin(_dir+90)*1.5
		Local dis1:Float[]=Level.RayCast(lo.x+lo.diamX,lo.y+lo.diamY,lo.moveX,lo.moveY)
		Local dis2:Float[]=Level.RayCast(lo.x-lo.diamX,lo.y-lo.diamY,lo.moveX,lo.moveY)
		If Dist2(lo.x+lo.diamX,lo.y+lo.diamY,dis1[0],dis1[1])<Dist2(lo.x-lo.diamX,lo.y-lo.diamY,dis2[0],dis2[1])
			lo.endX=dis1[0]-lo.diamX
			lo.endY=dis1[1]-lo.diamY
		Else
			lo.endX=dis2[0]+lo.diamX
			lo.endY=dis2[1]+lo.diamY
		EndIf
		lo.finDist=Dist(lo.x,lo.y,lo.endX,lo.endY)
		For Local i:TObject=EachIn Lists.Enemies
			If i.HitCircle(lo.x,lo.y,lo.radius)
				i.Damage(lo.pow,_dir)
				lo.Hit(1)
				Return(0)
			EndIf
		Next
		Lists.Bullets.AddLast(lo)
		return(1)
	EndFunction
EndType

Type TGrenade Extends TProjectile
	Field iX:Float
	Field iY:Float
	Field Angle:Float
	Field timer:Short=200
	Method Update()
		Local ox:Int=x
		Local oy:Int=y
		x:+ix
		Angle:+iX*4 
		If Level.PreciseCollision(X,Y)
			x:-ix
			x=Level.RayCast(x,y,ix,0.0001)[0]-Sgn(ix)
			iX:*-0.5
		EndIf
		y:+iy
		iY:+Level.Gravity/2
		If Level.PreciseCollision(X,Y)
			y:-iy
			y=Level.RayCast(x,y,0.0001,iy)[1]-Sgn(iy)
			iX:*0.9
			iY:*-0.5
		EndIf
		Timer:-1
		If Timer=0 Then Hit(1)
		Local TempDist:Int=1000
		Local id:TObject
		Local pos:Float[]
		For Local i:TObject=EachIn Lists.Enemies
			If i.HitCircle(x,y,4)
				Hit(1)
				id=Null
				Exit
			Else
				pos=i.HitLine(ox,oy,x,y)
				If pos[0]
					id=i
					x=pos[1]
					y=pos[2]
				EndIf
			EndIf
		Next
		If id<>Null
			Hit(1)
		EndIf
		Draw()
	EndMethod
	Method Draw()
		Drawing.DrawRotated(Angle,x,y,GFX_GRENADE)
	EndMethod
	Method Hit(hp:Int)
		TDamExplosion.Explode(x,y,[255,255,255],10,0.3,40)
		Lists.Bullets.Remove(Self)
	EndMethod
	Function MakeNew(x:Int,y:Int,dir:Float,power:Int)
		Local lo:TGrenade=New TGrenade
		lo.x=x
		lo.y=y
		lo.dir=dir
		lo.iX=Cos(dir)*power
		lo.iY=Sin(dir)*power
		Lists.Bullets.AddLast(lo)
	EndFunction
EndType
Type TShotgunFlak Extends TProjectile
	Field iX:Float
	Field iY:Float
	Field timer:Int
	Method Update()
		Local ox:Int=x
		Local oy:Int=y
		ix:*0.99
		x:+ix
		If Level.PreciseCollision(X,Y)
			x:-ix
			x=Level.RayCast(x,y,ix,0.0)[0]-Sgn(ix)
			iX:*-1
			timer:-5
		EndIf
		iY:+Level.Gravity/2
		y:+iy
		If Level.PreciseCollision(X,Y)
			y:-iy
			y=Level.RayCast(x,y,0.0,iy)[1]-Sgn(iy)
			iX:*0.95
			iY:*-0.7
			timer:-5
		EndIf
		Timer:-1
		If Timer<0 Then Hit(1)
		Local id:TObject
		Local pos:Float[]
		For Local i:TObject=EachIn Lists.Enemies
			If i.HitCircle(x,y,4)
				Hit(1)
				id=Null
				i.Damage(5,dir)
				Exit
			Else
				pos=i.HitLine(ox,oy,x,y)
				If pos[0]
					id=i
					x=pos[1]
					y=pos[2]
				EndIf
			EndIf
		Next
		If id<>Null
			Hit(1)
			id.Damage(5)
		EndIf
		Draw()
		TTrail.DrawFlak(ox,oy,x,y)
	EndMethod
	Method Draw()
		Drawing.Draw(x,y,GFX_FLAK)
	EndMethod
	Method Hit(hp:Int)
		Lists.Bullets.Remove(Self)
	EndMethod
	Function MakeNew(x:Int,y:Int,dir:Float)
		Local lo:TShotgunFlak=New TShotgunFlak
		lo.x=x
		lo.y=y
		lo.dir=dir
		lo.iX=Cos(dir)*(22+RndFloat()-RndFloat())
		lo.iY=Sin(dir)*(22+RndFloat()-RndFloat())
		lo.timer=30+Rand(30)
		Lists.Bullets.AddLast(lo)
	EndFunction
EndType

Type TAcid Extends TProjectile
	Field iX:Float
	Field iY:Float
	Field timer:Float=200
	Method Update()
		x:+iX
		If Level.PreciseCollision(X,Y)
			iX=iX
			While Level.PreciseCollision(X,Y)
				x:-Sgn(iX)
			Wend
			iX=0
		End If
		iY:+Level.Gravity/2
		y:+iY
		timer:-1
		If Level.PreciseCollision(X,Y)
			iY=Sgn(iY)
			While Level.PreciseCollision(X,Y)
				y:-iY
			Wend
			iY=0
			iX=0
		EndIf
		For Local i:TObject=EachIn Lists.Enemies
			If timer<20 Then Exit
			If i.HitCircle(x,y,2)
				i.Damage(PlayerWeapons.AcidPower,ATan2(iY,iY))
				timer:-1
				iX=0
				iY=0
			EndIf
		Next
		If timer<0 Then Hit(1)
		Draw()
	EndMethod
	Method Draw()
		Drawing.DrawAlphed(timer/20,x,y,GFX_ACIDSMALL)
	End Method
	Method Hit(hp:Int)
		Lists.Bullets.Remove(Self)
	EndMethod
	Function MakeNew(_x:Int,_y:Int,_dir:Float,spd:Float)
		Local lo:TAcid=New TAcid
		lo.x=_x
		lo.y=_y
		lo.iX=Cos(_dir)*spd
		lo.iY=Sin(_dir)*spd
		Lists.Bullets.AddLast(lo)
	EndFunction
EndType

Type TBigAcid Extends TProjectile
	Field iX:Float
	Field iY:Float
	Method Update()
		x:+iX
		If Level.PreciseCollision(X,Y)
			iX=iX
			While Level.PreciseCollision(X,Y)
				x:-Sgn(iX)
			Wend
			iX=0
			iY=0
			Hit(1)
		End If
		iY:+Level.Gravity/2
		y:+iY
		If Level.PreciseCollision(X,Y)
			iY=Sgn(iY)
			While Level.PreciseCollision(X,Y)
				y:-iY
			Wend
			iY=0
			iX=0
			Hit(1)
		EndIf
		For Local i:TObject=EachIn Lists.Enemies
			If i.HitCircle(x,y,4)
				i.Damage(PlayerWeapons.AcidPower*40,ATan2(iY,iX))
				Hit(1)
				Exit
			EndIf
		Next
		Draw()
	EndMethod
	Method Draw()
		Drawing.Draw(x,y,GFX_ACIDBIG)
	End Method
	Method Hit(hp:Int)
		For Local i:Byte=0 To 10
			TAcid.MakeNew(x,y,Rand(360),Rand(3,6))
		Next
		Lists.Bullets.Remove(Self)
	EndMethod
	Function MakeNew(_x:Int,_y:Int,_dir:Float,spd:Float)
		Local lo:TBigAcid=New TBigAcid
		lo.x=_x
		lo.y=_y
		lo.iX=Cos(_dir)*spd
		lo.iY=Sin(_dir)*spd
		Lists.Bullets.AddLast(lo)
	EndFunction
EndType

Type TElectro
	Function ShootMe(_x:Int,_y:Int,_dir:Float)
		Local dir:Float=_dir
		Local ndir:Float=_dir
		Local ix:Float=_x
		Local iy:Float=_y
		Local ox:Float=ix
		Local oy:Float=iy
		Local Flu:Byte
		Local Pos:Float[]
		Local dis:Float
		SetBlend(LIGHTBLEND)
		Repeat
			ix:+Cos(ndir)*flu
			iy:+Sin(ndir)*flu
			Pos=Level.RayCast(ox,oy,Cos(ndir),Sin(ndir))
			If Abs(Pos[0]-ox)<=Abs(ix-ox) And Abs(Pos[1]-oy)<=Abs(iy-oy)
				ix=Pos[0]
				iy=Pos[1]
				dis=Dist(ox,oy,ix,iy)
				Drawing.Draw(ox,oy,GFX_ELECTRO_SPOT)
				SetScale(dis,1)
				SetRotation(ATan2(iy-oy,ix-ox))
				Drawing.Draw(ox,oy,GFX_ELECTRO_HAND)
				SetScale(1,1)
				SetRotation(0)
				Hit(ox,oy,ix,iy,ATan2(iy-oy,ix-ox))
				Exit
			EndIf
			dis=Dist(ox,oy,ix,iy)
			Drawing.Draw(ox,oy,GFX_ELECTRO_SPOT)
			SetScale(dis,1)
			SetRotation(ATan2(iy-oy,ix-ox))
			Drawing.Draw(ox,oy,GFX_ELECTRO_HAND)
			SetScale(1,1)
			SetRotation(0)
			Hit(ox,oy,ix,iy,ATan2(iy-oy,ix-ox))
			ox=ix
			oy=iy
			flu=Rand(5,25)
			If CalcAngle(dir,ATan2(iy-_y,ix-_x))>0
				ndir=dir-RndFloat()*50
			Else
				ndir=dir+RndFloat()*50
			EndIf
		Forever
		SetBlend(ALPHABLEND)
	EndFunction
	Function Hit(_x:Int,_y:Int,_ix:Int,_iy:Int,_d:Float)
		If _ix-_x<>0 or _iy-_y<>0
			For Local i:TObject=EachIn Lists.Enemies
				If i.HitLine(_x,_y,_ix,_iy)[0]
					i.Damage(0.3,_d)
				EndIf
			Next
		EndIf
	EndFunction
EndType

Type TRifleShot
	Function Shot(x:Int,y:Int,dir:Float,pow:Int)
		Local pos:Float[]=Level.RayCast(x,y,Cos(dir),Sin(dir))
		Local maxDist:Int=1000
		Local id:TObject
		Local tempdist:Int
		Local hitpos:Float[]
		For Local i:TObject=EachIn Lists.Enemies
			hitpos=i.HitLine(x,y,pos[0],pos[1])
			If hitpos[0]	
				tempdist=Dist(x,y,hitpos[1],hitpos[2])
				If tempdist<maxDist
					id=i
					maxdist=tempdist
					pos[0]=hitpos[1]
					pos[1]=hitpos[2]
				EndIf
			EndIf
		Next
		If id<>Null Then id.Damage(pow,dir)
		TDust.MakeNew(pos[0],pos[1],Rand(5,10),dir+180,180)
		TTrail.MakeNew(x,y,pos[0],pos[1])
	EndFunction
EndType

Type TFireBall Extends TProjectile
	Field diamX:Float
	Field diamY:Float
	Field speed:Float
	Field moveX:Float
	Field moveY:Float
	Field radius:Float
	Field endX:Float
	Field endY:Float
	Field pow:Int
	Field finDist:Float
	Field range:Int
	Method Update()
		Local id:TObject
		Local Pos:Float[]=[0.0,endX,endY]
		Local line1:Float[]
		Local line2:Float[]
		Local line3:Float[]
		finDist:-speed
		If finDist>0
			Pos[0]=1
			Pos[1]=x+moveX*speed
			Pos[2]=y+moveY*speed
		EndIf
		If Player.HitCircle(x,y,radius)
			pos[0]=2
		EndIf
		If pos[0]<2
			line1=Player.HitLine(X-diamY,Y-diamX,Pos[1]+diamY,Pos[2]+diamX)
			line2=Player.HitLine(X+diamX,Y+diamY,Pos[1]+diamX,Pos[2]+diamY)
			line3=Player.HitLine(X-diamX,Y-diamY,Pos[1]-diamX,Pos[2]-diamY)
			If line1[0]=0 Then line1[0]=1000 Else line1[0]=Dist2(x+diamY,y+diamX,line1[1]-diamY,line1[2]-diamX)
			If line2[0]=0 Then line2[0]=1000 Else line2[0]=Dist2(x+diamX,y+diamY,line2[1],line2[2])
			If line3[0]=0 Then line3[0]=1000 Else line3[0]=Dist2(x-diamX,y-diamY,line3[1],line3[2])
			If line1[0]<line2[0]
				If line1[0]>line3[0] And line3[0]<1000
					line1=[line3[0],line3[1]+diamX,line3[2]+diamY]
				ElseIf line1[0]<1000
					line1=[line1[0],line1[1]-diamY,line1[2]-diamX]
				EndIf
			ElseIf line2[0]<line3[0] And line2[0]<1000
				line1=[line2[0],line2[1]-diamX,line2[2]-diamY]
			ElseIf line3[0]<1000
				line1=[line3[0],line3[1]+diamX,line3[2]+diamY]
			EndIf
			If line1[0]<1000
				x=line1[1]
				y=line1[2]
				pos[0]=2
			EndIf
		EndIf
		Select Pos[0]
			Case 1
				x:+moveX*speed
				y:+moveY*speed
			Case 0
				x=Pos[1]
				y=Pos[2]
				Hit(1)
			Case 2
				Player.Damage(pow)
				Hit(1)
		End Select
		Draw()
	EndMethod
	Method Hit(hp:Int)
		Lists.Bullets.Remove(Self)
	EndMethod
	Method Draw()
		SetBlend(LIGHTBLEND)
		Drawing.Draw(x,y,GFX_FIREBALL)
		SetBlend(ALPHABLEND)
	EndMethod
	Function MakeNew:Byte(_x:Int,_y:Int,_dir:Float,_spd:Float,_rad:Byte=2,_pow:Byte=1,_range:Short=5000)
		Local lo:TFireBall=New TFireBall
		lo.x=_x
		lo.y=_y
		lo.dir=_dir
		lo.moveX=Cos(_dir)
		lo.moveY=Sin(_dir)
		lo.speed=_spd
		lo.radius=_rad
		lo.range=_range
		lo.diamX=Cos(_dir+90)*_rad
		lo.diamY=Sin(_dir+90)*_rad
		Local dis1:Float[]=Level.RayCast(lo.x+lo.moveX*lo.radius,lo.y+lo.moveY*lo.radius,lo.moveX,lo.moveY)
		Local dis2:Float[]=Level.RayCast(lo.x+lo.diamX,lo.y+lo.diamY,lo.moveX,lo.moveY)
		Local dis3:Float[]=Level.RayCast(lo.x-lo.diamX,lo.y-lo.diamY,lo.moveX,lo.moveY)
		Local dists:Float[]=[Dist(lo.x,lo.y,dis1[0],dis1[1]),Dist(lo.x+lo.diamX,lo.y+lo.diamY,dis2[0],dis2[1]),Dist(lo.x-lo.diamX,lo.y-lo.diamY,dis3[0],dis3[1])]
		If dists[0]<dists[1]
			If dists[0]<dists[2]
				lo.endX=dis1[0]
				lo.endY=dis1[1]
			Else
				lo.endX=dis3[0]+lo.diamX
				lo.endY=dis3[1]+lo.diamY
			EndIf
		Else If dists[1]<dists[2]
			lo.endX=dis2[0]-lo.diamX
			lo.endY=dis2[1]-lo.diamY
		Else
			lo.endX=dis3[0]+lo.diamX
			lo.endY=dis3[1]+lo.diamY
		EndIf
		lo.finDist=Dist(_x,_y,lo.endX,lo.endY)
		lo.pow=_pow
		If Player.HitCircle(_x,_y,_rad)
			Player.Damage(_pow)
			lo.Hit(1)
			Return(0)
		EndIf
		Lists.Bullets.AddLast(lo)
		return(1)
	EndFunction
EndType
