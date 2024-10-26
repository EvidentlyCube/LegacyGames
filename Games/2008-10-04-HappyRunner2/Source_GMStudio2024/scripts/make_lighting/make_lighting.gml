function make_lighting() {
	bla=instance_place(random(room_width),random(room_height),Wall)
	while !instance_exists(bla){
	    bla=instance_place(random(room_width),random(room_height),Wall)
	}
	x2=bla.x+choose(0,32);
	y2=bla.y+choose(0,32);
	if choose(0,1)=0{
	bla=instance_place(random(room_width),random(room_height),Wall)
	while !instance_exists(bla){
	    bla=instance_place(random(room_width),random(room_height),Wall)
	}
	x2=bla.x+choose(0,32);
	y2=bla.y+choose(0,32);} else {
	x1=Player.x;
	y1=Player.y;
	}

	var kok;
	kok=point_distance(x1,y1,x2,y2)/5
	ix[0]=(x2-x1)/2+x1+random(kok)-random(kok)
	iy[0]=(y2-y1)/2+y1+random(kok)-random(kok)
	ix[1]=(x2-ix[0])/2+ix[0]+random(kok)-random(kok)
	iy[1]=(y2-iy[0])/2+iy[0]+random(kok)-random(kok)
	ix[2]=(ix[0]-x1)/2+x1+random(kok)-random(kok)
	iy[2]=(iy[0]-y1)/2+y1+random(kok)-random(kok)
	ix[3]=(x2-ix[1])/2+ix[1]+random(kok)-random(kok)
	iy[3]=(y2-iy[1])/2+iy[1]+random(kok)-random(kok)
	ix[4]=(ix[1]-ix[0])/2+ix[0]+random(kok)-random(kok)
	iy[4]=(iy[1]-iy[0])/2+iy[0]+random(kok)-random(kok)
	ix[5]=(ix[0]-ix[2])/2+ix[2]+random(kok)-random(kok)
	iy[5]=(iy[0]-iy[2])/2+iy[2]+random(kok)-random(kok)
	ix[6]=(ix[2]-x1)/2+x1+random(kok)-random(kok)
	iy[6]=(iy[2]-y1)/2+y1+random(kok)-random(kok)

	draw_set_color(make_color_rgb(0,0,100))
	draw_line(x1+1,y1,ix[6]+1,iy[6])
	draw_line(ix[6]+1,iy[6],ix[2]+1,iy[2])
	draw_line(ix[2]+1,iy[2],ix[5]+1,iy[5])
	draw_line(ix[5]+1,iy[5],ix[0]+1,iy[0])
	draw_line(ix[0]+1,iy[0],ix[4]+1,iy[4])
	draw_line(ix[4]+1,iy[4],ix[1]+1,iy[1])
	draw_line(ix[1]+1,iy[1],ix[3]+1,iy[3])
	draw_line(ix[3]+1,iy[3],x2+1,y2)
	draw_line(x1-1,y1,ix[6]-1,iy[6])
	draw_line(ix[6]-1,iy[6],ix[2]-1,iy[2])
	draw_line(ix[2]-1,iy[2],ix[5]-1,iy[5])
	draw_line(ix[5]-1,iy[5],ix[0]-1,iy[0])
	draw_line(ix[0]-1,iy[0],ix[4]-1,iy[4])
	draw_line(ix[4]-1,iy[4],ix[1]-1,iy[1])
	draw_line(ix[1]-1,iy[1],ix[3]-1,iy[3])
	draw_line(ix[3]-1,iy[3],x2-1,y2)
	draw_line(x1,y1+1,ix[6],iy[6]+1)
	draw_line(ix[6],iy[6]+1,ix[2],iy[2]+1)
	draw_line(ix[2],iy[2]+1,ix[5],iy[5]+1)
	draw_line(ix[5],iy[5]+1,ix[0],iy[0]+1)
	draw_line(ix[0],iy[0]+1,ix[4],iy[4]+1)
	draw_line(ix[4],iy[4]+1,ix[1],iy[1]+1)
	draw_line(ix[1],iy[1]+1,ix[3],iy[3]+1)
	draw_line(ix[3],iy[3]+1,x2,y2+1)
	draw_line(x1,y1-1,ix[6],iy[6]-1)
	draw_line(ix[6],iy[6]-1,ix[2],iy[2]-1)
	draw_line(ix[2],iy[2]-1,ix[5],iy[5]-1)
	draw_line(ix[5],iy[5]-1,ix[0],iy[0]-1)
	draw_line(ix[0],iy[0]-1,ix[4],iy[4]-1)
	draw_line(ix[4],iy[4]-1,ix[1],iy[1]-1)
	draw_line(ix[1],iy[1]-1,ix[3],iy[3]-1)
	draw_line(ix[3],iy[3]-1,x2,y2-1)
	draw_set_color(make_color_rgb(200,200,255))
	draw_line(x1,y1,ix[6],iy[6])
	draw_line(ix[6],iy[6],ix[2],iy[2])
	draw_line(ix[2],iy[2],ix[5],iy[5])
	draw_line(ix[5],iy[5],ix[0],iy[0])
	draw_line(ix[0],iy[0],ix[4],iy[4])
	draw_line(ix[4],iy[4],ix[1],iy[1])
	draw_line(ix[1],iy[1],ix[3],iy[3])
	draw_line(ix[3],iy[3],x2,y2)
	draw_set_alpha(1)



}
