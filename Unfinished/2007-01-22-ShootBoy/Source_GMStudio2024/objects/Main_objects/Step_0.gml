ran=round(random(10000))
if ran>0 && ran<100{instance_create(260,random(250),Enemy_1)}
if ran>100 && ran<200 {instance_create(260,random(220)+15,Enemy_2)}
if ran>200 && ran<500{instance_create(260,random(220)+15,Enemy_3)}
if ran<1000 && instance_number(Enemy_Wall)=0{instance_create(260,random(220)+15,Enemy_4)}
show_debug_message(ran);