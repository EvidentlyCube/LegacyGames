room_speed*=0.8
if room_speed<40{object0.a+=(40-room_speed)*100;room_speed=40}
instance_create(random(300)+50,random(300)+50,blum)
