package Editor{
	public function TextToNum(num:String):uint{
		if (num.length == 1){
			return (num.charCodeAt(0) - 33)
		} else {
			return ((num.charCodeAt(0) - 33) + ((num.charCodeAt(1) - 33) * 93))
		}
	}
}