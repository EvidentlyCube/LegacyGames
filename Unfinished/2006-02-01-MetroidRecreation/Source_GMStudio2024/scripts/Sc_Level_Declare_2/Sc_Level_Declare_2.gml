function Sc_Level_Declare_2() {
	a=0
	for (b=0;b<26;a+=1){            //Loop inicjuj�cy array grafiki etapu
	if a>34{a=0;b+=1}
	if b=26{exit}
	if string_char_at(lev[b],a)="." {ds_grid_set(lev_g,a,b,0)}
	if string_char_at(lev[b],a)="x" {ds_grid_set(lev_g,a,b,1)}
	if string_char_at(lev[b],a)="o" {ds_grid_set(lev_g,a,b,2)}

	//glevel[a,b]=real(string_char_at(lev[b],a)) Array grafiki Etapu
	}



}
