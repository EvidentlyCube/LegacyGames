function Sc_Player_Declare() {
	p_x=3           //Player X position
	p_y=23          //Player Y positiom
	p_dir=0         //Player Direction
	p_movx=1        //X direction of player
	p_movy=0        //Y direction of player
	p_hp=15         //Current LIFE
	p_hpmax=15      //Maximal LIFE
	p_mis=0         //Current Missiles
	p_mismax=0      //Maximal Missiles
	p_smis=0        //Current Super Missiles
	p_smismax=0     //Maximal Super Missiles
	p_sbmb=0        //Current Super Bombs
	p_sbmbmax=0     //Maximal Super Bombs
	p_armour=1      //Damage Reductor
	p_attack=5      //Chance to hit
	p_defence=5     //Chance to dodge
	p_move=-1       //Which "Movement skill type" will be used
	p_atk=-1        //Which "Attack skill type" will be used
	p_datk=26
	p_dmov=26
	p_stat=0        //Where is player (0=Ground; 0<Air;)
	p_mode=0        //0=Stands; 1=Ball mode ;2=Spider Ball mode

	/*SKILLSIGNS*/
	/*Skills are put in one array:
	-Do you have that skill? (p_shave=0 or 1 -> No or Yes)
	-You can use that skill (p_shave=>2)
	At the end of each turn it is calculated which skills you can use.*/
	p_shave[00]=0 //Missile
	p_shave[01]=0 //Super Missile
	p_shave[02]=0 //Super Bomb
	p_shave[03]=0 //Charge Missile
	p_shave[04]=0 //Stand Up
	p_shave[05]=0 //Morph into Ball
	p_shave[06]=0 //Morph into Spider Ball
	p_shave[07]=2 //Jump
	p_shave[08]=1 //Wall Jump
	p_shave[09]=1 //Land
	p_shave[10]=0 //Place Bomb
	p_shave[11]=0 //Charge Beam
	p_shave[12]=2 //Swing Sword
	p_shave[13]=2 //Shot with Weapon
	p_shave[14]=2 //Double Attack
	p_shave[15]=2 //Moving
	p_shave[16]=2 //Rotating
	p_jumppow=3

	/*WEAPONRY*/
	/*Every weapon is one handed. You can hold one weapon per hand.Weapons can have different range. THe weapon
	can go through objects or not [Throughness]. Blablabla...
	It is possible to use two weapons at once*/
	w_type[0]=0 //0=Beam 1=Melee
	w_range[0]=0 /*For melee:
	0.X.  1XXX  2XXX  3XXX
	 .@.   .@.   X@X   X@X
	 ...   ...   ...   X.X
	For ranged:
	0.|.  1|||
	 .@.   .@.
	 ...   ...*/
	w_accuracy[0]=100 //Chance to hit
	w_wide[0]=0  //I don't know?
	w_speed[0]=3 // How many squares it will go per turn
	w_powmin[0]=1 //Maximal Damage
	w_powmax[0]=5 //Minimal Damage
	w_charge[0]=0 //Charge level
	w_through[0]=0 //Throughmess 0-Don't get through 1-Goes through what it can 2-Goes through everything
	w_mode[0]=3 //Beam Type 3-Normal, 4-Blazer, 5-Ice, 6-Plasma, 7-Metroidus

	w_type[1]=1
	w_range[1]=0
	w_accuracy[1]=100
	w_speed[1]=0
	w_powmin[1]=1
	w_powmax[1]=1

	/* Sword Variables */
	sw_type=0 //Sword attack type 0-Cut, 1-Stab, 2-Chop (From above the head)
	sw_dir=0 //Sword's direction
	sw_turn=1 //Next attack will be 1-Clockwise -1-Counterclockwise
	sw_range=1 /*Attack's range (Only for cut):
	0:\X/ 1:XXX 2:XXX 3:XXX
	  .P.   -P-   XPX   XPX
	  ...   ...   /.\   X|X
	*/
	sw_power=0 //0-10 - An attack power
	sw_x=0 //Sword's X position
	sw_y=0 //Sword's Y position



}
