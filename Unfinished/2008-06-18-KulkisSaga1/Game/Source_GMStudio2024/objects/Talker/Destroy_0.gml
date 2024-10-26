with (Player_Stop){instance_change(Player,0)}
__background_set( e__BG.Visible, 1, 1 )

sprite_delete(s_talka)
sprite_delete(s_talkb)
sprite_delete(s_arr)

var belu;
belu=0;
repeat(amount){
    if sprite_exists(face[belu]){sprite_delete(face[belu])}
    belu+=1
}
