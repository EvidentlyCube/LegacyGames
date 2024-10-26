
switch (sek){
    case(1):
        time+=1
        if (time=10){
            time=-1
            if (!Nowall(x+spd*10,y)){
                move=spd;
                spd*=-1;
                sek=2;
                add=x;
            }
        } else {x+=spd;};
    break;
    case(2):
        if (abs(move)>0.1){
            x+=move;
            move*=0.8;
        } else {
            sek=3;
        }
    break;
    case(3):
        if (abs(move)<abs(spd)){
            x-=move;
            move/=0.8;
        } else {
            sek=1
            if (!Nowall(x+spd*10,y)){time=9}
            
        }
    break;
}
