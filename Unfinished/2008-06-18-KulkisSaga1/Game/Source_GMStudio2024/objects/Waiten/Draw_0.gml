Show_Progress("Generating Level, Please Wait Patiently!")

if global.temp_first=1{
    Create_Surfaces(0);
    Create_Surfaces(2);
    Create_Surfaces(5);
    Create_Surfaces(4);
    Create_Surfaces(7);
    Create_Surfaces(1);
} else {
    Create_Surfaces(1);
    Create_Surfaces(6);
    Create_Surfaces(8);
    if global.temp_retexture=1{
        Create_Surfaces(4);
        global.retexture=0;
    }
}

Make_Level(global.level)


