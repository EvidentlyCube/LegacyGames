if instance_exists(Body){
if x=Body.x-10 && y=Body.y-10{
part_emitter_region(global.part_explosion_set,global.part_explodeA,Body.x,Body.x,Body.y,Body.y,ps_shape_line,ps_distr_linear)
part_emitter_burst(global.part_explosion_set,global.part_explodeA,global.particleB,1)
instance_destroy()
Main_objects.ix=Body.x
Main_objects.iy=Body.y
Main_objects.cp=1
}}
