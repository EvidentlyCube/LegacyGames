if global.editor<2{draw_me_ext()} else{draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_gray,image_alpha)}

if Master.inst=shmai{
draw_set_blend_mode(bm_add)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,0.2)
draw_set_blend_mode(bm_normal)
}
if bla=1{
if bla2=0{sound_stop(Snd_Finish);soundplay(Snd_Finish);bla2=1}
draw_sprite(S_Gut,0,x,y)} else {bla2=0}
