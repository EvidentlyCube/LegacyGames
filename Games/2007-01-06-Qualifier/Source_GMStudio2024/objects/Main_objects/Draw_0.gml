draw_sprite(S_Back,0,0,0)
draw_sprite_part(S_Paski,0,0,0,991*(global.accper/100),20,16,97)
draw_sprite_part(S_Paski,1,0,0,991*(global.limit/100),20,16,644)
if flash>0{
//draw_set_blend_mode(bm_add)
draw_set_alpha(flash)
draw_rectangle(0,0,1024,125,false)
draw_rectangle(0,639,1024,768,false)

draw_set_alpha(1)
//draw_set_blend_mode(bm_normal)

flash-=0.1
}
global.accper=global.acc/global.accmax*100
