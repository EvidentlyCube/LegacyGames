function Sc_Player_Beam_Move() {
	var k,bt_x,bt_y,bt_dir,mover_a,mover_b,ver;
	for (i=0;i<b_tot;i+=1){
	    bt_x=ds_list_find_value(b_x,i)
	    bt_y=ds_list_find_value(b_y,i)
	    bt_dir=ds_list_find_value(b_dir,i)
	    ver=1
	    repeat(ds_list_find_value(b_spd,i)){
	        bt_x+=c_movx[bt_dir]
	        bt_y+=c_movy[bt_dir]
	        mover_a=ds_grid_get(level,bt_x,bt_y)
	        mover_b=ds_grid_get(lev_e,bt_x,bt_y)
	        if mover_b!=-1{
	            I_Beam_Hit(mover_b)
	            I_Part_A(bt_x,bt_y)
	            I_Beam_Destroy(i)
	            i-=1
	            ver=0
	            break
	        } else {
	            if mover_a!="." && mover_a!="," && mover_a!="o" && mover_a!="O"{
	                I_Part_A(bt_x,bt_y)
	                I_Beam_Destroy(i)
	                i-=1
	                ver=0
	                break
	            }
	        }
	    }
	    if ver=1{
	        ds_list_replace(b_x,i,bt_x)
	        ds_list_replace(b_y,i,bt_y)
	    }
	}



}
