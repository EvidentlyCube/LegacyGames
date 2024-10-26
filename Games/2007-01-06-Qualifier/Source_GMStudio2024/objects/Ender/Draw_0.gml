draw_set_halign(fa_center)
draw_set_font(font1)
draw_text(512,130,string_hash_to_newline("You have lost! Your scoring is:#Killed Enemies:       "+string(global.kill)+"#Stayed alive for:       "+string(global.time)+" seconds#Your accuracy was:       "+string(global.accper)+"%#Your overall score is:       "+string(global.scr)+" points"))
draw_text(512,300,string_hash_to_newline("Type the details to send your score to our online Hiscore table:"))

draw_text(512,330,string_hash_to_newline("Nick (max 30 Characters):"))
draw_rectangle(100,360,924,380,true)
draw_text(512,390,string_hash_to_newline("Site Address starting with http:// (max 64 Characters):"))
draw_rectangle(100,420,924,440,true)
draw_text(512,450,string_hash_to_newline("Short message (Max 60 Characters):"))
draw_rectangle(100,480,924,500,true)
draw_text(512,360,string_hash_to_newline(global.name))
draw_text(512,420,string_hash_to_newline(global.site))
draw_text(512,480,string_hash_to_newline(global.mess))
draw_text(512,530,string_hash_to_newline(global.result))
draw_text(512,700,string_hash_to_newline("View Hiscore Table"))
draw_text(512,720,string_hash_to_newline("Visit www.mauft.com"))
draw_text(512,740,string_hash_to_newline("Restart Game"))


if mouse_check_button_pressed(mb_left){
    sel=0
    if mouse_x>100 and mouse_x<924 and mouse_y>360 and mouse_y<380{
        sel=1
    }
    if mouse_x>100 and mouse_x<924 and mouse_y>420 and mouse_y<440{
        sel=2
    }
    if mouse_x>100 and mouse_x<924 and mouse_y>480 and mouse_y<500{
        sel=3
    }
}

if mouse_y>700 and mouse_y<720{
    draw_set_alpha(0.3)
    draw_rectangle(100,700,924,720,0)
    draw_set_alpha(1)
    if mouse_check_button_pressed(mb_left){
        execute_shell("http://www.mauft.com/gamedata/qualifier.php","")
    }
}
if mouse_y>720 and mouse_y<740{
    draw_set_alpha(0.3)
    draw_rectangle(100,720,924,740,0)
    draw_set_alpha(1)
    if mouse_check_button_pressed(mb_left){
        execute_shell("http://www.mauft.com","")    
    }
}
if mouse_y>740 and mouse_y<760{
    draw_set_alpha(0.3)
    draw_rectangle(100,740,924,760,0)
    draw_set_alpha(1)
    if mouse_check_button_pressed(mb_left){
        game_restart()
    }
}
var bip;
bip=""
if keyboard_check_pressed(vk_anykey){bip=Texting()}
if bip<>""{
    if sel=1{
        if bip="back"{
            global.name=string_copy(global.name,1,string_length(global.name)-1)
        } else {
            if string_length(global.name)<30{
                global.name+=bip
            }
        }
    }
    if sel=2{
        if bip="back"{
            global.site=string_copy(global.site,1,string_length(global.site)-1)
        } else {
            if string_length(global.site)<64{
                global.site+=bip
            }
        }
    }
    if sel=3{
        if bip="back"{
            global.mess=string_copy(global.mess,1,string_length(global.mess)-1)
        } else {
            if string_length(global.mess)<60{
                global.mess+=bip
            }
        }
    }
}

if sel=1{
draw_set_alpha(0.3)
draw_rectangle(100,360,924,380,0)
draw_set_alpha(1)
}
if sel=2{
draw_set_alpha(0.3)
draw_rectangle(100,420,924,440,0)
draw_set_alpha(1)
}
if sel=3{
draw_set_alpha(0.3)
draw_rectangle(100,480,924,500,0)
draw_set_alpha(1)
}
draw_set_alpha(a)
draw_set_color(c_white)
draw_rectangle(0,0,1024,768,0)
draw_set_alpha(1)
a-=0.005
if a<=0 && a>-5{
a=-100
}

if sent=0 and keyboard_check_pressed(vk_enter){
if global.ide>0{
if global.name=""{global.name="Anonymous"}
if global.site=""{global.site="http://www.google.com"}
if global.mess=""{global.mess="No Message"}
global.site=string_replace_all(global.site,"&","^")
global.result="/gamedata/qualifier.php?a=add"
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
global.result=string_replace_all(global.result," ","%20")
clipboard_set_text(global.result)
global.result=netread(global.result,100)
if string_length(global.result)<7{   
    global.result="Score succesfully sent!#Your place, on our Highscore board is:#"+global.result
}
sent=0
}
}
