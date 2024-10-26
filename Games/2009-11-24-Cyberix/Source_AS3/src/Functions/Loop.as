package Functions{
	public function Loop(num:int,loopTo:int):Number{
		num = num%loopTo
		if (num < 0){
			return num + loopTo
		}

		return num
	}
}