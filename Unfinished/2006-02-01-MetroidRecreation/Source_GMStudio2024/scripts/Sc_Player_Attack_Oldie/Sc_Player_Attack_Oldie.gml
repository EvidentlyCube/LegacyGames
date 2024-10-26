function Sc_Player_Attack_Oldie() {
	if attack=1{
	 for (i=0;i<e_tot;i+=1){ //Loop - ilosci wrogow typu A
	  if e_x[i]=p_x+p_movx && e_y[i]=p_y+p_movy{         //Sprawdzanie, czy na polu ataku stoi przeciwnik 
	  endef=random(e_defence[i])
	  pldef=random(p_attack)
	  comp=pldef-endef
	   if comp>=0{
	    damage=floor(random(w_powmax[0]))+w_powmin[0]-e_armour[i]
	    if damage<1{damage=1}
	    e_hp[i]-=damage
	    if e_hp[i]<1{e_is[i]=0;level[e_x[i],e_y[i]]=0;exit}
	   }
	  }
	 }
	}



}
