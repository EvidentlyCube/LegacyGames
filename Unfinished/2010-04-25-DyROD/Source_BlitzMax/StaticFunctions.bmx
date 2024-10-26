'This BMX file was edited with BLIde ( http://www.blide.org )

'Summary: Value of the Right direction. 
Const DIR_RIGHT        :Int = 0

'Summary: Value of the Bottom-Right direction. 
Const DIR_BOTTOM_RIGHT :Int = 1

'Summary: Value of the Bottom direction. 
Const DIR_BOTTOM       :Int = 2

'Summary: Value of the Bottom-Left direction. 
Const DIR_BOTTOM_LEFT  :Int = 3

'Summary: Value of the Left direction. 
Const DIR_LEFT         :Int = 4

'Summary: Value of the Top-Left direction. 
Const DIR_TOP_LEFT     :Int = 5

'Summary: Value of the Top direction. 
Const DIR_TOP          :Int = 6

'Summary: Value of the Top-Right direction. 
Const DIR_TOP_RIGHT    :Int = 7

'Summary: An array holding the X components of the movement in specified directions.
Global ___directionComponentsX:Int[] = [1, 1, 0, -1, -1, -1,  0,  1]
    
'Summary: An array holding the Y components of the movement in specified directions. 
Global ___directionComponentsY:Int[] = [0, 1, 1,  1,  0, -1, -1, -1]

'Summary: Returns the X component of the movement in specified direction.
Function xFromDirection:Int(direction:Int)
    Return ___directionComponentsX[ direction Mod 8 ]
End Function

'Summary: Returns the Y component of the movement in specified direction.
Function yFromDirection:Int(direction:Int)
    Return ___directionComponentsY[ direction Mod 8 ]
End Function

'Summary: Return the X position wrapped to fit into the room dimensions
Function wrapX:Int(x:Int)
	Return TrueMod(x, Settings.ROOM_WIDTH)
End Function

'Summary: Return the X position wrapped to fit into the room dimensions
Function wrapY:Int(y:Int)
	Return TrueMod(y, Settings.ROOM_HEIGHT)
End Function