function Generate() {
	str=ds_list_find_value(global.lb_level,global.leveled)

	lx=0
	ly=0

	repeat (168){
	switch (string_char_at(str,ly*14+lx+1)){
	case("q"):instance_create(lx*48+96,ly*48,Base_Wht);break;
	case("w"):instance_create(lx*48+96,ly*48,Base_Blk);break;
	case("e"):instance_create(lx*48+96,ly*48,Base_Red);break;
	case("r"):instance_create(lx*48+96,ly*48,Base_Orn);break;
	case("t"):instance_create(lx*48+96,ly*48,Base_Yll);break;
	case("y"):instance_create(lx*48+96,ly*48,Base_Grn);break;
	case("u"):instance_create(lx*48+96,ly*48,Base_Trq);break;
	case("i"):instance_create(lx*48+96,ly*48,Base_Blu);break;
	case("o"):instance_create(lx*48+96,ly*48,Base_Vlt);break;
	case("z"):instance_create(lx*48+96,ly*48,Block);break;
	}
	lx+=1
	if lx=14{lx=0;ly+=1}
	}



}
