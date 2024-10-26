if global.turn=1{
	if x=Player.x && y=Player.y{
		traping=1
	}else {
		if traping=1{
			var a;
			trap-=1;
			traping=0;
			a=instance_create(x,y,Trapdoordie);
			a.lolo=trap;
			if trap=0{
				instance_create(x,y,Pit);
				instance_destroy()
			}
		}
}
}
