function Time(argument0) {
	var minutes, seconds;
	minutes=floor(abs(argument0)/60);
	seconds=abs(argument0) mod 60;
	if argument0>0{
	adder=""
	} else {adder="-"}
	if minutes>99{
	if seconds>9{
	return (adder+string(minutes)+":"+string(seconds))}
	return (adder+string(minutes)+":0"+string(seconds))
	}
	if minutes>9{
	if seconds>9{
	return (adder+"0"+string(minutes)+":"+string(seconds))}
	return (adder+"0"+string(minutes)+":0"+string(seconds))
	}

	if seconds>9{
	return (adder+"00"+string(minutes)+":"+string(seconds))}
	return (adder+"00"+string(minutes)+":0"+string(seconds))



}
