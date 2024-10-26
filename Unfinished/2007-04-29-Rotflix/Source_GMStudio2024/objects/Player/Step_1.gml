
if keyboard_check_pressed(global.key_up)            {movx=0 ;movy=-1;global.turn=1}
if keyboard_check_pressed(global.key_upright)       {movx=1 ;movy=-1;global.turn=1}
if keyboard_check_pressed(global.key_right)         {movx=1 ;movy=0 ;global.turn=1}
if keyboard_check_pressed(global.key_downright)     {movx=1 ;movy=1 ;global.turn=1}
if keyboard_check_pressed(global.key_down)          {movx=0 ;movy=1 ;global.turn=1}
if keyboard_check_pressed(global.key_downleft)      {movx=-1;movy=1 ;global.turn=1}
if keyboard_check_pressed(global.key_left)          {movx=-1;movy=0 ;global.turn=1}
if keyboard_check_pressed(global.key_upleft)        {movx=-1;movy=-1;global.turn=1}
if keyboard_check_pressed(global.key_wait)          {movx=0 ;movy=0 ;global.turn=1}

if global.turn=1{
	if !place_meeting(x+movx*20,y+movy*20,Solid) 
		or Crating(movx,movy) 
	{
		if Arrowing(movx,movy) {
			oldx=x;
			oldy=y;
			draw=20;
			x+=movx*20;
			y+=movy*20;
			movx=0;
			movy=0
		}
	} else {
		Orbing(movx,movy)
	}
}
if global.turn=1{
 if instance_exists(Enemyfive){
  wi=room_width/20
  hi=room_height/20
  d=0
  for (c=0;d<=hi;c+=1){
   if c>wi{c=0;d+=1}
   /*if d<=hi{                                                              //Slower Algoritm
   if place_meeting(c*20,d*20,Solid){lev[c,d]=-1} else {lev[c,d]=0}         //Slower Algoritm
   }      */                                                              //Slower Algoritm
  lev[c,d]=0
  }
  with (Solid) {Player.lev[x/20,y/20]=-1}
 
  lev[x/20,y/20]=1
  tota=1
  totb=0
  cura[0,0]=x/20
  cura[0,1]=y/20
  count=1
  while tota>0 or totb>0{
   count+=1
    for (a=0;a<tota;a+=1){
     LevingA(cura[a,0]+1,cura[a,1],count)
     LevingA(cura[a,0]+1,cura[a,1]+1,count)
     LevingA(cura[a,0],cura[a,1]+1,count)
     LevingA(cura[a,0]-1,cura[a,1]+1,count)
     LevingA(cura[a,0]-1,cura[a,1],count)
     LevingA(cura[a,0]-1,cura[a,1]-1,count)
     LevingA(cura[a,0],cura[a,1]-1,count)
     LevingA(cura[a,0]+1,cura[a,1]-1,count)
     /*repeat (8){
      LevingA(cura[a,0]+global.con_movx[b],cura[a,1]+global.con_movy[b],count) 
      b+=1
     }*/
    }
    tota=0

   count+=1
    for (a=0;a<totb;a+=1){
     LevingB(curb[a,0]+1,curb[a,1],count)
     LevingB(curb[a,0]+1,curb[a,1]+1,count)
     LevingB(curb[a,0],curb[a,1]+1,count)
     LevingB(curb[a,0]-1,curb[a,1]+1,count)
     LevingB(curb[a,0]-1,curb[a,1],count)
     LevingB(curb[a,0]-1,curb[a,1]-1,count)
     LevingB(curb[a,0],curb[a,1]-1,count)
     LevingB(curb[a,0]+1,curb[a,1]-1,count)
     /*repeat (8){
      LevingB(curb[a,0]+global.con_movx[b],curb[a,1]+global.con_movy[b],count)
      b+=1
     }*/
    }
    totb=0
   
  }
 }
}
/* */
/*  */
