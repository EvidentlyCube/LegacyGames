REM
This file was created by the BLIde solution explorer and should not be modified from outside BLIde
EndRem
'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HFF Program Info
'Program: DyROD
'Version: 0
'Subversion: 0
'Revision: 3
'#EndRegion &HFF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H01 Compile Options
SuperStrict
'#EndRegion &H01



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H0F Framework
Framework brl.glmax2d
Import brl.glmax2d
Import brl.hook
Import brl.map
Import brl.math
Import brl.max2d
Import brl.pngloader
Import brl.stream
Import brl.basic
Import brl.blitz
Import brl.filesystem
Import brl.textstream
Import brl.event

'#EndRegion &H0F



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HAF Imports

'#EndRegion &HAF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H04 MyNamespace
'GUI
'guid:12314300_d38d_419d_a752_9c1888c392ed
Private
TYPE z_12314300_d38d_419d_a752_9c1888c392ed_3_0 abstract  'Resource folder
End Type


TYPE z_blide_bg12314300_d38d_419d_a752_9c1888c392ed Abstract
    Const Name:string = "DyROD" 'This string contains the name of the program
    Const MajorVersion:Int = 0  'This Const contains the major version number of the program
    Const MinorVersion:Int = 0  'This Const contains the minor version number of the program
    Const Revision:Int =  3  'This Const contains the revision number of the current program version
    Const VersionString:String = MajorVersion + "." + MinorVersion + "." + Revision   'This string contains the assembly version in format (MAJOR.MINOR.REVISION)
    Const AssemblyInfo:String = Name + " " + MajorVersion + "." + MinorVersion + "." + Revision   'This string represents the available assembly info.
    ?win32
    Const Platform:String = "Win32" 'This constant contains "Win32", "MacOs" or "Linux" depending on the current running platoform for your game or application.
    ?
    ?MacOs
    Const Platform:String = "MacOs"
    ?
    ?Linux
    Const Platform:String = "Linux"
    ?
    ?PPC
    Const Architecture:String = "PPC" 'This const contains "x86" or "Ppc" depending on the running architecture of the running computer. x64 should return also a x86 value
    ?
    ?x86
    Const Architecture:String = "x86" 
    ?
    ?debug
    Const DebugOn : Int = True    'This const will have the integer value of TRUE if the application was build on debug mode, or false if it was build on release mode
    ?
    ?not debug
    Const DebugOn : Int = False
    ?
EndType


Type z_My_12314300_d38d_419d_a752_9c1888c392ed Abstract 'This type has all the run-tima binary information of your assembly
    Global Application:z_blide_bg12314300_d38d_419d_a752_9c1888c392ed  'This item has all the currently available assembly version information.
    Global Resources:z_12314300_d38d_419d_a752_9c1888c392ed_3_0  'This item has all the currently available incbined files names and relative location.
End Type


Global My:z_My_12314300_d38d_419d_a752_9c1888c392ed 'This GLOBAL has all the run-time binary information of your assembly, and embeded resources shortcuts.
Public
'#EndRegion &H04 MyNamespace


'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H03 Includes
Include "Core\Engine.bmx"
Include "Classes\TObject.bmx"
Include "Classes\TLevel.bmx"
Include "Classes\TRoom.bmx"
Include "Classes\TTile.bmx"
Include "Core\StateManager.bmx"
Include "Core\Settings.bmx"
Include "Core\GraphicManager.bmx"
Include "Core\ControlManager.bmx"
Include "Databases\DataGfxObjects.bmx"
Include "Parsers\ParserManager.bmx"
Include "Parsers\ParserGfxObjects.bmx"
Include "Core\Logger.bmx"
Include "Classes\TBrain.bmx"
Include "Brains\TBrainPlayer.bmx"
Include "Databases\DataTile.bmx"
Include "Parsers\ParserTiles.bmx"
Include "Parsers\ParserLevel.bmx"
Include "Databases\DataGfxTiles.bmx"
Include "Parsers\ParserRoom.bmx"
Include "Parsers\ParserBuildingBlock.bmx"
Include "Version.bmx"
Include "Databases\DataObject.bmx"
Include "Brains\TBrainMonsterRoach.bmx"
Include "StaticFunctions.bmx"
Include "Main.bmx"
Include "Core\Geometry.bmx"
 
'#EndRegion &H03

