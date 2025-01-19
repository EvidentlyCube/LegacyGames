if move=0 && global.bombs>0 && !place_meeting(x,y,Bomb){instance_create(x-10,y-10,Bomb);global.bombs-=1;sound_play(Putss)}
