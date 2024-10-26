raw+=0.1
part_particles_create(global.part_sys_a,oldx+10+radtodeg(sin(raw))/10,oldy+10+radtodeg(cos(raw))/10,global.part_type_a,1)
part_particles_create(global.part_sys_a,oldx+10+radtodeg(sin(raw-3))/10,oldy+10+radtodeg(cos(raw-3))/10,global.part_type_a,1)
draw_sprite(S_Enemyfive,1,oldx+10+radtodeg(sin(raw))/10,oldy+10+radtodeg(cos(raw))/10)
draw_sprite(S_Enemyfive,2,oldx+10+radtodeg(sin(raw-3))/10,oldy+10+radtodeg(cos(raw-3))/10)
draw_sprite_ext(S_Enemyfivebody,image_index,oldx,oldy,1,1,0,c_white,0.4)

if draw>0{
oldx=oldx+(x-oldx)/4
oldy=oldy+(y-oldy)/4
draw-=1
}
