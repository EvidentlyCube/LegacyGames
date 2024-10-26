for(y=0;y<29;y+=1){
    for(x=0;x<32;x+=1){
        koko=y*32+x+928
        file_bin_seek(global.file,koko)
        file_bin_write_byte(global.file,ds_list_find_value(list_o,koko-928))
        file_bin_seek(global.file,koko+928+928+928+928)
        file_bin_write_byte(global.file,ds_list_find_value(list_c,koko-928))
    }
}

switch(show_message_ext("What now?","End","Background","")){
case(2):execute_program("H:/KIIB.exe","",0);break;
}


file_bin_close(global.file)
