function Make_Level(argument0) {
	 /*
	Loading new level from file in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Make_Level(number)
	number - level number

	*/
	/*Assign Temporary variables' names*/
	var file,Room,pos_x,pos_y,obj_id,room_code;
	Room=A_Level;
	room_code="";

	/*Clear Room from tiles and objects*/
	room_instance_clear(Room);
	room_tile_clear(Room);

	room_instance_add(Room, 0, 0, RoomInitializer);
    show_debug_message(program_directory)
	
	global.prop_sets = [];
	
	show_debug_message(program_directory);
	/*Adding Objects*/
	var path = "./levels/lev"+string(argument0)+".KIL";
	if (!file_exists(path)) {
		show_message("File does not exist!");
	}
	
	show_debug_message("Loading level " + string(argument0) + " (path = " + path + ")");
	file=file_bin_open(path, 0)
	show_debug_message("File length: " + string(file_bin_size(file)));
	for (pos_y=0;pos_y<29;pos_y+=1){
	    for (pos_x=0;pos_x<32;pos_x+=1){
	        switch(file_bin_read_byte(file)){
	//---------------------------------------------<:Wall
	            case(1): 
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Wall);  
	            break;
	//---------------------------------------------<:Blocker
	            case(2):
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Blocker);
					array_push(
						global.prop_sets,
						[obj_id, "color", Read_A_B_C(file)],
						[obj_id, "group", Read_B_C_X(file)]
					);
	            break;
	//---------------------------------------------<:Colourer
	            case(3):
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Colourer);
					array_push(
						global.prop_sets ,
						[obj_id, "color", Read_A_B_C(file)]
					);
	            break;
	//---------------------------------------------<:Spikes
	            case(16):
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Spikes);
					array_push(
						global.prop_sets ,
						[obj_id, "image_index", Read_A_B_C(file)]
					);
	            break;
	//---------------------------------------------<:Bouncer Horizontal
	            case(17):
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Bouncer_H);
					array_push(
						global.prop_sets ,
						[obj_id, "spd", sign(Read_A_B_C(file) * 2-1) * 2.5]
					);
	            break;
	//---------------------------------------------<:Bouncer Vertical
	            case(18):
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Bouncer_V);
					array_push(
						global.prop_sets ,
						[obj_id, "spd", sign(Read_A_B_C(file)*2-1)*2.5]
					);
	            break;
	//---------------------------------------------<:Rotter Clockwise
	            case(19):
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Rotter_R);
					array_push(
						global.prop_sets ,
						[obj_id, "direction", Read_A_B_C(file)*90]
					);
	            break;
	//---------------------------------------------<:Rotter Counter-Clockwise
	            case(20):
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Rotter_L);
					array_push(
						global.prop_sets ,
						[obj_id, "direction", Read_A_B_C(file) * 90]
					);
	            break;
	//---------------------------------------------<:Thorner Orthogonal
	            case(21):
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Thorner_Orth);
					array_push(
						global.prop_sets ,
						[obj_id, "color", Read_A_B_C(file)*90]
					);
	            break;
	//---------------------------------------------<:Thorner Diagonal
	            case(22):
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Thorner_Diag);
					array_push(
						global.prop_sets ,
						[obj_id, "movx", sign(((Read_A_B_C(file)+1) mod 4)-1.5)*-2.5],
						[obj_id, "movy", sign(Read_A_B_C(file)-1.5)*-2.5]
					);
	            break;
	//---------------------------------------------<:Door
	            case(48):
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Door);

					array_push(
						global.prop_sets ,
						[obj_id, "image_index", Read_A_B_C(file) mod 4],
						[obj_id, "type", Read_C_X_X(file)],
						[obj_id, "image_blend", Set_Color(floor(Read_A_B_C(file)/4))],
						[obj_id, "color", floor(Read_A_B_C(file)/4)],
						[obj_id, "group", Read_B_C_X(file)]
					);
	                switch(Read_A_B_C(file) mod 4){
	                    case(0):
							array_push(
								global.prop_sets,
								[obj_id, "movx", 1],
								[obj_id, "movy", 0]
							);
							break;
	                    case(1):
							array_push(
								global.prop_sets,
								[obj_id, "movx", 0],
								[obj_id, "movy", 1]
							);
							break;
	                    case(2):
							array_push(
								global.prop_sets,
								[obj_id, "movx", -1],
								[obj_id, "movy", 0]
							);
							break;
	                    case(3):
							array_push(
								global.prop_sets,
								[obj_id, "movx", 0],
								[obj_id, "movy", -1]
							);
							break;
	                }                                   
	            break;
	//---------------------------------------------Button
	            case(49):
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Button);
					
					array_push(
						global.prop_sets,
						[obj_id, "image_blend", Set_Color(Read_B_C_X(file))],
						[obj_id, "$SPECIAL", ["Buttons_Get_Special", Read_A_B_C(file)]]
					);
	            break;            
	//---------------------------------------------<:Switch
	            case(50):
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Switch);
					
					array_push(
						global.prop_sets,
						[obj_id, "image_blend", Set_Color(Read_B_C_X(file))],
						[obj_id, "image_index", Read_C_X_X(file)],
						[obj_id, "$SPECIAL", ["Buttons_Get_Special", Read_A_B_C(file)]],
					);
	            break;     
	//---------------------------------------------<:Crate
	            case(51): 
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Crate);  
	            break;  
	//---------------------------------------------<:Arrow
	            case(52): 
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Arrow);  
					array_push(
						global.prop_sets,
						[obj_id, "direction", Read_A_B_C(file)]
					);
	            break;      
	//---------------------------------------------<:Talker Starter
	            case(254): 
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Talk_Act);  
					array_push(
						global.prop_sets,
						[obj_id, "file", Read_A_B_C(file)],
						[obj_id, "mode", Read_B_C_X(file)],
						[obj_id, "spec", Read_C_X_X(file)]
					);
	            break;       
	//---------------------------------------------<:Player
	            case(255):
	                zup=room_instance_add(Room,pos_x*25,pos_y*25,Player);
	            break;
	        }
	    }
	}


	for (pos_y=0;pos_y<29;pos_y+=1){
	    for (pos_x=0;pos_x<32;pos_x+=1){
	        switch(file_bin_read_byte(file)){
	//---------------------------------------------<:Grass
	            case(1): 
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Grass);  
	            break;
	//---------------------------------------------<:Mushroom
	            case(2): 
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Mushroom);  
	            break;
	//---------------------------------------------<:Mushroom+Grass
	            case(3): 
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Grass);  
	                obj_id=room_instance_add(Room,pos_x*25,pos_y*25,Mushroom);
	            break;
	        }
	    }
	}

	for (pos_y=0;pos_y<29;pos_y+=1){
	    for (pos_x=0;pos_x<32;pos_x+=1){
	        switch(file_bin_read_byte(file)){
	//---------------------------------------------<:Crack
	            case(1): 
	                obj_id=room_instance_add(Room,pos_x*2512,pos_y*25+12,Cracks);  
					array_push(
						global.prop_sets,
						[obj_id, "num", Read_X_X_A(file)],
						[obj_id, "len", Read_X_A_B(file)]
					);
	            break;
	        }
	    }
	}

	file_bin_seek(file,5568)
	global.lev_r=file_bin_read_byte(file)
	global.lev_d=file_bin_read_byte(file)
	global.lev_l=file_bin_read_byte(file)
	global.lev_u=file_bin_read_byte(file)

	room_code+="Master_Create()";
	file_bin_close(file)
	room_goto(Room)





}
