function Talker_Get_Special(argument0) {
	/*text[0]=''
	author[0]=''
	side[0]=1
	face[0]=s_face[]
	*/

	file=file_bin_open("./levels/lev"+string(global.level)+"_"+string(argument0)+".kis",2)
	current=0
	amount=0
	var read;
	while(file_bin_position(file)<file_bin_size(file)){
	    amount+=1
	    side[current]=file_bin_read_byte(file)
	    face[current]=file_bin_read_byte(file)
	    read=file_bin_read_byte(file);
	    author[current]=""
	    while(read>0){
	        author[current]+=chr(read-69);
	        read=file_bin_read_byte(file);
	    }
	    read=file_bin_read_byte(file);
	    text[current]=""
	    while(read>0){
	        text[current]+=chr(read-69);
	        read=file_bin_read_byte(file);
	    }
	    current+=1
	}
	current=0

	var rupcia,pupcia,salcesonik,helu,belu;
	/*
	Rupcia - Array zawieraj�cy dodane facesy
	pupcia - ilosc aktualnie dodanych facesow
	salcesonik - Sprawdza czy Face ju� istnieje
	helu - wartosc uzywana dla loopa by sprawdzic czy w rupci nie ma juz twarzy
	belu - face na ktorym sie aktualnie operuje
	*/
	pupcia=0 
	salcesonik=0
	belu=0
	repeat(amount){ //Wykonaj test tyle razy ile jest facesow
	    for(helu=0;helu<pupcia;helu+=1){//loop co sprawdza kazda twarz w rupcia i porownuje z aktualnym facem
	        if face[belu]=rupcia[helu]{salcesonik=1;break} //Kiedy taki twarz juz jest, salcesonik sie ustawia i sie breakuje
	    }
	    if salcesonik=0{ //Jezeli salcesonik nie zostal zsetowany, dodaj twarz do listy
	        rupcia[pupcia]=face[belu] //dodaje do rupci twarz
	        s_face[face[belu]]=Add_Face(face[belu]) //dodaje nowa grafike twarzt
	        pupcia+=1 //zwieksza rozmiar rupci o jeden
	    }
	    belu+=1 //zaznacza ze teraz bedzie nastepna twarz testowana
	    salcesonik=0 //zeruje salcesonik
	}

	belu=0
	repeat(amount){
	    face[belu]=s_face[face[belu]]
	    belu+=1
	}

	current=0



}
