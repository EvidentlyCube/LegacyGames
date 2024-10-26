package game.global{
    public function Make():MakeClass{
        return MakeClass.instance;
    }
}



import net.retrocade.camel.interfaces.rIMake;
import net.retrocade.standalone.Grid9;
import net.retrocade.standalone.Text;

import game.global.Sfx;
import game.mobiles.MobileButton;

/**
 * @author ...
 */
class MakeClass implements rIMake {
    public static const instance:MakeClass = new MakeClass;
    
    public function button(onClick:Function, text:String, width:Number = NaN):* {
        var button:MobileButton = new MobileButton(onClick);
        
        var txt:Text = this.text(text, 0xFFFFFF, 32);
        txt.text = text;
        txt.x = 16 * S().sizeScaler;
        txt.y = 3 * S().sizeScaler;
        txt.fitSize();
        //txt.addShadow();
        
        button.addChild(txt);
        
        if (isNaN(width)){
            width = txt.width + 32 * S().sizeScaler;
        } else {
            width *= S().sizeScaler;
            txt.alignCenterParent(0, width);
        }
        
        var grid:Grid9 = Grid9.getGrid('buttonBG');
        grid.width  = width | 0;
        grid.height = 60 * S().sizeScaler;
        
        button.addChildAt(grid, 0);

        var grid2:Grid9 = Grid9.getGrid('buttonLitBG');
        grid2.width  = width | 0;
        grid2.height = 60 * S().sizeScaler;
        
        button.addChildAt(grid2, 1);

        button.data = { txt: txt, grid9:grid, lit:grid2 };
        
        grid2.visible = false;
        return button;
    }
    
    public function text(text:String = "", tileColor:uint = 0xFFFFFF, size:uint = 22, x:uint = 0, y:uint = 0):Text{
        var txt:Text = new Text("", "font");
        txt.text = text;
        txt.size = size * S().sizeScaler;
        
        if (tileColor != 0xFFFFFF)
            txt.color = tileColor;
        
        txt.x = x;
        txt.y = y;
        
        return txt;
    }
    
    public function textCaps(text:String = "", tileColor:uint = 0xFFFFFF, size:uint = 22, capsDiff:uint = 4):Text{
        size *= S().sizeScaler;
        capsDiff *= S().sizeScaler;
        
        var txt:Text = new Text("", "font");
        txt.size = size;
        
        text = text.toUpperCase();
        
        if (tileColor != 0xFFFFFF)
            txt.color = tileColor;
        
        var htmlText:String = '<font size="'+size+'">'+text.charAt(0)+'</font><font size="'+(size-capsDiff)+'">'+text.substr(1)+'</font>';
        txt.htmlText = htmlText;
        
        txt.setTextCaps(text, size, size - capsDiff);
            
        return txt;
    }
    
    private function onButtonRollOver():void{
        Sfx.sfxRollOver.play();
    }
}