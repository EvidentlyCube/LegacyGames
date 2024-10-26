var wth,hgt;
wth=200+floor(random(300))
hgt=251
surf=surface_create(wth,hgt)
surface_set_target(surf)
draw_sprite(S_Enemies5,0,0,0)
draw_set_color(surface_getpixel(surf,0,250))
var size,sizer,py,px,xmov,ymov;
px=0
py=random(250)
xmov=random(10)/100
size=10+random(20)
sizer=(random(10)-random(10))/100
ymov=(random(10)-random(10))/100
while px<wth{
xmov+=(random(10)-random(10))/100
if xmov<0{xmov=abs(xmov)}
ymov+=(random(10)-random(10))/25
px+=xmov
py+=ymov
if py<0{py=abs(py);ymov=abs(ymov)}
if py>250{py-=ymov;ymov*=-1}
sizer+=(random(10)-random(10))/100
size+=sizer
if size>30{size-=sizer;sizer*=-1}
if size<8{size=abs(size);sizer*=-1}
draw_circle(px,py,size,false)
}


surface_reset_target()
creator=instance_create(260,0,Enemy_Wall)
creator.sprite_index=sprite_create_from_surface(surf,0,0,wth,hgt,true,true,0,0)
