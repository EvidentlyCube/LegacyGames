function Master_Create() {
	with (Master){
	    with (Blocker){
	        Block_Create()
	    }
	    with (Blocker){
	        Block_Align()
	    }
	    with (Blocker){
	        Block_Grouping()
	    }

	    with (Colourer){
	        Colourer_Create()
	    }
    
	    with (Grass){
	        Grass_Create()
	    }
    
	    /*Remake Walls*/
	    if global.temp_rewalling=1{
	        if sprite_exists(global.wallsprite){
	            sprite_delete(global.wallsprite);
	            global.wallsprite=-1;
	        }
        
	        with (Cracks){Add_Crack(x,y,num,len);instance_destroy()}
	        Add_Effects()
	        with (Wall){Insert_Walls()}
	        with (Door){Door_Add_Base()}
        
	        global.wallsprite=sprite_create_from_surface(
				global.sur_wall,
				0,
				0,
				800,
				726,
				1,
				1,
				0,
				0
			);
	        global.temp_rewalling=0;
	    }
	    /*insert Wall object and assign proper texture*/
	    Masta=instance_create(0,0,Master_Wall);
	    Masta.sprite_index=global.wallsprite;
    
    
    
    
    
	    if global.temp_rebackground=1{
	        if background_exists(global.background){
	            background_delete(global.background);
	            global.background=-1;
	        }
	        surface_copy(global.sur_back,0,0,global.sur_wall_back);
	        global.background=background_create_from_surface(global.sur_back,0,0,800,725,0,0,1);
	        global.temp_rebackground=0;
	    }         
	    __background_set( e__BG.Index, 0, global.background );   
	    __background_set( e__BG.Alpha, 0, 0.2 )
        
	    if global.temp_reforeground=1{
	        if background_exists(global.foreground){
	            background_delete(global.foreground);
	            global.foreground=-1;
	        }
        
	        with(Mushroom){Add_Mushroom()}
	        with(Grass){Insert_Grass(x,y,r,d,l,u)}
        
	        global.foreground=background_create_from_surface(global.sur_fore,0,0,800,725,0,0,1);
	        global.temp_reforeground=0;
	    }         
	    __background_set( e__BG.Index, 1, global.foreground );   
    
	    with(Grass){instance_destroy()}
	    with (Wall){instance_destroy();}
    
    
	    /*Move all Objects*/
	    with (all){
	        x+=201;
	        y+=9;
	    }
	    x=0
	    y=0
	    tile_layer_shift(1000000,201,9)
    
	    part_system_clear(global.part_sys_a)
	    with (Blinker){instance_destroy()}
	    with (Blinker_Static){instance_destroy()}
	    with (Blocker_Diss){instance_destroy()}
	}



}
