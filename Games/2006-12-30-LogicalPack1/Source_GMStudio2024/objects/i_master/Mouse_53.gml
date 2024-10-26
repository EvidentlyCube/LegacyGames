if instance_number(i_toggler)>0 && !place_meeting(floor(mouse_x/20)*20,floor(mouse_y/20)*20,i_wall){
global.click+=1
blimy()
if !place_meeting(floor(mouse_x/20)*20,floor(mouse_y/20)*20,i_toggler){instance_create(floor(mouse_x/20)*20,floor(mouse_y/20)*20,i_toggler)} else 
{with (instance_place(floor(mouse_x/20)*20,floor(mouse_y/20)*20,i_toggler)){instance_destroy()}}
if !place_meeting(floor(mouse_x/20)*20+20,floor(mouse_y/20)*20,i_toggler){instance_create(floor(mouse_x/20)*20+20,floor(mouse_y/20)*20,i_toggler)} else 
{with (instance_place(floor(mouse_x/20)*20+20,floor(mouse_y/20)*20,i_toggler)){instance_destroy()}}
if !place_meeting(floor(mouse_x/20)*20,floor(mouse_y/20)*20+20,i_toggler){instance_create(floor(mouse_x/20)*20,floor(mouse_y/20)*20+20,i_toggler)} else 
{with (instance_place(floor(mouse_x/20)*20,floor(mouse_y/20)*20+20,i_toggler)){instance_destroy()}}
if !place_meeting(floor(mouse_x/20)*20-20,floor(mouse_y/20)*20,i_toggler){instance_create(floor(mouse_x/20)*20-20,floor(mouse_y/20)*20,i_toggler)} else 
{with (instance_place(floor(mouse_x/20)*20-20,floor(mouse_y/20)*20,i_toggler)){instance_destroy()}}
if !place_meeting(floor(mouse_x/20)*20,floor(mouse_y/20)*20-20,i_toggler){instance_create(floor(mouse_x/20)*20,floor(mouse_y/20)*20-20,i_toggler)} else 
{with (instance_place(floor(mouse_x/20)*20,floor(mouse_y/20)*20-20,i_toggler)){instance_destroy()}}
}
if ds_grid_get(global.grid,floor(mouse_x/20),floor(mouse_y/20))=0{ds_grid_set(global.grid,floor(mouse_x/20),floor(mouse_y/20),1)} else {ds_grid_set(global.grid,floor(mouse_x/20),floor(mouse_y/20),0)}

with (i_toggler) {if place_meeting(x,y,i_wall){instance_destroy()}}
if !keyboard_check(vk_f11){b=0}
