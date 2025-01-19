/*
All types:
0 - Infinite push button
1 - disposable button

0 - Create wall
1 - Destroy wall
2 - Toogle wall
3 - Create crate/barrel/bomb
*/
if instance_exists(Body){
if buttyp<2{
if x=Body.x-10 && y=Body.y-10{
 if pressed=0{
for(i=1;i<numb;i+=1){
 if type[i]=0{
  if !place_meeting(ix[i],iy[i],Blockers){
	  var create=instance_create(ix[i],iy[i],Blockers);
	  create.image_speed = 0
	  create.image_index=add[i];
	  showparta(ix[i],iy[i]);
	  sonpla(1)}
 }
 if type[i]=1{
  koko=instance_position(ix[i],iy[i],Blockers)
  if instance_exists(koko) {
	  with (koko) {
		  instance_destroy()
		} showparta(ix[i],iy[i]);sonpla(1)}
 }
 if type[i]=2{
  koko=instance_position(ix[i],iy[i],Blockers)
  if instance_exists(koko) {
	  with (koko) {
		  instance_destroy()
  	  } 
	  showparta(ix[i],iy[i]);
	  sonpla(1)
	} else {
		if !place_meeting(ix[i],iy[i],Blockers){
			var create=instance_create(ix[i],iy[i],Blockers);
			create.image_single=add[i];
			create.image_speed=0
			showparta(ix[i],iy[i]);
			sonpla(1)
		}
	} 
 }
 if type[i]=3{
  if place_free(ix[i],iy[i]){
   showparta(ix[i],iy[i])
   if add[i]=0{instance_create(ix[i]+10,iy[i]+10,Crate);sonpla(1)} 
   if add[i]=1{instance_create(ix[i]+10,iy[i]+10,StellCrate);sonpla(1)} 
   if add[i]=2{instance_create(ix[i]+10,iy[i]+10,Barrel);sonpla(1)} 
   if add[i]=3{instance_create(ix[i],iy[i],BombBonus);sonpla(1)} 
  }
 }
}
pressed=1
if buttyp=1{buttyp=2;pressed=1}
}}else {pressed=0}
}}
/* */
/*  */
