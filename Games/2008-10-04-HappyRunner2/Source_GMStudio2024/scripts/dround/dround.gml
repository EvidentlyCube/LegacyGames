function dround(argument0) {
	/*
	    Title: Double Round
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
    
	        dround(number)
	        number - some number
        
	        Returns the number rounded to the one closer to zero. In ohter words if number is:
	            *   Larger than zero return Number Floored
	            *   Lesser than zero return Number Ceiled 
	*/
	if argument0<0{return(ceil(argument0))} else {return(floor(argument0))}



}
