function I_Sword_Attack(argument0, argument1) {
	for (i=0;i<e_tot;i+=1){ //Loop - ilosci wrogow typu A
	 if e_x[i]=argument0 && e_y[i]=argument1{         //Sprawdzanie, czy na polu ataku stoi przeciwnik 
	 var endef,pldef,comp,damage;
	 endef=random(e_defence[i])
	 pldef=random(p_attack/(100/w_accuracy[1]))
	 comp=pldef-endef
	  if comp>=0{
	   I_Part_A((argument0-1)*20+10,(argument1+3)*20+10)
	   damage=floor(random(w_powmax[0]-w_powmin[0]))+w_powmin[0]-e_armour[i]
	   if damage<1{damage=1}
	   e_hp[i]-=damage
	   I_Msys_Add("You cut Thorner for "+string(damage)+" damage.")
	   if e_hp[i]<1{e_is[i]=0;I_Msys_Add("You Sliced Thorner.");exit}
	  }
	 }
	}



}
