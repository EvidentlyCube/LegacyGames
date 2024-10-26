x=(ide).x;
y=(ide).y;
image_index=(ide).image_index;
depth=(ide).depth-1
sprite_index=(ide).sprite_index;
image_blend=(ide).image_blend;
image_xscale=(ide).image_xscale;
image_yscale=(ide).image_yscale;
image_angle=(ide).image_angle;
image_alpha-=0.05;
if image_alpha<=0{instance_destroy();}
draw_me_ext_blend(bm_add);

