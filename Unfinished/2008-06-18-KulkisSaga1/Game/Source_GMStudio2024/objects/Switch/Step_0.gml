if (mode=0){
    if (place_meeting(x,y,Player)){
        event_user(0);
        mode=1;
        image_index+=4;
    }
} else {
    if (type=1){
        if (point_distance(x,y,Player.x,Player.y)>30){
            image_index-=4;
            mode=0
        }
    }
}
