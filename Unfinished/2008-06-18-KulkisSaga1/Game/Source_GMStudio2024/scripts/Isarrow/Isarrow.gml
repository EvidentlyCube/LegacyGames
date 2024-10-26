function Isarrow(argument0, argument1, argument2) {
	/*
	Checking if there is an arrow facing desired direction in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Isarrow(x,y,dir)
	x,y - x and y coordinates of check
	dir - direction of an arrow
	Returns 1 if there is an arrow facing desired direction
	*/

	if place_meeting(argument0,argument1,Arrow){    
	    with (instance_place(argument0,argument1,Arrow)){
	        if direction=argument2{return(1)}
	    }
	}
	return(0)



}
