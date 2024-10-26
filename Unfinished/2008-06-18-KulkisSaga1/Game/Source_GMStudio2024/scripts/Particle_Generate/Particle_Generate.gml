function Particle_Generate() {
	/*
	Particles declaring in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Particle_Generate()
	*/

	global.part_sys_a=part_system_create();
	part_system_depth(global.part_sys_a,-1000);

	global.part_type_a=part_type_create()
	part_type_shape         (global.part_type_a,pt_shape_line)
	part_type_alpha2        (global.part_type_a,1,0)
	part_type_orientation   (global.part_type_a,0,0,0,0,1)
	part_type_life          (global.part_type_a,5,30)
	part_type_speed         (global.part_type_a,2,4,-0.1,0.004)
	part_type_size          (global.part_type_a,0.1,0.5,-0.01,0.003)
	part_type_direction     (global.part_type_a,0,360,0,0)

	global.part_type_b=part_type_create()
	part_type_shape     (global.part_type_b,pt_shape_ring)
	part_type_alpha2    (global.part_type_b,1,0)
	part_type_life      (global.part_type_b,30,30)
	part_type_speed     (global.part_type_b,0,0,0,0)
	part_type_size      (global.part_type_b,0.5,0.5,0.01,0)
	part_type_direction (global.part_type_b,0,360,0,0)

	global.part_type_c=part_type_create()
	part_type_shape     (global.part_type_c,pt_shape_flare)
	part_type_alpha2    (global.part_type_c,1,0)
	part_type_color3    (global.part_type_c,c_red,c_white,c_black)
	part_type_life      (global.part_type_c,40,150)
	part_type_speed     (global.part_type_c,1,3,-0.05,0.005)
	part_type_size      (global.part_type_c,0.1,1,-0.02,0.005)
	part_type_direction (global.part_type_c,0,360,0,0)



}
