switch (sek){
    case(1):
        time+=1
        if (time=10){
            time=-1
            if (!Nowall(x,y+spd*10)){
                move=spd;
                spd*=-1;
                sek=2;
                add=y;
            }
        } else {y+=spd;}
    break;
    case(2):
        if (abs(move)>0.1){
            y+=move;
            move*=0.8;
        } else {
            sek=3;
        }
    break;
    case(3):
        if (abs(move)<abs(spd)){
            y-=move;
            move/=0.8;
        } else {
            sek=1;
            if (!Nowall(x,y+spd*10)){time=9}
        }
    break;
}
