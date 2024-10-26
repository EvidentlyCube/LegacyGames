package game.global {
	public function Make():Make_Impl {
		return Make_Impl.instance;
	}
}

import game.global.Sfx;

import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.Shape;
import flash.geom.Matrix;

import net.retrocade.standalone.Bitext;
import net.retrocade.standalone.Button;
import net.retrocade.standalone.Grid9;
import net.retrocade.standalone.Text;
import net.retrocade.utils.UGraphic;
import net.retrocade.camel.interfaces.rIMake;

class Make_Impl implements rIMake {
	public static var instance:Make_Impl = new Make_Impl();

    public function button(onClick:Function, text:String, width:Number = NaN):Button {
        var button:Button = new Button(onClick, onButtonRollOver);

        var txt:Bitext = new Bitext();
        txt.text = text;
        txt.x = 12;
        txt.y = 12;
        txt.scaleX = 2;
        txt.scaleY = 2;

        //txt.addShadow();

        button.addChild(txt);

        if (isNaN(width))
            width = txt.width + 22;

        var grid:Grid9 = Grid9.getGrid('buttonBG');
        grid.width  = width;
        grid.height = 44;

        button.addChildAt(grid, 0);

        button.data = { txt: txt, grid9:grid };
        return button;
    }

    public function text(text:String, color:uint = 0xFFFFFF, scale:uint = 1, x:uint = 0, y:uint = 0):Bitext{
        var txt:Bitext = new Bitext();
        txt.text = text;
        if (color != 0xFFFFFF)
            txt.color = color;

        txt.x = x;
        txt.y = y;

        txt.scaleX = scale;
        txt.scaleY = scale;

        return txt;
    }

    private var _textures:Array = [];
    public function textTexture(colors:Array, alphas:Array, ratios:Array, height:uint):BitmapData{
        var key:String = colors.toString() + "|" + alphas.toString() + "|" + ratios.toString();
        if (_textures[key])
            return _textures[key];

        var shape:Shape = new Shape();
        var matrix:Matrix = new Matrix();

        matrix.createGradientBox(S().swfWidth, height, Math.PI/2);

        shape.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
        shape.graphics.drawRect(0, 0, S().swfWidth, height);

        var bitmapData:BitmapData = new BitmapData(S().swfWidth, height);
        bitmapData.draw(shape);

        _textures[key] = bitmapData;

        return bitmapData;
    }

    private function onButtonRollOver():void{
        Sfx.sfxRollOverPlay();
    }
}