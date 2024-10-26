time+=1;
if time=10{
    if (Nowall(x+vspeed*-10,y+hspeed*10)){
        direction-=90;
    } else {
        if (!Nowall(x+hspeed*10,y+vspeed*10)){
            if (!Nowall(x+vspeed*10,y+hspeed*-10)){
                if (!Nowall(x+hspeed*-10,y+vspeed*-10)){part_particles_create(global.part_sys_a,x+12,y+12,global.part_type_c,10);Blink_Static();instance_destroy();} else {
                direction+=180;
                }
            } else {
            direction+=90;
            }
        }
    }
    time=0;
    image_index=0
}
//draw_me();
draw_sprite_ext(S_Rotter_GFX,0,x+12,y+12,1,1,time*-9,c_white,1)
