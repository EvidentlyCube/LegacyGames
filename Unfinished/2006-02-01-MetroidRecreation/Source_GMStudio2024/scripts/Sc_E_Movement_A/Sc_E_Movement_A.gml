function Sc_E_Movement_A() {
	ex=ds_list_find_value(e_x,i)
	ey=ds_list_find_value(e_y,i)
	ix=sign(p_x-ex)                                            //In which X direction is plyer: ix= -1, 0 or 1
	iy=sign(p_y-ey)                                            //In which Y direction is plyer: iy= -1, 0 or 1
	mover_a=ds_grid_get(lev_e,ex+ix,ey+iy)
	mover_b=ds_grid_get(level,ex+ix,ey+iy)
	if p_x!=ex+ix or p_y!=ey+iy{                           //Tests if the approaching square isn't occupied by player
	    if mover_a=-1 && mover_b="."{
	        ds_grid_set(lev_e,ex,ey,-1)
	        ds_grid_set(lev_e,ex+ix,ey+iy,i)
	        ds_list_replace(e_x,i,ex+ix)
	        ds_list_replace(e_y,i,ey+iy)
	    } else {
	        mover_a=ds_grid_get(lev_e,ex,ey+iy)
	        mover_b=ds_grid_get(level,ex,ey+iy)
	        if mover_a=-1 && mover_b="."{
	            ds_grid_set(lev_e,ex,ey,-1)
	            ds_grid_set(lev_e,ex,ey+iy,i)
	            ds_list_replace(e_y,i,ey+iy)
	        } else {
	            mover_a=ds_grid_get(lev_e,ex+ix,ey)
	            mover_b=ds_grid_get(level,ex+ix,ey)
	            if mover_a=-1 && mover_b="."{
	                ds_grid_set(lev_e,ex,ey,-1)
	                ds_grid_set(lev_e,ex+ix,ey,i)
	                ds_list_replace(e_x,i,ex+ix)
	            }
	        }
	    }
	} else {
	    I_Msys_Add("Player Has been attacked")
	}
	 /* ATTACKING PLAYER */
	 /*endef=random(e_attack[i])
	 pldef=random(p_defence)
	 comp=endef-pldef
	 if comp>=0{
	 I_Part_A((e_x[i]+ix-1)*20+10,(e_y[i]+iy+3)*20+10)
	 damage=floor(random(e_powermax))+e_powermin-p_armour
	 if damage<1{damage=1}
	 I_Msys_Add('You are hit by Thorner for '+string(damage)+' damage.')
	 p_hp-=damage
	 }
	}



/* end Sc_E_Movement_A */
}
