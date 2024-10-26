__background_set( e__BG.Index, 0, background_add("G:/dozo.bmp",0,0,1) )

global.file=file_bin_open(get_open_filename("Kulkis Saga I Level File|*.kil","H:\\Projects\\Workon\\Kulkis Saga 1"),2)

list_o=ds_list_create()
list_c=ds_list_create()


for(y=0;y<29;y+=1){
    for(x=0;x<32;x+=1){
        koko=y*32+x+928
        file_bin_seek(global.file,koko)
        ds_list_add(list_o,file_bin_read_byte(global.file))
        file_bin_seek(global.file,koko+928+928+928+928)
        ds_list_add(list_c,file_bin_read_byte(global.file))
    }
}

mode=0
item=1
varz=0

/*Constants*/

color[0]=make_color_rgb(255,0,0);
color[1]=make_color_rgb(200,150,0);
color[2]=make_color_rgb(250,230,50);
color[3]=make_color_rgb(0,255,0);
color[4]=make_color_rgb(100,255,255);
color[5]=make_color_rgb(100,100,255);
color[6]=make_color_rgb(255,100,255);
color[7]=make_color_rgb(255,255,255);
color[8]=make_color_rgb(150,150,150);


mxy=-1
/* */
/*  */
