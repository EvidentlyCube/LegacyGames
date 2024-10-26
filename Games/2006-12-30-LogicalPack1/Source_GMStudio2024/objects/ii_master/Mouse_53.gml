if mouse_y<380 && mouse_y>0 && mouse_x>0 && mouse_x<400{
if !place_meeting(floor(mouse_x/20)*20,floor(mouse_y/20)*20,ii_block){
rympzy()
global.ii[global.iic]=instance_create(floor(mouse_x/20)*20,floor(mouse_y/20)*20,ii_block)
global.iic+=1
}}
