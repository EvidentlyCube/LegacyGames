SXMS2_MC_StopAllSongs()
if global.editor=0 && global.leveled=-1{
game_save("./save.sav")
file=file_bin_open("./save.sav",2)
file_bin_write_byte(file,room)
file_bin_seek(file,20)
file_bin_write_byte(file,global.level)
file_bin_close(file)
}

color=0
ix=x
iy=y
a=pi/2
b=5
da=1
gugu=0
duvu=0
instance_create(0,0,Faderiner)
zazka=0
if global.op_mus=1{SXMS2_MC_PlaySong(5)}

  // make the particle system
  ps = part_system_create();
  part_system_depth(ps,-99999999)

  // the firework particles
  pt1 = part_type_create();
  part_type_shape(pt1,pt_shape_line);
  part_type_size(pt1,0.1,0.3,-0.001,0);
  part_type_speed(pt1,0,5,0,0);
  part_type_color_rgb(pt1,80,255,80,255,0,0)
  part_type_direction(pt1,0,360,0,0)
  part_type_alpha2(pt1,1,0);
  part_type_life(pt1,20,150);
  part_type_gravity(pt1,0.1,270);
  part_type_orientation(pt1,0,0,0,0,1)


  // the rocket
  pt2 = part_type_create();
  part_type_shape(pt2,pt_shape_flare);
  part_type_size(pt2,0.2,0.2,0,0);
  part_type_speed(pt2,15,20,0,0);
  part_type_direction(pt2,80,100,0,0);
  part_type_color2(pt2,c_white,c_gray);
  part_type_life(pt2,37,38);
  part_type_gravity(pt2,0.2,270);
  part_type_death(pt2,150,pt1);    // create the firework on death

  // create the emitter
  em = part_emitter_create(ps);
  part_emitter_region(ps,em,100,700,600,700,ps_shape_rectangle,ps_distr_linear);
  /*part_emitter_stream(ps,em,pt2,-6);   // create one every four steps

  
*/
sza[0]=floor(random(90))
sza[8]=100-sza[0]
sza[5]=floor(sza[8]/5)
sza[1]=floor(random(sza[5]))
sza[9]=sza[5]-sza[1]
sza[2]=sza[1]*69
sza[7]=ceil((sza[2]+1)/17)
sza[4]=5
sza[3]=floor(random(100))
sza[6]=floor(random(100))
registry_write_string("Option_0",string(sza[0]))
registry_write_string("Option_1",string(sza[1]))
registry_write_string("Option_2",string(sza[2]))
registry_write_string("Option_3",string(sza[3]))
registry_write_string("Option_4",string(sza[4]))
registry_write_string("Option_5",string(sza[5]))
registry_write_string("Option_6",string(sza[6]))
registry_write_string("Option_7",string(sza[7]))
registry_write_string("Option_8",string(sza[8]))
registry_write_string("Option_9",string(sza[9]))
/* */
/*  */
