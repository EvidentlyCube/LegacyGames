file=get_save_filename("Kulkis I Special|*.kis",working_directory)
fifi=file_text_open_write(file)
file_text_write_string(fifi,"fdsf")
file_text_close(fifi)
file=file_bin_open(file,2)
file_bin_rewrite(file)
while show_question("Add another line of text?"){
    file_bin_write_byte(file,show_question("Shall this words be on the Down side of the screen?"))
    file_bin_write_byte(file,get_integer("Type the face number:",0))
    text=get_string("Type the speaker name:","")
    while (string_length(text)>0){
        file_bin_write_byte(file,ord(text)+69)
        text=string_delete(text,1,1)
    }
    file_bin_write_byte(file,0)
    text=get_string("Type the text:","")
    while (string_length(text)>0){
        file_bin_write_byte(file,ord(text)+69)
        text=string_delete(text,1,1)
    }
    file_bin_write_byte(file,0)
}

file_bin_close(file)
game_end()