function Levels_Upload() {
	gmsql_init();
	gmsql_connect(global.srv_dat[1],global.srv_dat[3],"33jd9A0dD",global.srv_dat[2]);
	ip=mplay_ipaddress();
  
	numa=0
	numb=0
	numc=0

	file=file_text_open_read("./levels/my.txt");

	while (0=0){
	    if (file_text_eof(file)){break;}
	    numa+=1
	    terxt=file_text_read_string(file);
	    codess=string_copy(terxt,94,168);
	    count=string_count("z",codess)+string_count("q",codess)+string_count("w",codess)+string_count("e",codess)+string_count("r",codess)+string_count("t",codess)+string_count("y",codess)+string_count("u",codess)+string_count("i",codess)+string_count("o",codess)+string_count("b",codess);
	    if (string_length(terxt)=261 && real(string_digits(string_copy(terxt,91,3)))<168 && count=168){
	        gmsql_query("SELECT content FROM '+global.srv_dat[4]+' WHERE code='"+string(codess)+"'");
	        gmsql_storeresult();
	        if (gmsql_numrows()=0){
	             if !gmsql_query("INSERT INTO "+global.srv_dat[4]+" VALUES (\""+ip+"\",\""+terxt+"\",\""+codess+"\")"){
	             show_message(gmsql_errormessage())
	             exit
	             }
	            numb+=1
	        } else {numc+=1}
	    } else {numc+=1}
	    file_text_readln(file);
	}

	file_text_close(file)
	//gmsql_close();

	blibx=instance_create(0,0,LB_Note)
	blibx.vara=numa
	blibx.varb=numb
	blibx.varc=numc
	global.pause=2





}
