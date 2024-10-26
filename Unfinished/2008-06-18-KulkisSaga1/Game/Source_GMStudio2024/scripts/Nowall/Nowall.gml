function Nowall(argument0, argument1) {
	/*
	Checking if there is no wall at desired position in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Nowall(x,y)
	x,y - x and y coordinates of check
	Returns 1 if there is no wall
	*/

	if !place_meeting(argument0,argument1,Par_Walls){return(1)}
	return(0)



}
