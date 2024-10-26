Type Settings
	' ########################################################################################################################################################################################################################################################
    ' ####
    ' ####                                                                                                                                                                                                                                 C O N S T A N T S
    ' ####
    ' ########################################################################################################################################################################################################################################################

	'Summary: Width of the room in tiles
    Const ROOM_WIDTH              :Int                = 32

	'Summary: Height of the room in tiles
    Const ROOM_HEIGHT             :Int                = 28
    
	'Summary: Width of the tile in pixels
    Const TILE_WIDTH              :Int                = 25

	'Summary: Height of the tile in pixels
    Const TILE_HEIGHT             :Int                = 25
	
	'Summary: Width of the room in pixels
	Const ROOM_WIDTH_PIXELS       :Int				  = ROOM_WIDTH * TILE_WIDTH
	
	'Summary: Height of the room in pixels
	Const ROOM_HEIGHT_PIXELS      :Int				  = ROOM_HEIGHT  * TILE_WIDTH 
	
	'Summary: Horizontal offset of the playfield
	Const PLAYFIELD_OFFSET_X      :Int				  = 224
	
	'Summary: Vertical offset of the playfield
	Const PLAYFIELD_OFFSET_Y      :Int				  = 68
	
	' ----------------------------
    '                   CONTROLS
    ' ----------------------------
	
	Global KEY_LEFT				  :Int				  = 65
	Global KEY_RIGHT			  :Int				  = 68
	Global KEY_DOWN				  :Int				  = 88
	Global KEY_UP				  :Int				  = 87
	
	Global KEY_UP_LEFT			  :Int				  = 81
	Global KEY_UP_RIGHT			  :Int				  = 69
	Global KEY_DOWN_LEFT		  :Int				  = 90
	Global KEY_DOWN_RIGHT		  :Int				  = 67
	
	Global KEY_ROTATE_CW		  :Int				  = 80
	Global KEY_ROTATE_CCW		  :Int				  = 79
	
End Type