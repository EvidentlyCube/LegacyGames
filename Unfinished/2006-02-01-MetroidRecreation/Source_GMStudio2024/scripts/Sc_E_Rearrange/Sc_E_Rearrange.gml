function Sc_E_Rearrange() {
	/*THIS SCRIPT ISN'T USED ANYMORE!!!!!*/
	   /* Enemies Rearranging */

	while e_rearrange[0]>0{
	 e_tot-=1
	 for (i=0;i<=e_tot;i+=1){
	  if e_is[i]!=1 && i<e_tot{
	    if e_is[i]=0{level[e_x[i],e_y[i]]=e_floor[i]}
	                  e_x[i]=e_x[i+1]
	                  e_y[i]=e_y[i+1]
	                 e_is[i]=e_is[i+1]
	               e_is[i+1]=2
	                 e_hp[i]=e_hp[i+1]             
	              e_hpmax[i]=e_hpmax[i+1]         
	               e_move[i]=e_move[i+1]            
	              e_speed[i]=e_speed[i+1]           
	              e_tomov[i]=e_tomov[i+1]           
	           e_powermin[i]=e_powermin[i+1]             
	           e_powermax[i]=e_powermax[i+1]        
	            e_defence[i]=e_defence[i+1]            
	             e_attack[i]=e_attack[i+1]       
	             e_armour[i]=e_armour[i+1]      
	              e_floor[i]=e_floor[i+1]
	                e_cut[i]=e_cut[i+1]     
	   }
	  if e_is[i]!=1 && i=e_tot{ 
	    if e_is[i]=0{level[e_x[i],e_y[i]]=e_floor[i]}
	                  e_x[i]=0
	                  e_y[i]=0
	                 e_is[i]=0
	               e_is[i+1]=0
	                 e_hp[i]=0             
	              e_hpmax[i]=0         
	               e_move[i]=0            
	              e_speed[i]=0           
	              e_tomov[i]=0          
	           e_powermin[i]=0             
	           e_powermax[i]=0        
	            e_defence[i]=0            
	             e_attack[i]=0       
	             e_armour[i]=0      
	              e_floor[i]=""
	                e_cut[i]=""
	   }
	 }
	 e_rearrange[0]-=1
	}




}
