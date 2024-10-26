function Check_Door(argument0, argument1) {
	/*
	Checking if there is door at desired position in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Check_door(x,y)
	x,y - x and y coordinates of check
	returns 1 if finds door at desired position
	*/


	if place_meeting(argument0,argument1,Door){return(instance_place(argument0,argument1,Door))}
	return(noone)



}
