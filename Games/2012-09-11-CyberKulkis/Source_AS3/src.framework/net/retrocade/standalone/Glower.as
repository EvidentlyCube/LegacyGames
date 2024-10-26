package net.retrocade.standalone{
    import flash.display.DisplayObject;
    import flash.filters.ColorMatrixFilter;
    import flash.filters.GlowFilter;
    
    import net.retrocade.utils.UNumber;
    import net.retrocade.utils.UString;
    
    public class Glower{
        /**
         * If set to true whenever you make changes to any of the properties the changes are automatically applied, otherwise you have to manually call apply()
         */
        public var autoApply:Boolean = true;
        
        private var _displayObject          :DisplayObject;
        private var _currentlyUsedFilterHash:String = "";
        
        private var _alpha   :Number;
        private var _blurX   :Number;
        private var _blurY   :Number;
        private var _color   :Number;
        private var _inner   :Boolean;
        private var _knockout:Boolean;
        private var _quality :int;
        private var _strength:Number;
        
        public function Glower(displayObject :DisplayObject = null,
                                  color         :uint          = 0xFF0000, strength    :Number  = 2.0,   alpha    :Number  = 1.0,
                                  blurX         :Number        = 6.0,      blurY       :Number  = 6.0,   quality  :int     = 1,
                                  inner         :Boolean       = false,    knockout    :Boolean = false, autoApply:Boolean = true){
            
            this.autoApply = autoApply;
            
            _displayObject = displayObject;
            
            setAll(color, strength, alpha, blurX, blurY, quality, inner, knockout);
        }
        
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Set all parameters
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        
        public function setAll(color         :uint          = 0xFF0000, strength    :Number  = 2.0,   alpha    :Number = 1.0,
                               blurX         :Number        = 6.0,      blurY       :Number  = 6.0,   quality  :int    = 1,
                               inner         :Boolean       = false,    knockout    :Boolean = false):void{
            this.alpha    = alpha;
            this.blurX    = blurX;
            this.blurY    = blurY;
            _color    = color;
            _inner    = inner;
            _knockout = knockout;
            this.quality  = quality;
            this.strength = strength;
            
            calculate();
        }
        
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Set parameter groups
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        
        public function set blur(blur:Number):void{
            this.blurX = this.blurY = blur;
        }
        
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Set single parameters
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        
        public function set alpha(value:Number):void{
            _alpha = UNumber.limit(value, 1, 0);
            
            calculate();
        }
        
        public function set blurX(value:Number):void{
            _blurX = UNumber.limit(value, 255, 0);
            
            calculate();
        }
        
        public function set blurY(value:Number):void{
            _blurY = UNumber.limit(value, 255, 0);
            
            calculate();
        }
        
        public function set color(value:uint):void{
            _color = value;
            
            calculate();
        }
        
        public function set inner(value:Boolean):void{
            _inner = value;
            
            calculate();
        }
        
        public function set knockout(value:Boolean):void{
            _knockout = value;
            
            calculate();
        }
        
        public function set quality(value:int):void{
            _quality = UNumber.limit(value, 15, 1);
            
            calculate();
        }
        
        public function set strength(value:Number):void{
            _strength = UNumber.limit(value, 255, 0);;
            
            calculate();
        }
        
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Change display object
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        
        public function set displayObject(d:DisplayObject):void{
            if (d == _displayObject)
                return;
            
            removeFilterFromDisplayObject();
            
            _displayObject = d;
            calculate();
        }
        
        public function get displayObject():DisplayObject{
            return _displayObject;
        }
        
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Getters
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        
        public function get alpha   ():Number { return _alpha;   }
        public function get blurX   ():Number { return _blurX;    }
        public function get blurY   ():Number { return _blurY;    }
        
        public function get color   ():uint   { return _color;    }
        public function get inner   ():Boolean{ return _inner;    }
        public function get knockout():Boolean{ return _knockout; }
        
        public function get quality ():int    { return _quality;  }
        public function get strength():Number { return _strength; }
        
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Update
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        
        /**
         * Applies all changes to the display object 
         */
        public function apply():void{
            calculate(true);
        }
        
        private function calculate(forceUpdate:Boolean = false):void{
            if (autoApply || forceUpdate)
                update();
        }
        
        private function update():void{
            if (!_displayObject)
                return;
            
            var filterArray   :Array   = _displayObject.filters ? _displayObject.filters : [];
            var found         :Boolean = false;
            var filterIterator:Object;
            var filterInstance:GlowFilter;
            
            for each(filterIterator in filterArray){
                if ((filterInstance = filterIterator as GlowFilter) === null)
                    continue;
                
                if (getHashFromObject(filterInstance) == _currentlyUsedFilterHash){
                    setFields(filterInstance);
                    found = true;
                    break;
                }
            }
            
            if (!found)
                filterArray[filterArray.length] = setFields(new GlowFilter);
            
            _displayObject.filters = filterArray;
            
            _currentlyUsedFilterHash = getHash();
        }
        
        private function removeFilterFromDisplayObject():void{
            var filterArray   :Array = _displayObject ? _displayObject.filters : null;
            var filterIterator:Object;
            var filterInstance:GlowFilter;
            
            if (filterArray === null)
                return;
            
            for each(filterIterator in filterArray){
                if ((filterInstance = filterIterator as GlowFilter) === null)
                    continue;
                
                if (getHashFromObject(filterInstance) == _currentlyUsedFilterHash){
                    filterArray.splice(filterArray.indexOf(filterInstance), 1);
                    return;
                }
            }
        }
        
        private function setFields(o:GlowFilter):GlowFilter{
            o.alpha    = _alpha;
            o.blurX    = _blurX;
            o.blurY    = _blurY;
            o.color    = _color;
            o.inner    = _inner;
            o.knockout = _knockout;
            o.quality  = _quality;
            o.strength = _strength;
            
            return o;
        }
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Hash Generating
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        
        private function getHash():String{
            return UString.join(",", _alpha, _blurX, _blurY, _color, _inner, _knockout, _quality, _strength);
        }
        
        private function getHashFromObject(o:GlowFilter):String{
            return UString.join(",", o.alpha, o.blurX, o.blurY, o.color, o.inner, o.knockout, o.quality, o.strength);
        }
    }
}