'History Log:
'
REM
This file was created by the BLIde solution explorer and should not be modified from outside BLIde
EndRem
'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HFF Program Info
'Program: Poing Editor
'Version: 0
'Subversion: 9
'Revision: 0
'#EndRegion &HFF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H01 Compile Options
SuperStrict
'#EndRegion &H01



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H0F Framework
Framework brl.glmax2d
Import brl.blitz
Import brl.glmax2d
Import brl.graphics
Import brl.pngloader
Import brl.standardio
'#EndRegion &H0F



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HAF Imports

'#EndRegion &HAF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H04 MyNamespace
'GUI
'guid:8a9ffb54_5d5c_46e2_a77f_11c669e79987
Private
TYPE z_8a9ffb54_5d5c_46e2_a77f_11c669e79987_3_0 abstract  'Resource folder
End Type


TYPE z_blide_bg8a9ffb54_5d5c_46e2_a77f_11c669e79987 Abstract
    Const Name:string = "Poing Editor" 'This string contains the name of the program
    Const MajorVersion:Int = 0  'This Const contains the major version number of the program
    Const MinorVersion:Int = 9  'This Const contains the minor version number of the program
    Const Revision:Int =  0  'This Const contains the revision number of the current program version
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


Type z_My_8a9ffb54_5d5c_46e2_a77f_11c669e79987 Abstract 'This type has all the run-tima binary information of your assembly
    Global Application:z_blide_bg8a9ffb54_5d5c_46e2_a77f_11c669e79987  'This item has all the currently available assembly version information.
    Global Resources:z_8a9ffb54_5d5c_46e2_a77f_11c669e79987_3_0  'This item has all the currently available incbined files names and relative location.
End Type


Global My:z_My_8a9ffb54_5d5c_46e2_a77f_11c669e79987 'This GLOBAL has all the run-time binary information of your assembly, and embeded resources shortcuts.
Public
'#EndRegion &H04 MyNamespace


'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H03 Includes
Include "BlockData.bmx"
Include "TBlock.bmx"
Include "Globals.bmx"
Include "TOption.bmx"
Include "MainLoop.bmx"
Include "Save.bmx"
Include "Load.bmx"
Include "loadc.bmx"
Include "Saveb.bmx"
 
'#EndRegion &H03

