if global.fin=1{
if ds_list_find_value(global.lb_finish,global.leveled)=0{
ds_list_replace(global.lb_finish,global.leveled,1)
var blahx;
blahx=0
file_copy(working_directory+"/levels/base.txt",working_directory+"/levels/base2.txt")
file1=file_text_open_read(working_directory+"/levels/base2.txt")
file2=file_text_open_write(working_directory+"/levels/base.txt")
     while !file_text_eof(file1){
     texto=file_text_read_string(file1)
          if blahx=global.leveled{
          file_text_write_string(file2,texto+"x")
          } else {file_text_write_string(file2,texto)}
     file_text_readln(file1)
     file_text_writeln(file2)
     blahx+=1
     }
     file_text_close(file1)
     file_text_close(file2)
     file_delete(working_directory+"/levels/base2.txt")
}}



if global.lb_generated=0{
Levels_Base_Generate()}
global.lb_generated=1
curr=global.leveled
pos=0
now=0
aa=0
aaa=0
kufo=0
tumex=0
