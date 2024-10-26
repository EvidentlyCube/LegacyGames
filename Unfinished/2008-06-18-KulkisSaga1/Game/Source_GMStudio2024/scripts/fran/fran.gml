function fran(argument0) {
	/*
	    Title: Floor Random
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
    
	        fran(value)
	        value - some number
        
	        Returns a random number limited by "Value" and automatically rounds it to down, e.g. both 1.1 and 1.9 will result with 1
	*/

	return(floor(random(argument0)))



}
