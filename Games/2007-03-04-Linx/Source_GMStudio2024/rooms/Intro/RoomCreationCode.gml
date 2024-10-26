// @FIXME - Netread is not supported
//global.srv_dat[0]=netread("http://www.mauft.com/gamedata/linx_1_server.txt",100)
global.srv_dat[0]=""
global.srv_dat[1]=""
global.srv_dat[2]=""
global.srv_dat[3]=""
global.srv_dat[4]=""
blap=1
for (i=1;i<string_length(global.srv_dat);i+=1){
    if string_char_at(global.srv_dat[0],i)<>"#"{
        global.srv_dat[blap]+=string_char_at(global.srv_dat[0],i)
    } else {
        blap+=1
        if blap=5{
            exit
        }
    }
}