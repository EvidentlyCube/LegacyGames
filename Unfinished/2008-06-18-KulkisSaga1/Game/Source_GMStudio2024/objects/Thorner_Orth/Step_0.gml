timer+=1
if (timer=10){
    timer=0
    if (!Nowall(x+hspeed*10,y+vspeed*10)){
        var vars,size;
        size=0
        if (Nowall(x+vspeed*-10,y+hspeed*10)){vars[size]=-90;size+=1}
        if (Nowall(x+vspeed*10,y+hspeed*-10)){vars[size]=90;size+=1}
        if (size>0){direction+=vars[min(size-1,now)];now+=1-sign(now*2)} else {
        if (Nowall(x-hspeed*10,y-vspeed*10)){direction+=180;} else {part_particles_create(global.part_sys_a,x+12,y+12,global.part_type_c,10);Blink_Static();instance_destroy();}}
    }
}
