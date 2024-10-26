function Save_level() {
	saf=global.l_title
	repeat (45-string_length(global.l_title)){
	saf+="]"
	}
	saf+=global.l_author
	repeat (45-string_length(global.l_author)){
	saf+="]"
	}
	var lev,bix,biy,goh;
	lev=""
	for (biy=0;biy<12;biy+=1){
	for (bix=0;bix<14;bix+=1){

	goh=instance_place(bix*48+96+30,biy*48+30,Objects)
	if instance_exists(goh){goh=(goh).object_index}

	switch (goh){
	case (Block):lev+="z";break;
	case (Base_Wht):lev+="q";break;
	case (Base_Blk):lev+="w";break;
	case (Base_Red):lev+="e";break;
	case (Base_Orn):lev+="r";break;
	case (Base_Yll):lev+="t";break;
	case (Base_Grn):lev+="y";break;
	case (Base_Trq):lev+="u";break;
	case (Base_Blu):lev+="i";break;
	case (Base_Vlt):lev+="o";break;
	case (Path_Wht):lev+="b";break;
	case (Path_Blk):lev+="b";break;
	case (Path_Red):lev+="b";break;
	case (Path_Orn):lev+="b";break;
	case (Path_Yll):lev+="b";break;
	case (Path_Grn):lev+="b";break;
	case (Path_Trq):lev+="b";break;
	case (Path_Blu):lev+="b";break;
	case (Path_Vlt):lev+="b";break;
	case (noone):lev+="b";break;
	}

	}
	}

	far=string(global.pathx)
	repeat (3-string_length(far)){
	if string_length(far)<3{far=string_insert("0",far,-1)}
	}
	saf+=far
	saf+=lev
	if !directory_exists("levels"){directory_create(working_directory+"/levels")}
	file=file_text_open_append("./levels/my.txt")
	file_text_write_string(file,saf)
	file_text_writeln(file)
	file_text_close(file)
	file=file_text_open_append("./levels/base.txt")
	file_text_write_string(file,saf)
	file_text_writeln(file)
	file_text_close(file)




}
