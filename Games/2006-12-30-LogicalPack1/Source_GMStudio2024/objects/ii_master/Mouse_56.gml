if instance_number(ii_objectivers)=instance_number(ii_block){
with (ii_objectivers){
var koko;
koko=instance_place(x,y-380,ii_block)
if instance_exists(koko){
if koko.image_index=image_index{global.yus=1} else {global.yus=0;exit}
} else {global.yus=0;exit}
}
    if global.yus=1{
        sound_play(winz);
        ds_list_clear(global.list);
        if room!=ii_RLG{ii_scripto();}
        if room=ii_RLG{
            room_goto(cardmenu)
        } else {
            if room=ii_050{
                room_goto(endian)
            } else{
                global.level+=1;
                room_goto_next()
            }
        }
    }   
}

