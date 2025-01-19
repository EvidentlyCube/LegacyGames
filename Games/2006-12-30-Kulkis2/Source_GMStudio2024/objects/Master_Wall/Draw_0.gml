
if sprite_index != -1 {
	draw_sprite(sprite_index,image_number,x,y)
}
for(a=0;a!=global.key;a+=1){
	draw_sprite(S_KeyDrawer,global.keys[a]-1,a*15,0)
	draw_sprite(S_KeySelect,0,((global.doorop-1)*20-8),0)
}

for(a=0;a<global.liv;a+=1){
	draw_sprite(sprite124,0,5*a,575)
}

