var zozo;
if number<global.maxi-1{
    zozo=max(min(1/max(1,point_distance(global.ider[number+1].x,global.ider[number+1].y,mouse_x,mouse_y))*10,1),min(1/max(1,point_distance(x,y,mouse_x,mouse_y))*10,1));
    zozo=0.5
    if cool>0{zozo=1}
    draw_set_blend_mode(bm_add);
    draw_sprite_ext(S_Ytems2,1,x,y,point_distance(x,y,global.ider[number+1].x,global.ider[number+1].y)/10,1,point_direction(x,y,global.ider[number+1].x,global.ider[number+1].y),c_white,zozo);
    draw_set_blend_mode(bm_normal);
    draw_sprite_ext(S_Ytems2,0,x,y,point_distance(x,y,global.ider[number+1].x,global.ider[number+1].y)/10,1,point_direction(x,y,global.ider[number+1].x,global.ider[number+1].y),c_white,zozo)
}
zozo=max(0.2,min(1/max(1,point_distance(x,y,mouse_x,mouse_y)),1));
zozo=0.5
if cool=1{zozo=1}
draw_set_blend_mode(bm_add);
draw_sprite_ext(S_Ytems,3-global.finish[number]*2,x,y,1,1,0,c_white,zozo);
draw_set_blend_mode(bm_normal);
draw_sprite_ext(S_Ytems,2-global.finish[number]*2,x,y,1,1,0,make_color_rgb(255*zozo,255*zozo,255*zozo),1);

cool=0
