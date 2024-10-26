
Type Lists
	Global Enemies:TList=New TList
	Global Bullets:TList=New TList
	Global Markers:TList=New TList
	Global Effects:TList=New TList
	Global Fronts:TList=New TList
	Function FollowEffects()
		For Local i:TEffect= EachIn Effects
			i.Update()
		Next
	EndFunction
	Function FollowBullets()
		For Local i:TProjectile = EachIn Bullets
			i.Update()
		Next
	EndFunction
	Function FollowMarks()
		For Local i:Tmarker = EachIn Markers
			i.Update()
		Next
	EndFunction
	Function FollowEnemies()
		For Local i:TObject = EachIn Enemies
			i.Update()
		Next
	EndFunction
	Function FollowFronts()
		For Local i:TEffect = EachIn Fronts
			i.Update()
		Next
	EndFunction
EndType