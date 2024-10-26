function Sc_E_Declare() {
	var ex,ey;
	ex[0]=19;ey[0]=23;
	ex[1]=29;ey[1]=21;
	ex[2]=29;ey[2]=23;
	ex[3]=6;ey[3]=2;
	ex[4]=3;ey[4]=2;
	ex[5]=4;ey[5]=2;
	ex[6]=5;ey[6]=2;
	ex[7]=32;ey[7]=18;
	ex[8]=26;ey[8]=18;
	ex[9]=27;ey[9]=18;
	ex[10]=28;ey[10]=18;
	ex[11]=29;ey[11]=18;
	ex[12]=30;ey[12]=18;
	ex[13]=31;ey[13]=18;
	ex[14]=8;ey[14]=21;
	ex[15]=9;ey[15]=21;
	ex[16]=31;ey[16]=2;
	ex[17]=10;ey[17]=13;
	ex[18]=3;ey[18]=6;
	ex[19]=30;ey[19]=9;
	ex[20]=30;ey[20]=11;

	e_x=ds_list_create()
	e_y=ds_list_create()
	e_hp=ds_list_create()
	e_hpmax=ds_list_create()
	e_move=ds_list_create()
	e_speed=ds_list_create()
	e_tomov=ds_list_create()
	e_powermin=ds_list_create()
	e_powermax=ds_list_create()
	e_defence=ds_list_create()
	e_attack=ds_list_create()
	e_armour=ds_list_create()
	e_cut=ds_list_create()



	e_tot=20 //Number of enemies
	for (i=0;i<e_tot;i+=1){//Loop which creates indicated number of enemies
	 ds_list_add(e_x,ex[i]) //Sets current enemy X position to value previously indicated
	 ds_list_add(e_y,ey[i]) //Sets current enemy Y position to value previously indicated
	 ds_list_add(e_move,Sc_E_Movement_A)
	// e_x[i]=3+i //Sets enemy X position to form a horizontal line
	// e_y[i]=5   //Sets enemy Y position
	 /*while level[e_x[i],e_y[i]]!='.'{   //Loop creating indicated number of enemies in random positions
	 e_x[i]=floor(random(31))+2           //Sets enemy X position to random value
	 e_y[i]=floor(random(22))+2}*/        //Sets enemy y position to random value
	 ds_grid_set(lev_e,ex[i],ey[i],i)
	}
	/*
	Notka Odnosnie wartosci "speed" i "tomov":
	Kiedy jest zdarzenie ruchu, od wartosci "tomov" odejmuje sie "speed".
	kiedy "tomov" jest mniejsze od zera to wykonuje sie jeden ruch a do "tomov"
	dodaje sie jeden. Jezeli "tomov" jest nadal mniejsze od zera, nastepuje ponowny
	ruch i dodanie do "tomov" jeden, az do chwili gdy wyniesie on wartosc wyzsza od zera


/* end Sc_E_Declare */
}
