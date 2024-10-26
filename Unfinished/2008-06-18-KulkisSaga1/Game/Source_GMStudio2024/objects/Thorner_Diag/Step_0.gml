timer+=1
if (timer=10){
    timer=0
    var size,mode;
    mode=0
    while (!Nowall(x+movx*10,y) or !Nowall(x,y+movy*10) or !Nowall(x+movx*10,y+movy*10)){
        mode+=1
        size=0
        if (!Nowall(x+movx*10,y)){movx*=-1;size+=1}
        if (!Nowall(x,y+movy*10)){movy*=-1;size+=1}
        if (size=0){if (!Nowall(x+movx*10,y+movy*10)){movx*=-1;movy*=-1}}
        if mode=4{movx=0;movy=0;part_particles_create(global.part_sys_a,x+12,y+12,global.part_type_c,10);Blink_Static();instance_destroy();break}
    }
        
}
x+=movx;
y+=movy;
