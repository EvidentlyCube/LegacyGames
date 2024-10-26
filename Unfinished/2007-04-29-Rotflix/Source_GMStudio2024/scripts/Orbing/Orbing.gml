function Orbing(argument0, argument1) {
	var ide;
	ide=instance_place(x+argument0*20,y+argument1*20,Orb)
	if instance_exists(ide){
	 with (ide){
	 var a;
	 a=0
	  repeat(coms){
	  script_execute(dos[a],num[a])
	  a+=1
	  }
	  instance_create(x,y,OrbFlash)
	  part_particles_create(global.part_sys_a,x+10,y+10,global.part_type_b,1)
	 } 
	}



}
