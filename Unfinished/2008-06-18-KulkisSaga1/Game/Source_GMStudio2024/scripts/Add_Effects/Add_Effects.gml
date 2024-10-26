function Add_Effects() {
	/*
	Adding effects from tiles in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Add_Effects()
	*/

	surface_set_target(global.sur_wall_back)
	for(a=0;a<800;a+=25){
	    for(b=0;b<725;b+=25){
	        var blends;
	        blends[0]=bm_normal;
	        blends[1]=bm_add;
	        blends[2]="custom"
	        blends[3]=bm_max;
	        draw_set_alpha(0.1)
	        for(dypth=3;dypth>-1;dypth-=1){
				if dypth = 2 {
					draw_set_blend_mode_ext(bm_dest_color,bm_zero);
				} else {
					draw_set_blend_mode(blends[dypth]);
				}

	            if dypth=0 {
					draw_set_alpha(1)
				}
	            tile=tile_layer_find(dypth*-1-1000,a,b)
	            if tile_exists(tile){
					Insert_Tile(tile)
				}
	        }
	    }
	}
	for(dypth=0;dypth<4;dypth+=1){
	    tile_layer_delete(dypth*-1-1000)
	}
	draw_set_alpha(1)
	draw_set_blend_mode(bm_normal)
	surface_reset_target()



}
