draw_set_color(c_white)
draw_set_font(font0)
draw_set_halign(fa_left)

draw_sprite(S_Kifon,0,0,0)
draw_text(10,110,string_hash_to_newline("Qualifier is a survival Shooter with#a Twist.#In order to get high score, you not#only have to kill enemies, but also#shoot accurately, and survive for as#long as you can.##To make it better, this game features#in-game Hiscore sending!"))
draw_set_halign(fa_center)

if global.cza=""{
    draw_text(200,300,string_hash_to_newline("Failed to connect to the server#to get message. Firewall may be#the cause."))
}else{
    draw_text(200,300,string_hash_to_newline("--==ATTENTION==--#"+global.cza))
}
draw_text(200,500,string_hash_to_newline("F4 - Toggle Fullscreen#LMB - Start game#Space - Visit www.mauft.com"))

if mouse_check_button_pressed(mb_left){
    global.ide=netread("/gamedata/qualifier.php?a=id&ip="+mplay_ipaddress(),32)
    if ord(global.ide)<48 or ord(global.ide)>57{   
        show_message("Warning: The game didn't manage to connect to the server! You won't be able to send this score!")        
        global.ide=0
    } else {global.ide=real(global.ide)}
    room_goto_next()
    }
if keyboard_check_pressed(vk_space){execute_shell("http://www.mauft.com","")}
