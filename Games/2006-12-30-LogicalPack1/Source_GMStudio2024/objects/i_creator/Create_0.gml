global.maxclick+=1.5
if !place_meeting(x,y,i_toggler){instance_create(x,y,i_toggler)} else 
{with (instance_place(x,y,i_toggler)){rox=1;instance_destroy()}}
if !place_meeting(x+20,y,i_toggler){instance_create(x+20,y,i_toggler)} else 
{with (instance_place(x+20,y,i_toggler)){rox=1;instance_destroy()}}
if !place_meeting(x,y+20,i_toggler){instance_create(x,y+20,i_toggler)} else 
{with (instance_place(x,y+20,i_toggler)){rox=1;instance_destroy()}}
if !place_meeting(x-20,y,i_toggler){instance_create(x-20,y,i_toggler)} else 
{with (instance_place(x-20,y,i_toggler)){rox=1;instance_destroy()}}
if !place_meeting(x,y-20,i_toggler){instance_create(x,y-20,i_toggler)} else 
{with (instance_place(x,y-20,i_toggler)){rox=1;instance_destroy()}}

with (i_toggler) {if place_meeting(x,y,i_wall){instance_destroy()}}
if ds_grid_get(global.grid,floor(x/20),floor(y/20))=0{ds_grid_set(global.grid,floor(x/20),floor(y/20),1)} else {ds_grid_set(global.grid,floor(x/20),floor(y/20),0)}
instance_destroy()
