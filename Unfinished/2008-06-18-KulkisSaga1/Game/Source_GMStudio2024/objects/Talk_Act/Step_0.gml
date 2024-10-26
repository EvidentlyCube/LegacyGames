switch (mode){
    case(0):    //At the beginning of the level
        global.temp_var=file;
        instance_create(0,0,Talker);
        instance_destroy();
    exit;
    case(1):    //if identical X
        if Player.x>x-5 && Player.x<x+5{
        global.temp_var=file;
        instance_create(0,0,Talker);
        instance_destroy();
        }
    exit;
    case(2):    //if identical Y
        if Player.y>y-5 && Player.y<y+5{
        global.temp_var=file;
        instance_create(0,0,Talker);
        instance_destroy();
        }
    exit;
    case(3):    //if identical X & Y
        if Player.y>y-5 && Player.y<y+5&& Player.x>x-5 && Player.x<x+5{
        global.temp_var=file;
        instance_create(0,0,Talker);
        instance_destroy();
        }
    exit;
    
}
