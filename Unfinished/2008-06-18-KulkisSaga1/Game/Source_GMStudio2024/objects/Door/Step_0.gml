switch (operation){
case(-1):
    if (moved>0){
        if (!place_meeting(x-movx,y-movx,Player)){
            x-=movx;
            y-=movy;
            moved+=operation;
        } else {
            operation=1;
        }
    } else {
    operation=0;
    }
break;
case(1):
    if (moved<25){
        x+=movx;
        y+=movy;
        moved+=operation;
    } else {
    operation=0;
    }
break;
}
