draw_sprite(S_Panel,0,0,0)
draw_sprite_part(S_Speed,0,0,0,abs(global.spd)*13.9,26,33,230)

var timp;
timp=0
repeat(21){
if global.item[timp]=1{
    draw_set_blend_mode(bm_subtract)
    draw_sprite(S_Items_Blend,timp,26+(timp mod 3)*60,344+floor(timp/3)*60)
    draw_set_blend_mode(bm_normal)
    draw_sprite(S_Items,timp,26+(timp mod 3)*60,344+floor(timp/3)*60)
}
timp+=1
}

draw_sprite(S_Cursor,0,mouse_x,mouse_y)

/*draw_set_blend_mode(bm_subtract)
draw_sprite(S_Panel,1,0,0)
draw_set_blend_mode(bm_normal)*/
if mouse_x>20 && mouse_x<180 && mouse_y>340 && mouse_y<760 {
    switch(floor((mouse_x-10)/60)+3*floor((mouse_y-330)/60)){
        case(0):
            if global.item[0]=1{
                global.text="Red Key - Opens Red Doors";
            }
        break;
        case(1):
            if global.item[1]=1{
                global.text="Orange Key - Opens Orange Doors";
            }
        break;
        case(2):
            if global.item[2]=1{
                global.text="Yellow Key - Opens Yellow Doors";
            }
        break;
        case(3):
            if global.item[3]=1{
                global.text="Green Key - Opens Green Doors";
            }
        break;
        case(4):
            if global.item[4]=1{
                global.text="Turquoise Key - Opens Turquoise Doors";
            }
        break;
        case(5):
            if global.item[5]=1{
                global.text="Blue Key - Opens Blue Doors";
            }
        break;
        case(6):
            if global.item[6]=1{
                global.text="Violet Key - Opens Violet Doors";
            }
        break;
        case(7):
            if global.item[7]=1{
                global.text="White Key - Opens White Doors";
            }
        break;
        case(8):
            if global.item[8]=1{
                global.text="Black Key - Opens Black Doors";
            }
        break;
        case(9):
            if global.item[9]=1{
                global.text="Strange Key - Runes on it say \"For Bigger purposes\"";
            }
        break;
        case(10):
            if global.item[10]=1{
                global.text="Surronding Calculator made by Cazio - It gives you no info though";
            }
        break;
        case(11):
            if global.item[11]=1{
                global.text="Crystal - Is filled with chips and all that stuff";
            }
        break;
        case(12):
            if global.item[0]=1{
                global.text="";
            }
        break;
        case(13):
            if global.item[0]=1{
                global.text="";
            }
        break;
        case(14):
            if global.item[0]=1{
                global.text="";
            }
        break;
        case(15):
            if global.item[0]=1{
                global.text="";
            }
        break;
        case(16):
            if global.item[0]=1{
                global.text="";
            }
        break;
        case(17):
            if global.item[0]=1{
                global.text="";
            }
        break;
        case(18):
            if global.item[0]=1{
                global.text="";
            }
        break;
        case(19):
            if global.item[0]=1{
                global.text="";
            }
        break;
        case(20):
            if global.item[0]=1{
                global.text="";
            }
        break;
    }
}
draw_set_font(global.font)
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_text(205,740,string_hash_to_newline(global.text))
draw_text(89,287,string_hash_to_newline(":"))
draw_text(128,287,string_hash_to_newline(":"))
draw_text(137,290,string_hash_to_newline(string(global.time mod 60)))
draw_set_halign(fa_right)
draw_text(86,290,string_hash_to_newline(string(floor(global.time/3600))))
draw_set_halign(fa_center)
draw_text(111,290,string_hash_to_newline(string(floor(global.time/60))))
/* */
/*  */
