a=1
SXMS2_MC_StopAllSongs();SXMS2_MC_PlaySong(1)

global.name=""
global.site=""
global.mess=""

window_set_cursor(cr_arrow)

sel=0
sent=0
global.result="Press ENTER to send score."
/*
if global.ide>0{
    global.name=string_copy(get_string("Please type your nick (30 Charaters):",""),0,30)
    global.site=string_copy(get_string("Please type your site link (64 characters, starting with http://):","http://"),0,64)
    global.mess=string_copy(get_string("Please type your message (120 characters):","http://"),0,120)
    global.site=string_replace_all(global.site,"&","^")
global.result="http://localhost/test/qualifier.php?a=add"
global.result+="&ip="+mplay_ipaddress()
global.result+="&id="+string(global.ide)
global.result+="&name="+global.name
global.result+="&site="+global.site
global.result+="&mess="+global.mess
global.result+="&kill="+string(global.kill)
global.result+="&score="+string(global.scr2)
global.result+="&realscore="+string(global.scr)
global.result+="&acc="+string(global.accper)
global.result+="&time="+string(global.time)
clipboard_set_text(global.result)
global.result=netread(global.result,100)
show_message(global.result)

}*/
/* */
/*  */
