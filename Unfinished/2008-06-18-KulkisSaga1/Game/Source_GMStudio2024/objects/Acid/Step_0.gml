repeat(10){
    x+=xvec
    bla=Check_Block(x,y)
    if (instance_exists(bla)){
        instance_destroy();
        if (bla.color=global.colora or global.color=69){
        with (bla){Block_Hit();}
        }
    }
    bla=Check_Colourer(x,y)
    if (instance_exists(bla)){
        instance_destroy();
        Player_Color(bla);
        with(bla){event_user(0);Blink();}
        with (Player){Blink();}
    }
    bla=Check_Door(x,y)
    if (instance_exists(bla)){
        instance_destroy();
        with (bla){
            if type=1 && global.item[color]=1{
                operation=1
            }
        }
    }
    y+=yvec
    bla=Check_Block(x,y)
    if instance_exists(bla){
        instance_destroy();
        if (bla.color=global.colora or global.color=69){
        with (bla){Block_Hit();}
        }
    }
    bla=Check_Colourer(x,y)
    if (instance_exists(bla)){
        instance_destroy();
        Player_Color(bla);
        with(bla){event_user(0);Blink();}
        with (Player){Blink();}
    }
    bla=Check_Door(x,y)
    if (instance_exists(bla)){
        instance_destroy();
        with (bla){
            if type=1 && global.item[color]=1{
                operation=1
            }
        }
    }
    if !Nowall(x,y){instance_destroy()}
}
xvec*=0.9*(timer/25)
yvec*=0.9*(timer/25)
timer-=1
if timer=0{instance_destroy()}
image_alpha=timer/25

