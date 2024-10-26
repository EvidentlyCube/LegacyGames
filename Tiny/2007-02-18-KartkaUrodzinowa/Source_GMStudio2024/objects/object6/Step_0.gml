image_xscale*=0.8+random(0.1)-random(0.1)
image_yscale*=0.8+random(0.1)-random(0.1)
image_alpha*=0.8+random(0.1)-random(0.1)
if image_alpha<0.1{instance_destroy()}
