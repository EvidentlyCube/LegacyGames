package net.retrocade.camel.animations {
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;
    
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.retrocamel_int;
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.camel.objects.rObjectDisplay;

    use namespace retrocamel_int;
    
    public class rAnimC64 extends rObjectDisplay{
        private var _all    :Array = new Array();
        private var _effect :Shape = new Shape();
        private var _padding:Shape = new Shape();
        
        private var _scale:uint;
        
        public function rAnimC64(padColor:uint, padTop:Number = NaN, padLeft:Number = NaN, padRight:Number = NaN, padBottom:Number = NaN, scale:Number = 1) {
            _scale = scale;
            
            _gfx = new Sprite();
            Sprite(_gfx).addChild(_effect);
            
            if (!isNaN(padTop) && !isNaN(padLeft) && !isNaN(padRight) && !isNaN(padBottom)){
                _padding.graphics.beginFill(padColor);
                _padding.graphics.drawRect(padLeft, padTop, rCore._settings.SIZE_GAME_WIDTH - padLeft - padRight, 
                                                            rCore._settings.SIZE_GAME_HEIGHT - padTop - padBottom);
                Sprite(_gfx).addChild(_padding);
            }
        }
        
        public function kill():void{
            if (_gfx.parent)
                _gfx.parent.removeChild(_gfx);
            
            nullifyDefault();
        }
        
        override public function update():void {
            var hei:Number = 0;
            var max:Object = _all[0];
            var thick:Number;
            var o:Object
            var g:Graphics = _effect.graphics;
            g.clear();
            
            while (hei < rCore._settings.SIZE_GAME_HEIGHT) {
                for each(o in _all) {
                    o.count += Math.random() * o.probability;
                    if (o.count > max.count)
                        max = o;
                }
                
                max.count = 0;
                
                thick = (max.max - max.min) * Math.random() + max.min;
                thick *= _scale;
                g.beginFill(max.color);
                g.drawRect(0, hei, rCore._settings.SIZE_GAME_WIDTH, thick);
                hei += thick;
            }
        }
        
        public function add(color:uint, minThick:Number, maxThick:Number, probability:Number):void {
            _all.push({
                color:       color, 
                min:         minThick, 
                max:         maxThick, 
                probability: probability, 
                count:       0.0 
            });
        }
    }
}