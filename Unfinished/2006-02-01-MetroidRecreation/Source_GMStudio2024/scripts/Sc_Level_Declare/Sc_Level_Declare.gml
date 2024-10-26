function Sc_Level_Declare() {
	turns=0
	start=0 //Variable responsible for starting next turn
	a=0     //Misc use variable
	turn=0  //Variable responsible for everything's movement
	//       0000000000111111111122222222223333  Helping variables                                          
	//       0123456789012345678901234567890123  Helping Variables                    
	level=ds_grid_create(34,26)                
	lev_e=ds_grid_create(34,26)
	lev_b=ds_grid_create(34,26)
	lev_g=ds_grid_create(34,26)
	lev[00]="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" //Test level's ASCII string representation
	lev[01]="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
	lev[02]="xx........o........o............xx"
	lev[03]="xx...................ooo.......xxx"
	lev[04]="xx..............................xx"
	lev[05]="xx.........................x....xx"
	lev[06]="xx.x............x..........x....xx"
	lev[07]="xx..............................xx"
	lev[08]="xx..........................ooo.xx"
	lev[09]="xx..........................oo..xx"
	lev[10]="xx......o..................oo...xx"
	lev[11]="xx...x....................oo....xx"
	lev[12]="xx.....o...................oo..xxx"
	lev[13]="xx..x...........................xx"
	lev[14]="xx........................o...x.xx"
	lev[15]="xx........................o.....xx"
	lev[16]="xx..........................oo..xx"
	lev[17]="xx...........................oooxx"
	lev[18]="xx..............................xx"
	lev[19]="xx..........................xxxxxx"
	lev[20]="xx.......................o.o....xx"
	lev[21]="xx..............................xx"
	lev[22]="xx.......................xxxx...xx"
	lev[23]="xx..............................xx"
	lev[24]="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
	lev[25]="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" //Test level's ASCII string presentation
	for (b=0;b<26;a+=1){            //Loop which initializes a level array declaring
	if a>34{a=0;b+=1}               //Tests if the loop has finished the current row, and moves to the next one
	if b=26{exit}                   //Tests if the loop has finished the last row, and if yes, then ends the script
	/* This line takes a one character from the ASCII String Presentation, and converts it into two dimensional array*/
	ds_grid_set(level,a,b,string_char_at(lev[b],a))
	ds_grid_set(lev_e,a,b,-1)                  //Creates an empty Enemy array                    
	ds_grid_set(lev_b,a,b,-1)                  //Creates an empty Bullet array
	}



}
