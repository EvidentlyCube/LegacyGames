function Crack_Draw(argument0, argument1, argument2, argument3, argument4) {
	/*
	Drawing a crack in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Crack_Draw()
	*/
	draw_line(argument0-2*argument4,argument1+2*argument4,argument2-2*argument4,argument3+2*argument4);
	draw_line(argument0-1*argument4,argument1+1*argument4,argument2-1*argument4,argument3+1*argument4);
	draw_line(argument0-2*argument4,argument1+1*argument4,argument2-2*argument4,argument3+1*argument4);
	draw_line(argument0+1*argument4,argument1-2*argument4,argument2+1*argument4,argument3-2*argument4);
	draw_line(argument0,argument1-1*argument4,argument2,argument3-1*argument4);
	draw_line(argument0,argument1-2*argument4,argument2,argument3-2*argument4);
	draw_line(argument0-1*argument4,argument1,argument2-1*argument4,argument3);
	draw_line(argument0-2*argument4,argument1,argument2-2*argument4,argument3);
	draw_line(argument0-1*argument4,argument1-1*argument4,argument2-1*argument4,argument3-1*argument4);
	draw_line(argument0-1*argument4,argument1-2*argument4,argument2-1*argument4,argument3-2*argument4);
	draw_line(argument0-2*argument4,argument1-1*argument4,argument2-2*argument4,argument3-1*argument4);
	draw_line(argument0-2*argument4,argument1-2*argument4,argument2-2*argument4,argument3-2*argument4);



}
