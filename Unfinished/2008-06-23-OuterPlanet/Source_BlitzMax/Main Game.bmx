'---------------------------------------------------------------------------------------------------
' This program was written with BLIde (www.blide.org)
' Application:
' Author:
' License:
'---------------------------------------------------------------------------------------------------
SuperStrict
Framework brl.D3D7Max2d
Import brl.Math
Import BRL.Graphics
Import brl.filesystem
Import BRL.random
Import brl.PNGLoader
Import brl.JPGLoader
Import brl.StandardIO
Import brl.Hook
Import brl.event
Import "Events.bmx"
Include "Objects.bmx"
Include "Options.bmx"
Include "Level.bmx"
Include "Graphics.bmx"
Include "FunctionsMath.bmx"
Include "FunctionsGeometry.bmx"
Include "Player.bmx"
Include "Drawing.bmx"
Include "PlayerWeapons.bmx"
Include "Projectiles.bmx"
Include "Lists.bmx"
Include "Markers.bmx"
Include "Effects.bmx"
Include "Enemy_Square.bmx"
Include "Enemy_Blob.bmx"
Include "Enemy_Chopper.bmx"
Include "Enemy_Mutant.bmx"


Const VERSION:Byte=2	

For Local i:Byte=0 To 40
	TEnemyMutant.MakeNew(400+Rand(100),150)
Next

SetGraphicsDriver D3D7Max2DDriver() 
Local GraphicsObject:TGraphics = CreateGraphics(1024, 768, 0, 5, GRAPHICS_BACKBUFFER) 
SetGraphics GraphicsObject
Global Player:TPlayer=New TPlayer
SetBlend(ALPHABLEND)
HideMouse()
SeedRnd(100)
While True
	If KeyHit(KEY_TAB)
		For Local i:Byte=0 Until 7
			PlayerWeapons.Ammo[i]=PlayerWeapons.MaxAmmo[i]
		Next
	EndIf
	If KeyDown(KEY_1) Then PlayerWeapons.Weapon=0
	If KeyDown(KEY_2) Then PlayerWeapons.Weapon=1
	If KeyDown(KEY_3) Then PlayerWeapons.Weapon=2
	If KeyDown(KEY_4) Then PlayerWeapons.Weapon=3
	If KeyDown(KEY_5) Then PlayerWeapons.Weapon=4
	If KeyDown(KEY_6) Then PlayerWeapons.Weapon=5
	If KeyDown(KEY_7) Then PlayerWeapons.Weapon=6
	If KeyHit(KEY_ENTER) And KeyDown(164)
		If GraphicsDepth() = 32
			CloseGraphics(GraphicsObject) 
			GraphicsObject = CreateGraphics(1024, 768, 0, 0, GRAPHICS_BACKBUFFER) 
			SetGraphics GraphicsObject
			SetBlend(ALPHABLEND)
		Else
			CloseGraphics(GraphicsObject) 
			GraphicsObject = CreateGraphics(1024, 768, 32, 0, GRAPHICS_BACKBUFFER) 
			SetGraphics GraphicsObject
			SetBlend(ALPHABLEND)
		EndIf
	EndIf
	Level.ResetCanvas()
	Player.Update()
	Level.DrawLevelBottom()
	Player.Draw()
	Player.Legs.Draw()
	Player.Gun.Draw()
	Lists.FollowBullets()
	Lists.FollowEffects()
	Lists.FollowEnemies()
	Level.DrawLevelUpper()
	Lists.FollowMarks()
	Lists.FollowFronts()
	Drawing.DrawCross(Player.XMouse,Player.YMouse)
	Drawing.DrawHud()
	Flip 1
	Cls
Wend