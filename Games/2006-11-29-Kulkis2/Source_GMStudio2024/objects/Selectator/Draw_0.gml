PasswordingLevelUnlock();

var a,b,c;
b=0
c=0
//draw_set_blend_mode(bm_add)
for (a=0;b<7;a+=1){
	if a=10{a=0;b+=1}
	if b=6{break}
	c=b*10+a

	switch (global.fin[c]){
	    case 0:
	        draw_sprite_ext(S_Menud,global.fin[c],a*80+1,121+b*80,1,1,0,c_white,0.8)
	        break
	    case 2:
	        draw_set_blend_mode(bm_add)
	        draw_sprite_ext(S_Menud,global.fin[c],a*80+1,121+b*80,1,1,0,c_white,0.5)
	        draw_set_blend_mode(bm_normal)
	}
}
var a,b,c;
b=0
c=0
for (a=0;b<7;a+=1){
	if a=10{a=0;b+=1}
	if b=6{break}
	c=b*10+a
	draw_sprite(sprite139,global.fin[c],a*80+1,121+b*80)
}
if global.levlo[1]=1{
	sel=global.levlo[0];
	global.fin[sel]=2;
	ix=global.levlo[2];
	iy=global.levlo[3];
	if global.fin[sel+1]=0{
		global.fin[sel+1]=1
	}
	global.levlo[1]=0;
	SaveState();
}
if global.levlo[1]=2{
	sel=global.levlo[0];
	ix=global.levlo[2];
	iy=global.levlo[3];
	global.levlo[1]=0;
	SaveState();
}

if keyboard_check_pressed(vk_left)  && ix>0{ix-=1;sound_play(Mieniu)}
if keyboard_check_pressed(vk_right) && ix<9{ix+=1;sound_play(Mieniu)}
if keyboard_check_pressed(vk_up)    && iy>0{iy-=1;sound_play(Mieniu)}
if keyboard_check_pressed(vk_down)  && iy<5{iy+=1;sound_play(Mieniu)}
if keyboard_check_pressed(vk_enter) && global.fin[sel]>0{
	sound_play(Mieniu2)

	smart_music_pause();
	
	if sel<18 { smart_music_play(music_tutorial); }
	if sel>17 && sel<31{smart_music_play(music_easy);}
	if sel>30 && sel<39{smart_music_play(music_logic);}
	if sel>38 && sel<53{smart_music_play(music_hard);}
	if sel>52{smart_music_play(music_extreme);}

	global.finished=0;
	global.levlo[0]=sel;
	global.levlo[2]=ix;
	global.levlo[3]=iy;
	room_goto(global.lev[sel]);
	global.liv=global.lif[sel]
}
draw_sprite_ext(sprite123,image_numbe,ix*80,119+iy*80,1,1,0,c_white,0.6)
image_numbe+=1
if image_numbe=3{image_numbe=0}

sel=iy*10+ix
draw_set_alpha(1)
draw_set_font(font0)
draw_set_halign(fa_center)
draw_set_color(c_black)
draw_text(400,11,string_hash_to_newline(string(sel)+":"+global.lvl[sel]))
draw_text(400,9,string_hash_to_newline(string(sel)+":"+global.lvl[sel]))
draw_text(401,10,string_hash_to_newline(string(sel)+":"+global.lvl[sel]))
draw_text(399,10,string_hash_to_newline(string(sel)+":"+global.lvl[sel]))
draw_text(128,53,string_hash_to_newline(dodo[global.fin[sel]]))
draw_text(126,53,string_hash_to_newline(dodo[global.fin[sel]]))
draw_text(127,54,string_hash_to_newline(dodo[global.fin[sel]]))
draw_text(127,52,string_hash_to_newline(dodo[global.fin[sel]]))
if sel<18{draw_text(478,53,string_hash_to_newline("Tutorial"));draw_text(480,53,string_hash_to_newline("Tutorial"));draw_text(479,54,string_hash_to_newline("Tutorial"));draw_text(479,52,string_hash_to_newline("Tutorial"))}
if sel>17 && sel<31{draw_text(480,53,string_hash_to_newline("Easy"));draw_text(478,53,string_hash_to_newline("Easy"));draw_text(479,54,string_hash_to_newline("Easy"));draw_text(479,52,string_hash_to_newline("Easy"))}
if sel>30 && sel<39{draw_text(480,53,string_hash_to_newline("Logic"));draw_text(480,53,string_hash_to_newline("Logic"));draw_text(479,52,string_hash_to_newline("Logic"));draw_text(479,54,string_hash_to_newline("Logic"))}
if sel>38 && sel<53{draw_text(480,53,string_hash_to_newline("Hard"));draw_text(478,53,string_hash_to_newline("Hard"));draw_text(479,54,string_hash_to_newline("Hard"));draw_text(479,52,string_hash_to_newline("Hard"))}
if sel>52{draw_text(480,53,string_hash_to_newline("Extreme"));draw_text(478,53,string_hash_to_newline("Extreme"));draw_text(479,54,string_hash_to_newline("Extreme"));draw_text(479,52,string_hash_to_newline("Extreme"))}
draw_set_color(c_white)
draw_text(400,10,string_hash_to_newline(string(sel)+":"+global.lvl[sel]))
draw_text(127,53,string_hash_to_newline(dodo[global.fin[sel]]))
if sel<18{draw_text(479,53,string_hash_to_newline("Tutorial"))}
if sel>17 && sel<31{draw_text(479,53,string_hash_to_newline("Easy"))}
if sel>30 && sel<39{draw_text(479,53,string_hash_to_newline("Logic"))}
if sel>38 && sel<53{draw_text(479,53,string_hash_to_newline("Hard"))}
if sel>52{draw_text(479,53,string_hash_to_newline("Extreme"))}

var a;
for (a=0;a<global.lif[sel];a+=1){
draw_sprite(sprite124,0,288+a*22,59)
}
var koko;
koko=0
if file_exists(program_directory + "./Game_Finished.txt"){exit}
repeat (59){
if global.fin[koko]!=2{exit}
koko+=1
}

smart_music_pause();
room_goto(Game_End)
