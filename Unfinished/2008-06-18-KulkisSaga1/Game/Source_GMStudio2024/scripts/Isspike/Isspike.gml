function Isspike(argument0, argument1, argument2) {
	/*
	Checking if there is hazardous spike at desired place in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Isspike(x,y,dir)
	x,y - x and y coordinates of check
	dir - direction of the spike
	Returns 1 if there is hazardous spike
	*/

	if place_meeting(argument0,argument1,Spikes){    
	    with (instance_place(argument0,argument1,Spikes)){
	        if image_index=argument2{return(1)}
	    }
	}
	return(0)



}
