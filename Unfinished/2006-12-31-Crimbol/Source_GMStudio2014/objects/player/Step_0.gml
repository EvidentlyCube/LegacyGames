var a,b;
a=0
b=0
if keyboard_check(vk_space){

 if collision_rectangle(x,0,x+1,100,wall,1,1){
  do {
      a+=1
  } until (collision_point(x,a,wall,1,1) or a>5)
  do {
      b+=1
  } until (collision_point(x+1,b,wall,1,1) or b>5)
  if a>b && !place_meeting(x-1,y,wall){x-=1}
  if b>a && !place_meeting(x+1,y,wall){x+=1}
 }
}

if keyboard_check(vk_left) && !place_meeting(x-1,y,wall){x-=1;c-=1}
if keyboard_check(vk_right) && !place_meeting(x+1,y,wall){x+=1;c-=1}
if keyboard_check(vk_up) && !place_meeting(x,y-1,wall){y-=1;c-=1}
if keyboard_check(vk_down) && !place_meeting(x,y+1,wall){y+=1;c-=1}
c+=1
a+=1
if a=100{room_speed+=5;a=0}
if keyboard_check(vk_nokey){
b+=room_speed+floor(c/10)
}
b-=sqr(y)
