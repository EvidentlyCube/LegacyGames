if global.editor>0{
    draw_set_alpha(1)
    draw_set_color(c_black)
    draw_rectangle(0,0,107,500,0)
    if global.editor=1{
        draw_sprite(S_Arrow,1,10,176)
        draw_sprite(S_Arrow,2,84,176)
    }
}

draw_set_color(c_white)
draw_set_alpha(1)
if diss=0{draw_rectangle(mx+16,my+12,mx+47+16,my+47+12,1)}
if global.good=1{
    draw_set_alpha(0.5)
    draw_rectangle(mx+17,my+13,mx+46+16,my+46+12,0)
    draw_set_alpha(1)
}
switch (inst){
    case (Path_Wht):draw_sprite_ext(S_Color,0,40,163,1,1,0,make_color_rgb(255,255,255),1);break;
    case (Path_Blk):draw_sprite_ext(S_Color,0,40,163,1,1,0,make_color_rgb(150,150,150),1);break;
    case (Path_Red):draw_sprite_ext(S_Color,0,40,163,1,1,0,make_color_rgb(255,50,50),1);break;
    case (Path_Orn):draw_sprite_ext(S_Color,0,40,163,1,1,0,make_color_rgb(255,150,0),1);break;
    case (Path_Yll):draw_sprite_ext(S_Color,0,40,163,1,1,0,make_color_rgb(255,255,0),1);break;
    case (Path_Grn):draw_sprite_ext(S_Color,0,40,163,1,1,0,make_color_rgb(50,255,50),1);break;
    case (Path_Trq):draw_sprite_ext(S_Color,0,40,163,1,1,0,make_color_rgb(50,255,255),1);break;
    case (Path_Blu):draw_sprite_ext(S_Color,0,40,163,1,1,0,make_color_rgb(50,150,255),1);break;
    case (Path_Vlt):draw_sprite_ext(S_Color,0,40,163,1,1,0,make_color_rgb(255,50,150),1);break;
}
draw_set_font(global.font)
draw_set_halign(fa_center)
if global.editor=0{draw_text(62,45,string_hash_to_newline(string(global.level)))
    draw_text(62,100,string_hash_to_newline(string(global.path)+"/"+string(global.pathx)))
}

if global.editor=1 && object_exists(inst){
    draw_sprite(object_get_sprite(inst),0,16,150)
}

if global.editor>0{
    draw_set_font(global.font)
    draw_set_halign(fa_center)
    draw_text(64,16,string_hash_to_newline("Pieces"))
    switch (global.editor){
        case (1):draw_text(62,130,string_hash_to_newline("Piece#Type:"));break;
        case (2):draw_text(62,130,string_hash_to_newline("Link#Color:"));break;
    }

    if global.good=1{draw_set_font(global.font)} else {draw_set_font(global.font2)}
    draw_text(63,250,string_hash_to_newline("Save"))
    draw_set_font(global.font)
    draw_text(63,280,string_hash_to_newline("Title"))
    draw_text(63,310,string_hash_to_newline("Author"))
    draw_text(63,340,string_hash_to_newline("Help"))
    draw_text(63,370,string_hash_to_newline("Clear"))
    switch (global.editor){
        case (1):draw_text(62,450,string_hash_to_newline("Mode:#Bases"));break;
        case (2):draw_text(62,450,string_hash_to_newline("Mode:#Paths"));break;
    }
    draw_set_font(global.font2)
    draw_set_halign(fa_center)
    draw_text(64,40,string_hash_to_newline(string(global.path)+"/"+string(global.pathx)))
}
draw_set_font(global.font)
draw_set_halign(fa_center)
switch (global.du){
    case (1):draw_text(62,550,string_hash_to_newline("DelU.:#ON"));break;
    case (0):draw_text(62,550,string_hash_to_newline("DelU.:#OFF"));break;
}

blas=(collision_point(mouse_x,mouse_y,Path,0,1));
if !instance_exists(blas){
    blas=collision_point(mouse_x,mouse_y,Base,0,1)
    if !instance_exists(blas){
        blas=noone
    } else {
        blas=blas.object_index
    }
} else {
    blas=blas.shmai
}

with (blas){
    draw_sprite(S_Arrow,0,x,y)
}
if !instance_exists(L_Ender){
    draw_set_alpha(0.8/max(1,mouse_y/100));
    draw_set_font(global.font);
    draw_set_color(c_black);
    draw_rectangle(0,540,800,600,0);
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_text(400,555,string_hash_to_newline(global.l_title));
    draw_text(400,585,string_hash_to_newline(global.l_author));
}

if global.editor>0 && global.pause=0{
    while (x=x){
        if mouse_x>10 && mouse_x<24 && mouse_y>160 && mouse_y<210 && global.editor=1{edimod=1;break}
        if mouse_x>84 && mouse_x<107 && mouse_y>160 && mouse_y<210 && global.editor=1{edimod=2;break}
        if mouse_x>30 && mouse_x<80 && mouse_y>160 && mouse_y<210{if global.editor=1{edimod=3} else {edimod=8};break}
        if mouse_x>2 && mouse_x<105 && mouse_y>540 && mouse_y<580{edimod=4;break}
        if mouse_x>6 && mouse_x<100 && mouse_y>440 && mouse_y<480{edimod=5;break}
        if mouse_x>2 && mouse_x<107 && mouse_y>120 && mouse_y<160{if global.editor=1{edimod=3} else {edimod=8};break}
        if mouse_x>2 && mouse_x<107 && mouse_y>6 && mouse_y<46{edimod=7;break}
        if mouse_x>2 && mouse_x<107 && mouse_y>240 && mouse_y<270{edimod=9;break}
        if mouse_x>2 && mouse_x<107 && mouse_y>270 && mouse_y<300{edimod=10;break}
        if mouse_x>2 && mouse_x<107 && mouse_y>300 && mouse_y<330{edimod=11;break}
        if mouse_x>2 && mouse_x<107 && mouse_y>330 && mouse_y<360{edimod=12;break}
        if mouse_x>2 && mouse_x<107 && mouse_y>360 && mouse_y<390{edimod=13;break}
    
        edimod=0;
        break;
    }
    
    if edimod>0{
        draw_set_alpha(0.5);
        draw_set_color(c_black);
        draw_rectangle(150,150,750,450,0);
        Mening(150,150,750,450,0.8)
        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_set_font(global.font);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        switch(edimod){
            case(1):draw_text(460,300,string_hash_to_newline("Using this arrow you can change#the current element to the#previous one."));break;
            case(2):draw_text(460,300,string_hash_to_newline("Using this arrow you can change#the current element to the#next one."));break;
            case(3):draw_text(460,300,string_hash_to_newline("It shows the current item for#placing. You can change it using#the arrows or by pressing the#digits 0-9."));break;
            case(4):draw_text(460,300,string_hash_to_newline("If this option is turned on,#when you try to place objects#over already existing items they#will be automatically deleted.#Otherwise you will have to first#delete them using right mouse#button.#You can toggle it using \"U\"."));break;
            case(5):draw_text(460,300,string_hash_to_newline("This is the mode. When it says#\"Bases\" you edit the level by#placing and deleting bases and#other stuff. When it says \"Paths\"#you turn on the test mode and#you can place pathes to test#if level is finishable or not.#You can toggle it using \"Space\"."));break;
            case(6):draw_text(460,300,string_hash_to_newline("It shows the current item for#placing. You can change it using#the arrows or by pressing the#digits 0-9."));break;
            case(7):draw_text(460,300,string_hash_to_newline("It shows the limit of paths and#the number of already placed#paths. You can alter it using#+/- on your numpad. Hold shift#to change by ten. It is#impossible to make the paths#limit be smaller than the#currently placed paths.#If it is equal to zero, Limit is#disactivated!"));break;
            case(8):draw_text(460,300,string_hash_to_newline("It shows the current color of#drawn paths."));break;
            case(9):
                if global.good=1{
                    draw_text(460,300,string_hash_to_newline("Press this button or press \"S\"#to save this level to file.#You will not be able to delete#the level in-game, nor edit after saving it!"));
                } else {
                    draw_text(460,300,string_hash_to_newline("Before you will be able to save#level you first have to finish it!#In order to do this:#-Please enter the Paths mode#-Connect all bases using paths."));
                }
            break;
            case(10):draw_text(460,300,string_hash_to_newline("Use this to change the level's#title.#Works when pressing"+" \"N\" "+"too."));break;
            case(11):draw_text(460,300,string_hash_to_newline("Use this to change the level's#author.#Works when pressing"+" \"A\" "+"too."));break;
            case(12):draw_text(460,300,string_hash_to_newline("Use numbers from 0 to 9 in#order to change items to place.#Then build a level. Anytime you#want you can press space to test#the level, i.e. test the level.#Press space again to return to#editing. When you finish editing#level, give it a name (\"N\"#button), add author (\"A\" button)#and save it (\"S\" button). In#order to save, the level has#to be in a state of completion."));break;
            case(13):draw_text(460,300,string_hash_to_newline("Clears whole level.#\"C\" activates it too."));break;

        }
        if mouse_check_button_pressed(mb_left){
            switch(edimod){
                case(1):event_user(0);break;
                case(2):event_user(1);break;
                case(4):global.du+=1-sign(global.du)*2;soundplay(Snd_Click);break;
                case(5):inst=-1;switch (global.editor){case (1):Grinnys();if instance_exists(Base){inst=Base.shmai} else {inst=-1};global.editor=2;break;case (2):inst=0;global.editor=1;break;};break;
                case(9):if global.good=1{global.pause=1;instance_create(0,0,L_Ed_Infer);soundplay(Snd_Click);};break;
                case(10):global.pause=2;instance_create(0,0,L_Ed_Infer);soundplay(Snd_Click);break;
                case(11):global.pause=3;instance_create(0,0,L_Ed_Infer);soundplay(Snd_Click);break;
                case(13):global.pause=4;instance_create(0,0,L_Ed_Infer);soundplay(Snd_Click);break;
            }
        }
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);    
    }
}
