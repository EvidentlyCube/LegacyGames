	// ActionScript file
package Editor{
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType

	public function MakeText2(txt:String = "",size:uint = 18,distance:uint = 2,strength:Number = 1,blur:uint = 2):TextField{
		var tf:TextField = new TextField;
		tf.width = 1
		tf.embedFonts = true
		tf.selectable = false
		tf.antiAliasType = AntiAliasType.ADVANCED
		tf.htmlText = "<font face='fonter' color='#FFFFFF' size='" + size + "'>"+txt + "</font>";
		tf.autoSize = TextFieldAutoSize.LEFT
		//tf.backgroundColor = 0x888888
		var filArr:Array = tf.filters
		var filShad:DropShadowFilter = new DropShadowFilter(distance,45,0,1,blur,blur,strength)
		filArr.push(filShad);
		tf.filters = filArr
		return tf;
	}

}