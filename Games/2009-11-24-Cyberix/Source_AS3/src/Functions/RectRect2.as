package Functions
{

	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public function RectRect2(x1:Number,y1:Number,x2:Number,y2:Number):Boolean{
		var ix:Number = x2 - x1
		var iy:Number = y2 - y1
		if (ix < 6 && ix>-23 && iy < 6 && iy>-23){
			return true;
		}
		return false;
	}
}