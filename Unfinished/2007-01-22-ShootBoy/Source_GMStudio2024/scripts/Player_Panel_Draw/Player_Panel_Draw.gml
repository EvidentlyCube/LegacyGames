function Player_Panel_Draw() {
	if global.pause=1{
	   draw_set_alpha(0.8)
	   draw_set_color(c_black)
	   draw_rectangle(0,0,250,250,0)
	   draw_set_alpha(1)
	   if pan_ran=0{pan_ban=0}
	   pan_ran=0
	   draw_sprite(S_Pan_Base,0,0,0)
	/*ZMIANA PANELI*/
	   if mouse_x>0 && mouse_x<17 && mouse_y>0 && mouse_y<32{
	      pan_ran=1
	      pan_ban+=0.1
	      draw_set_blend_mode(bm_add)
	      draw_sprite_ext(S_Pan_Arrows,0,1,1,1,1,0,c_white,pan_ban)
	      draw_set_blend_mode(bm_normal)
	      if mouse_check_button_pressed(mb_left){panel-=1;if panel<0{panel=4}}
	   }
	   if mouse_x>233 && mouse_x<250 && mouse_y>0 && mouse_y<32{
	      pan_ran=1
	      pan_ban+=0.1
	      draw_set_blend_mode(bm_add)
	      draw_sprite_ext(S_Pan_Arrows,1,234,1,1,1,0,c_white,pan_ban)
	      draw_set_blend_mode(bm_normal)
	      if mouse_check_button_pressed(mb_left){panel+=1;if panel>4{panel=0}}
	   }
   
   
	/*PANEL 1 - KUPOWANIE BRONI*/
	   if panel=0{
	      draw_sprite(S_Weapon,w_mode,1,32)
	      draw_set_font(Sys)
	      draw_set_color(c_white)
	      draw_set_halign(fa_center)
	      draw_text(124,8,string_hash_to_newline("EXP:"+string(xp)+"  -WEAPONS-"))
	      draw_set_halign(fa_left)
	      draw_text(30,34,string_hash_to_newline("Gives: "+string(floor(sqr(w_mode*5)/2))+" Exp"))
	      draw_sprite(S_Weapon,w_mode+1,1,62)
	      draw_text(30,64,string_hash_to_newline("Costs: "+string(sqr((w_mode+1)*5))+" Exp"))
	      var texts;
	      texts=-1
	      if mouse_x>0 && mouse_x<23 && mouse_y>31 && mouse_y<54{
	          texts=w_mode
	          pan_ran=1
	          pan_ban+=0.1
	      if pan_ban>0.5{pan_ban=0.5}
	         draw_set_blend_mode(bm_add)
	         draw_set_color(c_white)
	         draw_set_alpha(pan_ban)
	         draw_rectangle(1,32,22,53,0)
	         draw_set_blend_mode(bm_normal)
	         draw_set_alpha(1)
	         if w_mode>0{draw_text(1,220,string_hash_to_newline("Press RMB to degrade (you get 50%)."));
	          if mouse_check_button_pressed(mb_right){xp+=floor(sqr(w_mode*5)/2);w_mode-=1}
	         } else {draw_text(1,220,string_hash_to_newline("You cannot degrade it anymore!"))}
	      }
	      if mouse_x>0 && mouse_x<23 && mouse_y>61 && mouse_y<84{
	         texts=w_mode+1
	         pan_ran=1
	         pan_ban+=0.1
	         if pan_ban>0.5{pan_ban=0.5}
	         draw_set_blend_mode(bm_add)
	         draw_set_color(c_white)
	         draw_set_alpha(pan_ban)
	         draw_rectangle(1,62,22,83,0)
	         draw_set_blend_mode(bm_normal)
	         draw_set_alpha(1)
	         if w_mode<32{if xp>=sqr((w_mode+1)*5){draw_text(1,220,string_hash_to_newline("Press RMB to upgrade."));
	          if mouse_check_button_pressed(mb_right){xp-=sqr((w_mode+1)*5);w_mode+=1}} else {draw_text(1,220,string_hash_to_newline("You don't have enough Exp!"))}
	         } else {draw_text(1,220,string_hash_to_newline("You cannot upgrade it anymore!"))}
	      }
	      if texts>-1{
	         switch (texts){
	                case (0):texts="Single Front Cannon#The most basic weapon, not effective against#anyone and anything.#Should be upgraded as soon as possible!";break;
	                case (1):texts="Double Front Cannon#Thanks to the upgraded energy utilization#two cannons can shot at the same time#without loss of shooting rate.#It is wise to upgrade this.";break;
	                case (2):texts="Threeway Cannon#Two cannons has been changed into one#with additional distribute module#you shoot in three directions without power#or rate loss!";break;
	                case (3):texts="Double with Sides#Some Description";break;
	                case (4):texts="Single with Double Sides#Some Description";break;
	                case (5):texts="Doubled Threeway#Some Description";break;
	                case (6):texts="Triple with Double Sides#Some Description";break;
	                case (7):texts="Quad with Double Sides#Some Description";break;
	                case (8):texts="Machinae with Double Sides#Some Description";break;
	                case (9):texts="Threeway Machinae#Some Description";break;
	                case (10):texts="Laser#Some Description";break;
	                case (11):texts="Laser with Shots#Some Description";break;
	                case (12):texts="Laser with Threeway#Some Description";break;
	                case (13):texts="Laser with Machinae and Sides#Some Description";break;
	                case (14):texts="Laser with Threeway Machinae#Some Description";break;
	                case (15):texts="Blazer#Some Description";break;
	                case (16):texts="Blazer with Shots#Some Description";break;
	                case (17):texts="Blazer with Threeway#Some Description";break;
	                case (18):texts="Blazer with Machinae and Sides#Some Description";break;
	                case (19):texts="Blazer with Threeway Machinae#Some Description";break;
	                case (20):texts="Seeker with Quad and Sides#Some Description";break;
	                case (21):texts="Seeker with Machinae and Sides#Some Description";break;
	                case (22):texts="Seeker with Threeway Machinae#Some Description";break;
	                case (23):texts="Laser and Seeker with Shots#Some Description";break;
	                case (24):texts="Laser and Seeker with Threeway#Some Description";break;
	                case (25):texts="Laser and Seeker with Machinae and Sides#Some Description";break;
	                case (26):texts="Laser and Seeker with Threeway Machinae#Some Description";break;
	                case (27):texts="Blazer and Seeker with Threeway Machinae#Some Description";break;
	                case (28):texts="Blazer and Seeker with Super Threeway Machinae#Some Description";break;
	                case (29):texts="Blazer and Seeker with Ultra Threeway Machinae#Some Description";break;
	                case (30):texts="Laser and Seeker with Machinae Sides and Thriller#Some Description";break;
	                case (31):texts="Blazer and Seeker with Machinae Sider and Thriler#Some Description";break;
	                case (32):texts="Blazer and Seeker with Threeway Thriller#Some Description";break;
	                case (33):texts="You have achieved maximum weapon level!";break;
	         }
	         draw_set_color(c_white)
	         draw_text(1,90,string_hash_to_newline(texts))
	      }
	   }
	/*PANEL 2 - STATEK - ENGINE/SPEED/ACCELERATION*/
	   if panel=1{
	      draw_set_font(Sys)
	      draw_set_color(c_white)
	      draw_set_halign(fa_center)
	      draw_text(124,8,string_hash_to_newline("EXP:"+string(xp)+"  -SHIP-"))
	      draw_text(125,25,string_hash_to_newline("Engine:#Classical | Breaking | Stopping##Max Speed (Currently "+string(spd)+"):#Decrease | Increase##Acceleration (Currently "+string(acc)+"):#Decrease | Increase"))
	   }
	/*PANEL 3 - STAMINA*/
	   if panel=2{
	      draw_set_font(Sys)
	      draw_set_color(c_white)
	      draw_set_halign(fa_center)
	      draw_text(124,8,string_hash_to_newline("EXP:"+string(xp)+"  -STAMINA-"))
	      draw_set_halign(fa_left)
	   }
	/*PANEL 4 - FRIEND SUB-SHIPS*/
	   if panel=3{
	      draw_set_font(Sys)
	      draw_set_color(c_white)
	      draw_set_halign(fa_center)
	      draw_text(124,8,string_hash_to_newline("EXP:"+string(xp)+"  -SUB-SHIPS-"))
	      draw_set_halign(fa_left)
	   }
	/*PANEL 4 - REPAIRS*/
	   if panel=4{
	      draw_set_font(Sys)
	      draw_set_color(c_white)
	      draw_set_halign(fa_center)
	      draw_text(124,8,string_hash_to_newline("EXP:"+string(xp)+"  -REPAIRS-"))
	      draw_set_halign(fa_left)
	   }
	}



}
