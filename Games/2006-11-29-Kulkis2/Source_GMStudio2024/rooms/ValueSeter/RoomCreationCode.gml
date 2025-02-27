global.wall_magic_stop = 0;
global.doorop = 0;

/*--------------------------LEVEL SELECTION VARIABLES-------------------------*/
global.levlo = [0, 0, 0, 0]
global.lvl = [];
global.lev = []
global.fin = [];
global.lif = [];

global.lvl[00]="Exits"
global.lev[00]=Exits;
global.fin[00]=1
global.lif[00]=1
global.lvl[01]="Diamonds"
global.lev[01]=Diamonds;
global.fin[01]=0
global.lif[01]=1
global.lvl[02]="Blocks and Colourers"
global.lev[02]=Blocks_n_Colourers;
global.fin[02]=0
global.lif[02]=1
global.lvl[03]="Doors and Keys"
global.lev[03]=Doors_n_Keys;
global.fin[03]=0
global.lif[03]=1
global.lvl[04]="Pits"
global.lev[04]=Pits;
global.fin[04]=0
global.lif[04]=1
global.lvl[05]="Movers"
global.lev[05]=Movers;
global.fin[05]=0
global.lif[05]=1
global.lvl[06]="Terrains"
global.lev[06]=Terrains;
global.fin[06]=0
global.lif[06]=1
global.lvl[07]="Pushing"
global.lev[07]=Pushing;
global.fin[07]=0
global.lif[07]=1
global.lvl[08]="Pitting Crates"
global.lev[08]=Pitting_Crates;
global.fin[08]=0
global.lif[08]=1
global.lvl[09]="Bombs and Barrels"
global.lev[09]=Bombs_n_Barrels;
global.fin[09]=0
global.lif[09]=1
global.lvl[10]="Buttons"
global.lev[10]=Buttons;
global.fin[10]=0
global.lif[10]=1
global.lvl[11]="Bats"
global.lev[11]=Bats;
global.fin[11]=0
global.lif[11]=1
global.lvl[12]="Rotters"
global.lev[12]=Rotters;
global.fin[12]=0
global.lif[12]=1
global.lvl[13]="Spikers"
global.lev[13]=Spikers;
global.fin[13]=0
global.lif[13]=1
global.lvl[14]="Eyers"
global.lev[14]=Eyers;
global.fin[14]=0
global.lif[14]=1
global.lvl[15]="Thorners"
global.lev[15]=Thorners;
global.fin[15]=0
global.lif[15]=1
global.lvl[16]="Blyk Rush"
global.lev[16]=Blyk_Rush;
global.fin[16]=0
global.lif[16]=1
global.lvl[17]="Cannons"
global.lev[17]=Cannons;
global.fin[17]=0
global.lif[17]=1
global.lvl[18]="Box"
global.lev[18]=Box;
global.fin[18]=1
global.lif[18]=1
global.lvl[19]="Stoned Forest"
global.lev[19]=Stoned_Forest;
global.fin[19]=0
global.lif[19]=1
global.lvl[20]="Snake"
global.lev[20]=Snake;
global.fin[20]=0
global.lif[20]=1
global.lvl[21]="Push Me Around"
global.lev[21]=Push_Me_Around;
global.fin[21]=0
global.lif[21]=1
global.lvl[22]="Spiky Chase"
global.lev[22]=Spiky_Chase;
global.fin[22]=0
global.lif[22]=1
global.lvl[23]="Complex A"
global.lev[23]=Complex_A;
global.fin[23]=0
global.lif[23]=2
global.lvl[24]="Cornerian"
global.lev[24]=Cornerian;
global.fin[24]=0
global.lif[24]=1
global.lvl[25]="Xplosion"
global.lev[25]=Xplosion;
global.fin[25]=0
global.lif[25]=1
global.lvl[26]="Sceleton"
global.lev[26]=Sceleton;
global.fin[26]=0
global.lif[26]=1
global.lvl[27]="Rotter"
global.lev[27]=Rotter;
global.fin[27]=0
global.lif[27]=1
global.lvl[28]="Decidation"
global.lev[28]=Decidation;
global.fin[28]=0
global.lif[28]=1
global.lvl[29]="Bat Cage"
global.lev[29]=Bat_Cage;
global.fin[29]=0
global.lif[29]=1
global.lvl[30]="Corrida"
global.lev[30]=Corrida;
global.fin[30]=1
global.lif[30]=1
global.lvl[31]="Pity Pits"
global.lev[31]=Pity_Pits;
global.fin[31]=0
global.lif[31]=1
global.lvl[32]="Boxed"
global.lev[32]=Boxed;
global.fin[32]=0
global.lif[32]=1
global.lvl[33]="Chamberian"
global.lev[33]=Chamberian;
global.fin[33]=0
global.lif[33]=1
global.lvl[34]="Adventure Island"
global.lev[34]=Adventure_Island;
global.fin[34]=0
global.lif[34]=1
global.lvl[35]="Engimality"
global.lev[35]=Enigmality;
global.fin[35]=0
global.lif[35]=1
global.lvl[36]="Innormality"
global.lev[36]=Innormality;
global.fin[36]=0
global.lif[36]=1
global.lvl[37]="Small Corridor"
global.lev[37]=Small_Corridor;
global.fin[37]=0
global.lif[37]=1
global.lvl[38]="Launch Blocks"
global.lev[38]=Launch_Blocks;
global.fin[38]=0
global.lif[38]=1
global.lvl[39]="Fusion"
global.lev[39]=Fusion;
global.fin[39]=1
global.lif[39]=2
global.lvl[40]="Quadro Blocker"
global.lev[40]=Quadro_Blocker;
global.fin[40]=0
global.lif[40]=3
global.lvl[41]="Thornered"
global.lev[41]=Thornered;
global.fin[41]=0
global.lif[41]=3
global.lvl[42]="Quadro"
global.lev[42]=Quadro;
global.fin[42]=0
global.lif[42]=1
global.lvl[43]="Black World"
global.lev[43]=Black_World;
global.fin[43]=0
global.lif[43]=2
global.lvl[44]="Chambers"
global.lev[44]=Chambers;
global.fin[44]=0
global.lif[44]=2
global.lvl[45]="Complex B"
global.lev[45]=Complex_B;
global.fin[45]=0
global.lif[45]=4
global.lvl[46]="Small Quarters"
global.lev[46]=Small_Quarters;
global.fin[46]=0
global.lif[46]=5
global.lvl[47]="Bat'le Attack'e"
global.lev[47]=Batle_Attacke;
global.fin[47]=0
global.lif[47]=5
global.lvl[48]="Deformation"
global.lev[48]=Deformation;
global.fin[48]=0
global.lif[48]=3
global.lvl[49]="Death Sun"
global.lev[49]=Death_Sun;
global.fin[49]=0
global.lif[49]=2
global.lvl[50]="Castle Mania"
global.lev[50]=Castle_Mania;
global.fin[50]=0
global.lif[50]=3
global.lvl[51]="Thorning"
global.lev[51]=Thorning;
global.fin[51]=0
global.lif[51]=2
global.lvl[52]="Full Problem"
global.lev[52]=Full_Problem;
global.fin[52]=0
global.lif[52]=4
global.lvl[53]="Extreme Shot"
global.lev[53]=Extreme_Shot;
global.fin[53]=1
global.lif[53]=5
global.lvl[54]="Xtreme Battery"
global.lev[54]=Xtreme_Battery;
global.fin[54]=0
global.lif[54]=5
global.lvl[55]="Small Void"
global.lev[55]=Small_Void;
global.fin[55]=0
global.lif[55]=1
global.lvl[56]="Massacre"
global.lev[56]=Massacre;
global.fin[56]=0
global.lif[56]=5
global.lvl[57]="Gloomy Darkness"
global.lev[57]=Gloomy_Darkness;
global.fin[57]=0
global.lif[57]=5
global.lvl[58]="Quatro"
global.lev[58]=Quatro;
global.fin[58]=0
global.lif[58]=3
global.lvl[59]="Return to Menu"
global.lev[59]=Menu;
global.fin[59]=3
global.lif[59]=0
/*--------------------------SURFACES GENERATING---------------------------*/

global.surf_shadow=surface_create(800,600);
global.surf_shadow_buffer=buffer_create(800 * 600 * 4, buffer_fixed, 1);
surface_set_target(global.surf_shadow)
draw_clear_alpha(make_color_rgb(1,0,0),0)
surface_reset_target()
global.surf_tiles=surface_create(800,600);
global.surf_tiles_buffer=buffer_create(800 * 600 * 4, buffer_fixed, 1);
surface_set_target(global.surf_tiles)
draw_clear_alpha(make_color_rgb(1,0,0),0)
surface_reset_target()
global.surf_walls=surface_create(800,600, );
global.surf_walls_buffer=buffer_create(800 * 600 * 4, buffer_fixed, 1);
surface_set_target(global.surf_walls)
draw_clear_alpha(make_color_rgb(1,0,0),0)
surface_reset_target()

global.surf_sprite=0

/*---------------GLOBAL VALUES INITIATION------------------------------------------*/

global.color=0
global.bombs=0
global.colour=c0;
for (a=0;a<10;a+=1){global.keys[a]=0}
global.key=0
global.o_draw_keys=1
global.cannons=0
global.liv=0

/*----------------------------------PARTICLES INITIATION------------------------------------------------*/

global.part_explosion_set = part_system_create()
global.part_explosion_setB = part_system_create()

part_system_depth(global.part_explosion_set,-5000);
part_system_depth(global.part_explosion_setB,500);

global.particleA = part_type_create();
part_type_alpha2(global.particleA,1,0)
part_type_color1(global.particleA,c_black)
part_type_direction(global.particleA,0,360,0,2)
part_type_life(global.particleA,25,25)
part_type_shape(global.particleA,pt_shape_circle)
part_type_size(global.particleA,0.1,0.1,0.03,0)
part_type_speed(global.particleA,0,0,0,0)
global.part_explodeA = part_emitter_create(global.part_explosion_set)
global.part_explodeB = part_emitter_create(global.part_explosion_setB)
global.particleB = part_type_create();
part_type_alpha2(global.particleB,1,0)
part_type_color2(global.particleB,c_yellow,make_color_rgb(200,100,0))
part_type_direction(global.particleB,0,360,0,2)
part_type_life(global.particleB,50,50)
part_type_shape(global.particleB,pt_shape_circle)
part_type_size(global.particleB,0.1,0.1,0.06,0)
part_type_speed(global.particleB,0,0,0,0)
global.particleC = part_type_create();
part_type_alpha2(global.particleC,1,0)
part_type_color2(global.particleC,make_color_rgb(0,150,255),make_color_rgb(0,120,180))
part_type_direction(global.particleC,0,360,0,2)
part_type_life(global.particleC,50,50)
part_type_shape(global.particleC,pt_shape_circle)
part_type_size(global.particleC,0.05,0.05,0.02,0)
part_type_speed(global.particleC,0,0,0,0)
global.particleD = part_type_create();
part_type_alpha2(global.particleD,random(0.5)+0.5,0)
part_type_color2(global.particleD,make_color_rgb(200,200,200),make_color_rgb(50,50,50))
part_type_direction(global.particleD,0,360,0,2)
part_type_life(global.particleD,50,50)
part_type_shape(global.particleD,pt_shape_smoke)
part_type_size(global.particleD,random(1),random(1),0.01,0.003)
part_type_speed(global.particleD,random(0.01),random(0.01),0,0)
global.particleE = part_type_create();
part_type_alpha2(global.particleE,random(0.5)+0.5,0)
part_type_color2(global.particleE,make_color_rgb(250,0,0),make_color_rgb(50,0,0))
part_type_direction(global.particleE,0,360,0,2)
part_type_life(global.particleE,50,50)
part_type_shape(global.particleE,pt_shape_smoke)
part_type_size(global.particleE,random(0.4),random(0.4),0.01,0.003)
part_type_speed(global.particleE,random(0.01),random(0.01),0,0)


room_goto(InitialSplash)