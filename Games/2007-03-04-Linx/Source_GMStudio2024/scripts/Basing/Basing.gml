function Basing() {
	global.grid=mp_grid_create(112,12,14,12,48,48)
	mp_grid_add_rectangle(global.grid,0,0,800,600)

	if Master.num[shmay]>1{

	with (object_index){mp_grid_clear_cell(global.grid,floor((x-96)/48),floor((y)/48))}
	with (shmai){mp_grid_clear_cell(global.grid,floor((x-96)/48),floor((y)/48))}

	bla=1

	var i;

	   for (i=0;i<Master.num[shmay]-1;i+=1){
	   if mp_grid_path(global.grid,A_Path,Master.ix[shmay,i],Master.iy[shmay,i],Master.ix[shmay,i+1],Master.iy[shmay,i+1],0)=0{global.good=0;bla=0}
	   }
	}

	if Master.num[shmay]=1{
	   with (shmai){mp_grid_clear_cell(global.grid,floor((x-96)/48),floor((y)/48))}
	   var u,d,l,r;
	   if place_meeting(x-48,y,shmai){
	   l=1
	   } else {l=0}
	   if place_meeting(x+48,y,shmai){
	   r=1
	   } else {r=0}
	   if place_meeting(x,y-48,shmai){
	   u=1
	   } else {u=0}
	   if place_meeting(x,y+48,shmai){
	   d=1
	   } else {d=0}

	if global.good=1{global.good=0} else {global.good=2}
	bla=0
	if r+d+u+l<2{global.good=0;bla=0}
	if r=1 && d=1{
	if mp_grid_path(global.grid,A_Path,x+48+30,y+30,x+30,y+48+30,0)=1{if global.good=0{global.good=1};bla=1}
	}
	if r=1 && l=1{
	if mp_grid_path(global.grid,A_Path,x+48+30,y+30,x-48+30,y+30,0)=1{if global.good=0{global.good=1};bla=1}
	}
	if r=1 && u=1{
	if mp_grid_path(global.grid,A_Path,x+48+30,y+30,x+30,y-48+30,0)=1{if global.good=0{global.good=1};bla=1}
	}
	if d=1 && l=1{
	if mp_grid_path(global.grid,A_Path,x+30,y+48+30,x-48+30,y+30,0)=1{if global.good=0{global.good=1};bla=1}
	}
	if d=1 && u=1{
	if mp_grid_path(global.grid,A_Path,x+30,y+48+30,x+30,y-48+30,0)=1{if global.good=0{global.good=1};bla=1}
	}
	if l=1 && u=1{
	if mp_grid_path(global.grid,A_Path,x-48+30,y+30,x+30,y-48+30,0)=1{if global.good=0{global.good=1};bla=1}
	}

	if global.good=2{global.good=0}

	}

	mp_grid_destroy(global.grid)



}
