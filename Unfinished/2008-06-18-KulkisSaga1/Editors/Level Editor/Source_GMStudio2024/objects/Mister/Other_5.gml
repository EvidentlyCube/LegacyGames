for(y=0;y<29;y+=1){
    for(x=0;x<32;x+=1){
        koko=y*32+x
        file_bin_seek(global.file,koko)
        file_bin_write_byte(global.file,ds_list_find_value(list_o,koko))
        file_bin_seek(global.file,koko+928+928+928)
        file_bin_write_byte(global.file,ds_list_find_value(list_a,koko))
        file_bin_seek(global.file,koko+928+928+928+928)
        file_bin_write_byte(global.file,ds_list_find_value(list_b,koko))
        file_bin_seek(global.file,koko+928+928+928+928+928)
        file_bin_write_byte(global.file,ds_list_find_value(list_c,koko))
    }
}


file_bin_close(global.file)
