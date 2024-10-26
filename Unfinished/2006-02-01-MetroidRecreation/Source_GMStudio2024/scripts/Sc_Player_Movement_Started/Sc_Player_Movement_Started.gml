function Sc_Player_Movement_Started() {
	/*MOving - only available on floor*/
	if p_stat=0{
	 if p_move>=0 && p_move<8{
	  if I_Pl_Free(c_movx[p_move],c_movy[p_move])=1{
	   I_Effect_B(p_x,p_y,c_movx[p_move]*2,c_movy[p_move]*2,10,sprite0,p_dir)
	   p_x+=c_movx[p_move];p_y+=c_movy[p_move]
	  }
	 }
	}

	/*Standing in one place*/
	if p_move=8{}

	/*Rotating CT*/
	if p_move=9{p_dir+=1}

	/*Rotating Counter CT*/
	if p_move=10{p_dir-=1}

	/*Rotation ascertainer - if direction gets too big it loops it*/
	p_dir=I_Var_Loop(p_dir,7)

	/*Landing*/
	if p_move=16{p_stat=0; I_After_Jump_Skills()}

	/* Wall Jumping */
	if p_move=15{Sc_Player_Wall_Jump()}

	/*Jumping*/
	/*Tests whether you are in ball form or not - it is impossible to jump while being in Spider Ball form*/
	if p_mode=0 && p_move=14{Sc_Player_Jump_Stand()}
	if p_mode=1 && p_move=14{Sc_Player_Jump_Ball()}
	/* ATTENTION! Jumping slides! I.e. When you can't move diagonally you will move orthogonally - 
	the vertical movement has bigger Priority than the horizontal one*/
	if p_stat>0{
	 if I_Pl_Free_Jump(c_movx[p_dir],c_movy[p_dir])=1{
	  I_Effect_B(p_x,p_y,c_movx[p_dir]*2,c_movy[p_dir]*2,10,sprite17,p_dir)
	  p_x+=c_movx[p_dir];p_y+=c_movy[p_dir]
	 } else {
	  if I_Pl_Free_Jump(0,c_movy[p_dir])=1{
	   I_Effect_B(p_x,p_y,0,c_movy[p_dir]*2,10,sprite17,p_dir)
	   p_y+=c_movy[p_dir]
	  } else {
	   if I_Pl_Free_Jump(c_movx[p_dir],0)=1{
	    I_Effect_B(p_x,p_y,c_movx[p_dir]*2,0,10,sprite17,p_dir)
	    p_x+=c_movx[p_dir]
	   }
	  }
	 }
	}

	/* Sword Movement */
	I_Sword_Set_Pos()



}
