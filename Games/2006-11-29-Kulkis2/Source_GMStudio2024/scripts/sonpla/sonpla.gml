function sonpla(argument0) {
	if argument0=1{
	ran=floor(random(5))
	if ran=0{sound_play(Bach_A);return}
	if ran=1{sound_play(Bach_B);return}
	if ran=2{sound_play(Bach_C);return}
	if ran=3{sound_play(Bach_D);return}
	if ran=4{sound_play(Bach_E);return}
	} else {
	if argument0=2{
	ran=floor(random(7))
	if ran=0{sound_play(Plask_A);return}
	if ran=1{sound_play(Plask_B);return}
	if ran=2{sound_play(Plask_C);return}
	if ran=3{sound_play(Plask_D);return}
	if ran=4{sound_play(Plask_E);return}
	if ran=5{sound_play(Plask_F);return}
	if ran=6{sound_play(Plask_G);return}
	} else {
	if argument0=3{
	ran=floor(random(7))
	if ran=0{sound_play(Bonus_A);return}
	if ran=1{sound_play(Bonus_B);return}
	if ran=2{sound_play(Bonus_C);return}
	if ran=3{sound_play(Bonus_D);return}
	if ran=4{sound_play(Bonus_E);return}
	if ran=5{sound_play(Bonus_F);return}
	if ran=6{sound_play(Bonus_G);return}
	} else {
	if argument0=4{
	sound_play(Exitox);return
	} else {
	if argument0=5{
	ran=floor(random(7))
	if ran=0{sound_play(Ryps1);return}
	if ran=1{sound_play(Ryps2);return}
	if ran=2{sound_play(Ryps3);return}
	if ran=3{sound_play(Ryps4);return}
	if ran=4{sound_play(Ryps5);return}
	if ran=5{sound_play(Ryps6);return}
	if ran=6{sound_play(Ryps7);return}
	} else {
	sound_play(argument0)}
	}}}}



}
