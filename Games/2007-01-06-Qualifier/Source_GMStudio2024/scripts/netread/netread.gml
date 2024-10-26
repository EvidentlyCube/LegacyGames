function netread(argument0) {
	/*
	script will return your network ip address. It connects to whatismyip.com:80 which sends
	the ip address in the form of a http payload packet.
	*/
	var tcp;
	tcp = tcpconnect("www.mauft.com", 80, 0);
	if(!tcp)return "";
	setformat(tcp, 1, chr(13) + chr(10) + chr(13) + chr(10)); //set format to text mode to receive double blank lines (the whole header file)
	//send get request
	clearbuffer();
	clipboard_set_text("GET "+argument0+" HTTP/1.1")
	writechars("GET "+argument0+" HTTP/1.1" + chr(13) + chr(10));
	writechars("Host: www.mauft.com" + chr(13) + chr(10));
	writechars("User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9) Gecko/2008052906 Firefox/3.0" +chr(13) + chr(10));
	writechars("Connection: close"+chr(13) + chr(10));
	writechars("Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"+chr(13)+chr(10));
	writechars("Accept-Language: en-us,en"+chr(13) + chr(10));

	//Keep-Alive: 300
	//Connection: keep-alive
	//Cookie: punbb_cookie=a%3A2%3A%7Bi%3A0%3Bs%3A1%3A%222%22%3Bi%3A1%3Bs%3A32%3A%22e961916f5578d41196531fd58cdced0e%22%3B%7D

	sendmessage(tcp);

	global.a = receivemessage(tcp); //receive http header (and ignore)
	global.a = receivemessage(tcp, 64); //receive payload data
	closesocket(tcp);
	return readchars(bytesleft()); //return the payload data (ip address in this case)




}
