draw=1
timer=0
wait=0
can_exit=0

smart_music_pause();
smart_music_play(music_win)

  // make the particle system
  ps = part_system_create();

  // the firework particles
  pt1 = part_type_create();
  part_type_shape(pt1,pt_shape_line);
  part_type_size(pt1,0.1,0.3,-0.001,0);
  part_type_speed(pt1,0,10,0,0);
  part_type_color_rgb(pt1,80,255,80,255,0,0)
  part_type_direction(pt1,0,360,0,0)
  part_type_alpha2(pt1,1,0);
  part_type_life(pt1,20,50);
  part_type_gravity(pt1,0.2,270);
  part_type_orientation(pt1,0,0,0,0,1)


  // the rocket
  pt2 = part_type_create();
  part_type_shape(pt2,pt_shape_flare);
  part_type_size(pt2,0.2,0.2,0,0);
  part_type_speed(pt2,10,14,0,0);
  part_type_direction(pt2,80,100,0,0);
  part_type_color2(pt2,c_white,c_gray);
  part_type_life(pt2,30,60);
  part_type_gravity(pt2,0.2,270);
  part_type_death(pt2,150,pt1);    // create the firework on death

  // create the emitter
  em = part_emitter_create(ps);
  part_emitter_region(ps,em,100,700,600,700,ps_shape_rectangle,ps_distr_linear);
  part_emitter_stream(ps,em,pt2,-6);   // create one every four steps

