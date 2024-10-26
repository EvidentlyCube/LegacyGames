
Type PlayerWeapons
	Global Weapon:Byte=6
	Global Ammo:Float[7]
	Global MaxAmmo:Float[]=[100.0,10.0,80.0,400.0,200.0,40.0,5.0]
	Global ChargeMoment:Float=0
	Global WeaponWait:Byte=0
	Global WeaponWaitMax:Byte=1
	Global BlasterSpeed:Byte=6
	Global BlasterPower:Byte=2
	Global BlasterDistance:Short=150
	Global ShotgunFlaks:Byte=20
	Global ShotgunFlakPower:Byte=3
	Global MachineGunPower:Byte=3
	Global AcidPower:Float=0.1
	Global ShootX:Float
	Global ShootY:Float
	Global ShootDir:Float
	Global ShieldObject:TShield
	Global md1:Byte
	Global md2:Byte
	Global mh1:Byte
	Global mh2:Byte
	Function Update(sX:Float,sY:Float,dir:Float)
		ShootX=sX
		ShootY=sY
		ShootDir=dir
		md1=MouseDown(1)
		md2=MouseDown(2)
		mh1=MouseHit(1)
		mh2=MouseHit(2)
		If WeaponWait>0 Then WeaponWait:-1
		If Weapon=0 Or (Not Level.PreciseCollision(ShootX-2,ShootY-2) And..
			Not Level.PreciseCollision(ShootX+2,ShootY-2) And..
			Not Level.PreciseCollision(ShootX-2,ShootY+2) And..
			Not Level.PreciseCollision(ShootX+2,ShootY+2))
			Select Weapon
				Case 0 Blaster()
				Case 1 RocketLauncher()
				Case 2 AcidGun()
				Case 3 ElectroGun()
				Case 4 MachineGun()
				Case 5 Shotgun()
				Case 6 SniperRifle()
			End Select
		EndIf
	EndFunction
	Function Blaster()
		Ammo[0]=0
		If WeaponWait=0
			If md2=1
				SetBlend(LIGHTBLEND)
				Drawing.DrawScaled(ChargeMoment/150+1,1+ChargeMoment/150,ShootX,ShootY,GFX_PLASMA,MilliSecs()/2 Mod 3)
				SetBlend(ALPHABLEND)
				ChargeMoment:+2
				If Rand(900)<ChargeMoment Then TChargeDust.MakeNew(ShootX+Rand(-30,30),ShootY+Rand(-30,30))
				If ChargeMoment>300 Then ChargeMoment=300
				Ammo[0]=ChargeMoment/3
			ElseIf ChargeMoment>0
				ShotBlaster(ShootX,ShootY,ShootDir)
				ChargeMoment=0
				WeaponWaitMax=Ceil(ChargeMoment/30)
				WeaponWait=WeaponWaitMax
			ElseIf mh1>0
				ShotBlaster(ShootX,ShootY,ShootDir)
				ChargeMoment=0
				WeaponWaitMax=2
				WeaponWait=2
			EndIf
		EndIf
	EndFunction
	Function ShotBlaster(sX:Int,sY:Int,dir:Float)
		If Not Level.PreciseCollision(sX,sY)
			Local momentum:Float
			If ChargeMoment>0
				momentum=ChargeMoment/50
			Else
				momentum=0
			EndIf
			TBlaster.MakeNew(sX,sY,dir,BlasterSpeed+momentum/5,2+2*(momentum/3),BlasterPower+momentum*momentum,BlasterDistance*(momentum+1))
		EndIf
	EndFunction
	
	Function RocketLauncher()
		If WeaponWait=0 And Ammo[1]>0
			If mh1>0 
				ShotMissile(ShootX,ShootY,ShootDir)
				WeaponWaitMax=100
				WeaponWait=100
				Ammo[1]:-1
			ElseIf mh2>0
				TGrenade.MakeNew(ShootX,ShootY,ShootDir,Min(10,Dist(ShootX,ShootY,Player.XMouse,Player.YMouse)/30))
				WeaponWaitMax=25
				WeaponWait=25
				Ammo[1]:-1
			EndIf
		EndIf
	EndFunction
	Function ShotMissile(sX:Int,sY:Int,dir:Float)
		TMissile.MakeNew(sX,sY,dir,3)
	EndFunction
	Function ShotGrenade(sX:Int,sY:Int,dir:Float,power:Float)
		TGrenade.MakeNew(sX,sY,dir,power)
	EndFunction
	
	Function AcidGun()
		If WeaponWait=0 
			If md1=1 And Ammo[2]>0
				WeaponWaitMax=4
				WeaponWait=4
				Ammo[2]:-1
				ShotAcid(ShootX,ShootY,ShootDir,Min(8,Dist(Player.XMouse,Player.YMouse,ShootX,ShootY)/40))
			ElseIf mh2 And Ammo[2]>9
				WeaponWaitMax=25
				WeaponWait=25
				Ammo[2]:-10
				ShotBigAcid(ShootX,ShootY,ShootDir,Min(8,Dist(Player.XMouse,Player.YMouse,ShootX,ShootY)/40))
			EndIf
		EndIf
	EndFunction
	Function ShotAcid(sX:Int,sY:Int,dir:Float,power:Float)
		TAcid.MakeNew(sX,sY,dir,power)
	EndFunction
	Function ShotBigAcid(sX:Int,sY:Int,dir:Float,power:Float)
		TBigAcid.MakeNew(sX,sY,dir,power)
	EndFunction
	
	Function ElectroGun()
		If WeaponWait=0 And Ammo[3]>0
			If md1>0 
				ShotElectro(ShootX,ShootY,ShootDir)
				Ammo[3]:-1
			ElseIf md2>0
				ShotSHield(ShootX,ShootY)
				Ammo[3]:-1
			EndIf
		EndIf
	EndFunction
	Function ShotElectro(sx:Int,sy:Int,dir:Float)
		TElectro.ShootMe(sx,sy,dir)
	EndFunction
	Function ShotShield(sx:Int,sy:Int)
		If ShieldObject<>Null
			ShieldObject.Set(sx,sy)
		Else
			ShieldObject=TShield.MakeNew(sx,sy)
		EndIf
	EndFunction
	
	Function MachineGun()
		If WeaponWait=0	And Ammo[4]>0
			If md1>0 
				ShotMachineGun(ShootX,ShootY,ShootDir)
				Ammo[4]:-1
			ElseIf md2>0
				ShotMiniGun(ShootX,ShootY,ShootDir)
				Ammo[4]:-1
			EndIf
		EndIf
	EndFunction
	Function ShotMachineGun(sx:Int,sy:Int,dir:Float)
		TRifleShot.Shot(ShootX,ShootY,ShootDir+RndFloat()*Rand(-1,1),MachineGunPower)
		TMuzzle.MakeNew(sx,sy,dir,Rand(1,2))
		WeaponWait=4
		WeaponWaitMax=4
	EndFunction
	Function ShotMiniGun(sx:Int,sy:Int,dir:Float)
		TRifleShot.Shot(ShootX,ShootY,ShootDir+RndFloat()*Rand(-15,15),MachineGunPower)
		TMuzzle.MakeNew(sx,sy,dir,Rand(1,2))
		WeaponWait=2
		WeaponWaitMax=2
	EndFunction
	
	Function Shotgun()
		If WeaponWait=0 And Ammo[5]>0
			If mh1>0 
				ShotShotgun(ShootX,ShootY,ShootDir)
				Ammo[5]:-1
			ElseIf mh2>0
				ShotFlak(ShootX,ShootY,ShootDir)
				Ammo[5]:-1
			EndIf
		EndIf
	EndFunction
	Function ShotShotgun(sx:Int,sy:Int,dir:Float)
		For Local i:Byte=0 Until ShotgunFlaks
			TRifleShot.Shot(ShootX,ShootY,ShootDir+RndFloat()*Rand(-20,20),ShotgunFlakPower)
		Next
		TMuzzle.MakeNew(sx,sy,dir,3)
		WeaponWait=40
		WeaponWaitMax=WeaponWait
	EndFunction
	Function ShotFlak(sx:Int,sy:Int,dir:Float)
		For Local i:Byte=0 Until ShotgunFlaks
			TShotgunFlak.MakeNew(ShootX,ShootY,ShootDir+RndFloat()*Rand(-20,20))
		Next
		TMuzzle.MakeNew(sx,sy,dir,3)
		WeaponWait=70
		WeaponWaitMax=WeaponWait
	EndFunction
	
	Function SniperRifle()
		If md2>0
			ShotLaserAim(ShootX,ShootY,ShootDir)
		EndIf
		If WeaponWait=0 And Ammo[6]>0
			If mh1>0
				ShotSniperRifle(ShootX,ShootY,ShootDir)
				Ammo[6]:-1
			EndIf
		EndIf
	EndFunction
	Function ShotSniperRifle(sx:Int,sy:Int,dir:Float)
		TRifleShot.Shot(sx,sy,dir,100)
		Player.Push(Cos(dir+180)*10,Sin(dir+180)*2)
		WeaponWait=150
		WeaponWaitMax=WeaponWait
	EndFunction
	Function ShotLaserAim(sx:Int,sy:Int,dir:Float)
		Local pos:Float[]=Level.RayCast(sx,sy,Cos(dir),Sin(dir))
		SetColor(255,0,0)
		Drawing.ShapeLine(sx,sy,pos[0],pos[1])
		SetColor(255,255,255)
	EndFunction
EndType

Type TSniperRifle
	Method Update()
		
	EndMethod
EndType