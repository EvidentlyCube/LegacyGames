speed-=0.2
if speed<1{
image_alpha-=0.1}
if image_alpha<=0{instance_destroy()}
