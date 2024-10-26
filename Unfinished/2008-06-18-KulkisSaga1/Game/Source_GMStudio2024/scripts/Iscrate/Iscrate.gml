function Iscrate(argument0, argument1) {
	/*
	Checking if there is a crate at desired position in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Nowall(x,y)
	x,y - x and y coordinates of check
	Returns crate ID if finds one, else returns special object Noone
	*/

	if place_meeting(argument0,argument1,Crate){return(instance_place(argument0,argument1,Crate))}
	return(noone)



}
