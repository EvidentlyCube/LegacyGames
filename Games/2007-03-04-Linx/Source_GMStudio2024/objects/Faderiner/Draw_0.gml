if global.op_mus=0{ga+=20}
ga+=1

if ga>400{
ba-=0.05
}
if ba<=0{instance_destroy()}

draw_set_alpha(ba)
draw_set_color(c_black)
draw_rectangle(0,0,800,600,0)
