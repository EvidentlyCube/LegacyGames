package Editor{
	public function NumToText(num:int,chars:uint = 1):String{
		if (chars == 0 || (num > 92 && chars == 1) || (num > 8464 && chars == 2) || chars > 2){
			throw new Error("Invalid value for NumToText")
		}
		var res:String = ""
		if (chars == 1){
			res += String.fromCharCode((num + 33))
		} else {
			res += String.fromCharCode((num%93) + 33)
			res += String.fromCharCode(Math.floor(num / 93) + 33)
		}
		return res;

	}
}