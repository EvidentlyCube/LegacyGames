	// ActionScript file
package Editor{
	import flash.filters.DropShadowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public function MakeText3(txt: String="", size: uint = 18, align: String="", width: uint = 100, color: String="#FFFFFF"): TextField{
		var tf: TextField = new TextField;
		tf.width = width
		tf.embedFonts = true
		tf.selectable = false
		tf.wordWrap = true
		tf.antiAliasType = AntiAliasType.ADVANCED
		tf.htmlText="<p align='"+align+"'><font face='fonter' color='"+color+"' size='"+size+"'>"+txt+"</font></p>";
		tf.autoSize = TextFieldAutoSize.NONE
		//tf.backgroundColor = 0x888888
		var filArr: Array = tf.filters
		var filShad: DropShadowFilter = new DropShadowFilter(2, 45, 0,1, 2,2, 1)
		filArr.push(filShad);
		tf.filters = filArr
		return tf;
	}

}