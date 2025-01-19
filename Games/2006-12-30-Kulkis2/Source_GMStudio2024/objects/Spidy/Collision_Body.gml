var __b__;
__b__ = action_if_variable(behavior, 2, 0);
if !__b__
{
{
speed=0
behavior=2
sprite_index=S_SpidyDead
timer=0
depth=1000
part_emitter_region(global.part_explosion_setB,global.part_explodeB,x,x,y,y,ps_shape_line,ps_distr_linear)
part_emitter_burst(global.part_explosion_setB,global.part_explodeB,global.particleE,1)
sonpla(2)
}
}
