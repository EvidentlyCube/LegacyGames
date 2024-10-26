function Block_Hit() {
	/*
	Hitting Block in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Block_Hit()
	*/

	file_bin_seek(global.save,10000+floor(x/25)+global.level*1000+floor(y/25)*32)
	file_bin_write_byte(global.save,0)
	if group=0{
	instance_destroy()
	} else {
	kill=1
	sprite_index=S_Wall_Hurt;
	var a,doh;
	doh=1
	for (a=0;a<number;a+=1){
	if (ide[a]).kill=0{doh=0;break}
	}
	if doh=1{
	for (a=1;a<number;a+=1){
	with (ide[a]){instance_destroy()}
	}
	instance_destroy()
	}
	}



}
