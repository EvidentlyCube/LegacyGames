package game.global {
	public function Make():MakeClass {
		return MakeClass.instance;
	}
}

import game.global.Sfx;

import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
import net.retrocade.retrocamel.display.flash.RetrocamelButton;
import net.retrocade.retrocamel.display.flash.RetrocamelPreciseGrid9;
import net.retrocade.retrocamel.interfaces.IRetrocamelMake;

class MakeClass implements IRetrocamelMake {
	public static var instance:MakeClass = new MakeClass();

	public function button(onClick:Function, text:String, width:Number = NaN):* {
		var button:RetrocamelButton = new RetrocamelButton(onClick, onButtonRollOver);

		var txt:RetrocamelBitmapText = new RetrocamelBitmapText();
		txt.text = text;
		txt.x = 12;
		txt.y = 6;
		txt.scaleX = 2;
		txt.scaleY = 2;

		//txt.addShadow();

		button.addChild(txt);

		if (isNaN(width))
			width = txt.width + 22;

		var grid:RetrocamelPreciseGrid9 = RetrocamelPreciseGrid9.getGrid('buttonBG');
		grid.width = width;
		grid.height = 40;

		button.addChildAt(grid, 0);

		button.data = {txt: txt, grid9: grid};
		return button;
	}

	public function text(text:String, color:uint = 0xFFFFFF, scale:uint = 1, x:uint = 0, y:uint = 0):RetrocamelBitmapText {
		var txt:RetrocamelBitmapText = new RetrocamelBitmapText();
		txt.text = text;
		if (color != 0xFFFFFF)
			txt.color = color;

		txt.x = x;
		txt.y = y;

		txt.scaleX = scale;
		txt.scaleY = scale;

		return txt;
	}

	private function onButtonRollOver():void {
		Sfx.sfxRollOver.play();
	}
}