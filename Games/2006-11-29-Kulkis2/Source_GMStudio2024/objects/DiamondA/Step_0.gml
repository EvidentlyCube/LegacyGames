if instance_exists(Body){
if x=Body.x-10 && y=Body.y-10{
part_emitter_region(global.part_explosion_set,global.part_explodeA,Body.x,Body.x,Body.y,Body.y,ps_shape_line,ps_distr_linear)
part_emitter_burst(global.part_explosion_set,global.part_explodeA,global.particleC,1)
instance_destroy()
sonpla(3)
}}

