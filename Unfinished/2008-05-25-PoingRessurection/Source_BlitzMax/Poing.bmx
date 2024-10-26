REM
This file was created by the BLIde solution explorer and should not be modified from outside BLIde
EndRem
'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HFF Program Info
'Program: Poing
'Version: 0
'Subversion: 0
'Revision: 1
'#EndRegion &HFF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H01 Compile Options
SuperStrict
'#EndRegion &H01



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H0F Framework
Framework brl.max2d
Import brl.basic
Import brl.blitz
Import brl.d3d7max2d
Import brl.dxgraphics
Import brl.event
Import brl.glgraphics
Import brl.glmax2d
Import brl.keycodes
Import brl.math
Import brl.standardio
Import brl.pngloader
'#EndRegion &H0F



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HAF Imports

'#EndRegion &HAF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H04 MyNamespace
'GUI
Private
TYPE z_c9becff0_30a8_49e1_a96f_2d563dddc08d abstract  'Resource folder
End Type


TYPE z_blide_bg253ed5a6_9d6f_4ae5_bd40_8e6a0f5c9f5a Abstract
    Const Name:string = "Poing" 'This string contains the name of the program
    Const MajorVersion:Int = 0  'This Const contains the major version number of the program
    Const MinorVersion:Int = 0  'This Const contains the minor version number of the program
    Const Revision:Int =  1  'This Const contains the revision number of the current program version
    Const VersionString:String = MajorVersion + "." + MinorVersion + "." + Revision   'This string contains the assembly version in format (MAJOR.MINOR.REVISION)
    Const AssemblyInfo:String = Name + " " + MajorVersion + "." + MinorVersion + "." + Revision   'This string represents the available assembly info.
EndType


Type z_My_253ed5a6_9d6f_4ae5_bd40_8e6a0f5c9f5a Abstract 'This type has all the run-tima binary information of your assembly
    Global Application:z_blide_bg253ed5a6_9d6f_4ae5_bd40_8e6a0f5c9f5a  'This item has all the currently available assembly version information.
    Global Resources:z_c9becff0_30a8_49e1_a96f_2d563dddc08d  'This item has all the currently available incbined files names and relative location.
End Type


Global My:z_My_253ed5a6_9d6f_4ae5_bd40_8e6a0f5c9f5a 'This GLOBAL has all the run-time binary information of your assembly, and embeded resources shortcuts.
Public
'#EndRegion &H04 MyNamespace


'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H03 Includes
Include "Graphics.bmx"
Include "Globals.bmx"
Include "GraphicsMode.bmx"
Include "Functions\Geometry\LineVSCircle.bmx"
Include "Types\Drawing.bmx"
Include "Types\TPaddle.bmx"
Include "MainLoop.bmx"
Include "Types\TBall.bmx"
Include "Types\Lists.bmx"
Include "Types\Level.bmx"
Include "Types\TRoom.bmx"
Include "Types\TBrick.bmx"
Include "Functions\Geometry\CircleVSRect.bmx"
Include "Types\TEyeEvent.bmx"
 
'#EndRegion &H03

