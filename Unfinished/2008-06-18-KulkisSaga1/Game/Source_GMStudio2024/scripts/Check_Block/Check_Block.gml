function Check_Block(argument0, argument1) {
	/*
	Checking if there is blocker at desired position in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Check_Block(x,y)
	x,y - x and y coordinates of check
	returns 1 if finds blocker at desired position
	*/

	if place_meeting(argument0,argument1,Blocker){return(instance_place(argument0,argument1,Blocker))}
	return(noone)



}
