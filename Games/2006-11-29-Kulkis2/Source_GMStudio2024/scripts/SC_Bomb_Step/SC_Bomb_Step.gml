function SC_Bomb_Step() {
	a+=1
	if a>8{image_index+=1;a=0}
	if image_index=0{ix=16;iy=15;dir=270}
	if image_index=1{ix=16;iy=14;dir=270}
	if image_index=2{ix=16;iy=13;dir=270}
	if image_index=3{ix=16;iy=12;dir=270}
	if image_index=4{ix=16;iy=11;dir=270}
	if image_index=5{ix=16;iy=10;dir=270}
	if image_index=6{ix=16;iy=9;dir=280}
	if image_index=7{ix=16;iy=8;dir=290}
	if image_index=8{ix=15;iy=7;dir=300}
	if image_index=9{ix=15;iy=6;dir=310}
	if image_index=10{ix=14;iy=5;dir=320}
	if image_index=11{ix=14;iy=4;dir=330}
	if image_index=12{ix=13;iy=3;dir=350}
	if image_index=13{ix=12;iy=2;dir=0}
	if image_index=14{ix=11;iy=2;dir=20}
	if image_index=15{ix=10;iy=2;dir=40}
	if image_index=16{ix=9;iy=4;dir=60}
	if image_index=17{ix=10;iy=4;dir=75}
	if image_index=18{ix=10;iy=5;dir=90}
	b=instance_create(x+ix,y+iy,BombFlame)
	b.direction=dir+random(10)-random(10)
	if image_index=18{instance_destroy()
	instance_create(x+10,y+10,Explosion)
	a=instance_create(x,y,Bomber)
	a.direction=0
	a.sprite_index=S_BomberB;
	a=instance_create(x,y,Bomber)
	a.direction=90
	a.sprite_index=S_BomberA;
	a=instance_create(x,y,Bomber)
	a.direction=180
	a.sprite_index=S_BomberC;
	a=instance_create(x,y,Bomber)
	a.direction=270
	a.sprite_index=S_BomberD;
	sonpla(5)}



}
