function draw_me_ext_blend(argument0) {
	/*
	    Title: Draw Me Blended Exended
	    Author: Maurice Zarzycki
	    Rights: 
	        *   You may not gain any physical profit from this script excepting when this script is a part of a 
	                whole playable game and this game won't allow player to see this script
	        *   You may not claim that this script was made by yourself or anyone else excepting the real author.
	    Help:
	        If you can't understand this script I suggest you to try one of this solutions, in the order of effectiveness
	        *   http://www.scripts.mauft.com - find this script and ask a question if it wasn't already answered
	        *   http://www.forum.mauft.com - register on a forum and ask a question if it wasn't already answered
	        *   Email me at scripts@mauft.com and explain your problem
	    Explanation:
    
	        draw_me_ext_blend(blendmode)
	        blendmode - indicates which blend to use (bm_add,bm_subtract, bm_normal or bm_max)
        
	        Draws the current object blended with blendmode blend with use of special graphic effects.
	*/

	draw_set_blend_mode(argument0)
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_set_blend_mode(bm_normal)



}
