function I_Beam_Destroy(argument0) {
	ds_list_delete(b_x,argument0)
	ds_list_delete(b_y,argument0)
	ds_list_delete(b_spd,argument0)
	ds_list_delete(b_dir,argument0)
	b_tot-=1



}
