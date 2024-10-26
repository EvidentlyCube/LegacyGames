function Sc_Player_Beam_Rearrange() {
	/*THIS SCRIPT ISN'T USED ANYMORE!!!!!*/
	   /* Player's Beam Rearranging */

	while ps_rearrange[0]>0{
	 ps_tot-=1
	 for (i=0;i<=ps_tot;i+=1){
	  if ps_is[i]!=1 && i<ps_tot{
	  if ps_is[i]=0{level[ps_x[i],ps_y[i]]=ps_flr[i]}
	                  ps_x[i]=ps_x[i+1]
	                  ps_y[i]=ps_y[i+1]
	                 ps_is[i]=ps_is[i+1]
	               ps_is[i+1]=2
	                ps_pwu[i]=ps_pwu[i+1]             
	                ps_pwd[i]=ps_pwd[i+1]         
	                ps_acc[i]=ps_acc[i+1]            
	                ps_spd[i]=ps_spd[i+1]           
	                ps_dir[i]=ps_dir[i+1]           
	                ps_gfx[i]=ps_gfx[i+1]             
	                ps_thr[i]=ps_thr[i+1]        
	                ps_typ[i]=ps_typ[i+1]            
	                ps_hit[i]=ps_hit[i+1]
	                ps_flr[i]=ps_flr[i+1]    
	   }
	  if ps_is[i]!=1 && i=ps_tot{ 
	  if ps_is[i]=0{level[ps_x[i],ps_y[i]]=ps_flr[i]}
	                  ps_x[i]=0
	                  ps_y[i]=0
	                 ps_is[i]=0
	               ps_is[i+1]=0
	                ps_pwu[i]=0             
	                ps_pwd[i]=0         
	                ps_acc[i]=0            
	                ps_spd[i]=0           
	                ps_dir[i]=0           
	                ps_gfx[i]=0             
	                ps_thr[i]=0        
	                ps_typ[i]=0            
	                ps_hit[i]=0
	                ps_flr[i]=""    
	   }
	 }
	 ps_rearrange[0]-=1
	}
	for (i=0;i<ps_tot;i+=1){
	if ps_is[i]=1{ps_flr[i]=level[ps_x[i],ps_y[i]];level[ps_x[i],ps_y[i]]="B"}
	}





}
