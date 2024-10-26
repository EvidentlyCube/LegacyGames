package game.global {
    import net.retrocade.camel.interfaces.rIMake;

    public function Make():MakeClass{
        return MakeClass.instance;
    }
}

import net.retrocade.camel.interfaces.rIMake;
import net.retrocade.standalone.Button;
import net.retrocade.standalone.Grid9;
import net.retrocade.standalone.Text;
import net.retrocade.utils.UGraphic;

import game.global.Sfx;

class MakeClass implements rIMake{
    public static var instance:MakeClass = new MakeClass();

    public function button(onClick:Function, text:String, width:Number = NaN):Button {
        var button:Button = new Button(onClick, onButtonRollOver);

        var txt:Text = new Text(text, "font", 18);
        txt.x = 11;
        txt.y = 7;

        button.addChild(txt);

        if (isNaN(width))
            width = txt.width + 22;

        var grid:Grid9 = Grid9.getGrid('buttonBG');
        grid.width  = width;
        grid.height = 40;

        button.addChildAt(grid, 0);

        txt.alignCenterParent();

        txt.setShadow();

        button.data = { txt: txt, grid9:grid };
        return button;
    }

    public function buttonSmall(onClick:Function, text:String, width:Number = NaN):Button {
        var button:Button = new Button(onClick, onButtonRollOver);

        var txt:Text = new Text(text, "font", 12);
        txt.x = 11;
        txt.y = 5;

        //txt.addShadow();

        button.addChild(txt);

        if (isNaN(width))
            width = txt.width + 22;

        var grid:Grid9 = Grid9.getGrid('buttonBG');
        grid.width  = width;
        grid.height = 30;

        button.addChildAt(grid, 0);

        txt.alignCenterParent();

        button.data = { txt: txt, grid9:grid };
        return button;
    }

    public function buttonSound(onClick:Function):Button {
        var button:Button = new Button(onClick, onButtonRollOver);

        return button;
    }

    private function onButtonRollOver():void{
        Sfx.rollOver();
    }

    private function onButtonClick():void{
        Sfx.click();
    }
}