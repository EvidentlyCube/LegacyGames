screen_save("./dozo.bmp")
switch(show_message_ext("What now?","End","Background","Foreground")){
case(2):execute_program("./KIIB.exe","\""+string(global.testo)+"\"",0);break;
case(3):execute_program("./KIIF.exe","\""+string(global.testo)+"\"",0);break;
}

