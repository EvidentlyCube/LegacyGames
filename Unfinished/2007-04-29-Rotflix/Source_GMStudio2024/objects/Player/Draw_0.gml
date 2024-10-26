if draw>0{
oldx=oldx+(x-oldx)/4
oldy=oldy+(y-oldy)/4
draw_sprite(sprite_index,image_index,oldx,oldy)
draw-=1
}
if draw=0{draw_sprite(sprite_index,image_index,x,y)}

if keyboard_check(vk_space){
d=0
  for (c=0;d<=hi;c+=1){
   if c>wi{c=0;d+=1}
   if d<=hi{if lev[c,d]>0{
   draw_text(c*20,d*20,string_hash_to_newline(string(lev[c,d])))
   }}
  }
}
