file_bin_seek(global.save,10000+floor((x+201)/25)+global.level*1000+floor((y+9)/25)*32)
if file_bin_read_byte(global.save)=0{instance_destroy();exit}
