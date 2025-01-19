if !instance_exists(DiamondA){
if !instance_exists(DiamondB){
if !instance_exists(SmallBlack){
if !instance_exists(SmallRed){
if !instance_exists(SmallGold){
if !instance_exists(SmallYellow){
if !instance_exists(SmallGreen){
if !instance_exists(SmallCyan){
if !instance_exists(SmallBlue){
if !instance_exists(SmallViolet){
if !instance_exists(SmallWhite){
part_emitter_region(global.part_explosion_set,global.part_explodeA,x-5,x+5,y-5,y+5,ps_shape_line,ps_distr_linear)
part_emitter_burst(global.part_explosion_set,global.part_explodeA,global.particleD,5)
instance_create(x,y,Exit_Active)
sonpla(4)
instance_destroy()
}}}}}}}}}}}
