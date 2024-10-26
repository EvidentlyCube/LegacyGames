function Levels_Download() {
	gmsql_init();
	gmsql_connect(global.srv_dat[1],global.srv_dat[3],"33jd9A0dD",global.srv_dat[2]);
	gmsql_query("SELECT level FROM "+global.srv_dat[4]);
	gmsql_storeresult();

  
	file=file_text_open_write("temp.txt");

	i=0
	repeat (gmsql_numrows()){
	file_text_write_string(file,gmsql_getvaluexy(0,i));
	file_text_writeln(file);
	i+=1
	}

	//gmsql_close();

	file_text_close(file);
	Levels_Import("temp.txt");
	Levels_Sort()
	Levels_Base_Generate()
	blibx=instance_create(0,0,LB_Note)
	blibx.vara=numa
	blibx.varb=numb
	blibx.varc=numc
	global.pause=1




}
