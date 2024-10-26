function Levels_Import(argument0) {
	file1=file_text_open_read(argument0)
	numa=0 //Number of Lines
	numb=0 //Number of levels added
	numc=0 //number of identical levels
	while !file_text_eof(file1){
	      numa+=1
	      text1=file_text_read_string(file1)
	      if string_length(text1)=261{
	         file2=file_text_open_read(working_directory+"/levels/base.txt")
	         fine=1
	         while !file_text_eof(file2){
	               text2=file_text_read_string(file2)
	               if string_copy(text1,94,168)=string_copy(text2,94,168){fine=0;break}
	               file_text_readln(file2)
	         }
	         file_text_close(file2)
	         if fine=1{
	         numb+=1
	         file2=file_text_open_append(working_directory+"/levels/base.txt")
	         file_text_write_string(file2,text1)
	         file_text_writeln(file2)
	         file_text_close(file2)
	         } else {numc+=1}
	      } 
	      file_text_readln(file1)
	}
	file_text_close(file1)



}
