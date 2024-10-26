package src.PlatformerEngine{
    import src.Objects.Crate;
    
    public class ObjInteractive extends ObjDisplay{
              //public function get FLAG_HEAVY()      :Boolean{ return true;            } //HEAVY objects can affect Buttons and push crates
            
        /** 
         * Horizontal offset of the graphic in relation to bounding box
         */
              public function get modX()            :Number { return 0;               }
              
        /** 
         * Vertical offset of the graphic in relation to bounding box
         */
              public function get modY()            :Number { return 0;               }
        
        /** 
         * Maximum horizontal speed of an object
         */
              public function get maxHSpeed()       :Number { return 1;               }
        
        /** 
         * Maximum vertical speed of an object
         */ 
              public function get maxVSpeed()       :Number { return 10;              }
        
        /** 
         * Left edge of the bounding box
         */
        final public function get x()               :Number { return Math.round(_x);  }
        
        /** 
         * Top edge of the bounding box
         */
        final public function get y()               :Number { return Math.round(_y);  }
        
        /** 
         * Horizontal center of the bounding box
         */
        final public function get xMid()            :Number { return x + _width  / 2; }
        
        /** 
         * Vertical center of the bounding box
         */
        final public function get yMid()            :Number { return y + _height / 2; }
        
        /** 
         * Right edge of the bounding box
         */
        final public function get xRight()          :Number { return x + _width  - 1; }
        
        /** 
         * Bottom edge of the bounding box
         */
        final public function get yRight()          :Number { return y + _height - 1; }
        
        /** 
         * Horizontal speed of the object
         */
        final public function get speedh()          :Number { return _speedh;         }
        
        /** 
         * Vertical speed of the object
         */
        final public function get speedv()          :Number { return _speedv;         }
        
        /** 
         * Width, in pixels, of the object
         */
        final public function get width()           :Number { return _width;          }
        
        /** 
         * Height, in pixels, of the object
         */
        final public function get height()          :Number { return _height;         }
        
        /** 
         * Returns true if the object is climbing
         */
        final public function get isClimbing()      :Boolean{ return _climbing;       }
        
        /** 
         * Returns true if the object is standing on a flat terrain
         */
        final public function get isStanding()      :Boolean{ return _standing;       }
        
        /** 
         * Returns true if the object is standing on or moving down a slope
         */
        final public function get isSliding()       :Boolean{ return _sliding;        }
        
        /** 
         * Returns true if the object is on the floor
         */
        final public function get isOnFloor()       :Boolean{ return _climbing || _standing || _sliding; }
        
        public function get xCollision():Number{
            return _x;
        }
        
        public function get yCollision():Number{
            return _y;
        }
        
        public function get widthCollision():Number{
            return _width;
        }
        
        public function get heightCollision():Number{
            return _height;
        }
        
        
        final public function set x     (num:Number):void   { _x = num;               }
        final public function set y     (num:Number):void   { _y = num;               }
        final public function set xMid  (num:Number):void   { _x = num - _width  / 2; }
        final public function set yMid  (num:Number):void   { _y = num - _height / 2; }
        final public function set xRight(num:Number):void   { _x = num - _width  + 1; }
        final public function set yRight(num:Number):void   { _y = num - _height + 1; }
        
        /** 
         * Modifies object's horizontal speed
         */
        final public function modifySpeedH(offset:Number=0, perc:Number=1, maxOffset:Number=0, maxPerc:Number=1):Number{
            _speedh = _speedh * perc + offset;
            
            var newMax:Number = maxHSpeed * maxPerc + maxOffset;
            
            if (_speedh > newMax){
                _speedh = newMax;
                
            } else if (_speedh < -newMax){
                _speedh = -newMax;
            }
            
            return _speedh;
        }
        
        
        /** 
         * Modifies object's vertical speed
         */
        final public function modifySpeedV(offset:Number=0, perc:Number=1, maxOffset:Number=0, maxPerc:Number=1):Number{
            _speedv = _speedv * perc + offset;
            
            var newMax:Number = maxVSpeed * maxPerc + maxOffset;
            
            if (_speedv > newMax){
                _speedv = newMax;
                
            } else if (_speedv < -newMax){
                _speedv = -newMax;
            }
            
            return _speedv;
        }
        
        /** 
         * Can only be called from within the object, it tells the object to move by speedh and speedv
         */
        final protected function push():void{
            if (_speedh > 0){
                moveRight();
            } else if (_speedh < 0){
                moveLeft();
            }
            
            movedH();
            
            if (_speedv > 0){
                moveDown();
            } else if (_speedv < 0){
                moveUp();
            }
            
            movedV();
        }
        
        /** 
         * Called by the push() method to move the object rightwards
         * @private
         */
        final private function moveRight():void{
            var nextX:Number = xRight;
            var endX :Number = xRight + Math.floor(_speedh);
            
            while(nextX < endX && _speedh > 0){
                nextX = Math.min(endX, Math.floor((nextX + 1) / Settings.TILE_WIDTH) * Settings.TILE_WIDTH + Settings.TILE_WIDTH - 1);

                if (   Tile.__pokedLeft(nextX, y, true, this) || Tile.__pokedLeft(nextX, yRight, false, this)       //COLLISION OCCURS!
                    || Crate.__pokeLeft(nextX, y, true, this) || Crate.__pokeLeft(nextX, yRight, false, this)){
                    return;
                }
            }

            _x += Math.floor(_speedh);
        }
        
        /** 
         * Called by the push() method to move the object leftwards
         * @private
         */
        final private function moveLeft():void{
            var nextX:Number = x;
            var endX :Number = x + Math.ceil(_speedh);
            
            while(nextX > endX && _speedh < 0){
                nextX = Math.max(endX, Math.floor((nextX - 1) / Settings.TILE_WIDTH) * Settings.TILE_WIDTH);
                
                if (   Tile.__pokedRight(nextX, y, true, this) || Tile.__pokedRight(nextX, yRight, false, this)     //COLLISION OCCURS!
                    || Crate.__pokeRight(nextX, y, true, this) || Crate.__pokeRight(nextX, yRight, false, this)){
                    return;
                } 
                
            }

            _x += Math.ceil(_speedh);
        }
        
        /** 
         * Called by the push() method to move the object upwards
         * @private
         */
        final private function moveUp():void{
            var nextY:Number = y;
            var endY :Number = y + _speedv;
            
            while(nextY > endY && _speedv < 0){
                nextY = Math.max(endY, Math.floor((nextY - 1) / Settings.TILE_HEIGHT) * Settings.TILE_HEIGHT);
                
                if (    Tile.__headbutt(x, nextY, true, this) ||  Tile.__headbutt(xRight, nextY, false, this)       //COLLISION OCCURS!
                    || Crate.__headbutt(x, nextY, true, this) || Crate.__headbutt(xRight, nextY, false, this)){
                    return;
                }
            }
            
            _y += _speedv;
        }
        
        /** 
         * Called by the push() method to move the object downwards.
         * It differs from other movement methods as it has extended range towards the floor to create the effect of object running down the slope.
         * @private
         */
        final private function moveDown():void{
            //Variables for collision checks against crates
            var nextY   :Number = yRight;
            var endY    :Number = yRight + Math.max(1, Math.round(_speedv));
            
            //Variables for collision checks against walls
            var nextYext:Number = yRight;
            var endYext :Number = yRight + Math.max(1, Math.round(_speedv)) + (_standing || _sliding || _climbing? Settings.TILE_HEIGHT / 2 : 0);
            
            
            while(_speedv > 0 && nextY < endY || nextYext < endYext){
                nextY    = Math.min(endY,    Math.floor((nextY    + 1) / Settings.TILE_HEIGHT) * Settings.TILE_HEIGHT + Settings.TILE_HEIGHT - 1);
                nextYext = Math.min(endYext, Math.floor((nextYext + 1) / Settings.TILE_HEIGHT) * Settings.TILE_HEIGHT + Settings.TILE_HEIGHT - 1);
                
                if (   Crate.__stomp(x, nextY,    true, this) || Crate.__stomp(xRight, nextY,    false, this)       //COLLISION OCCURS!
                    ||  Tile.__stomp(x, nextYext, true, this) ||  Tile.__stomp(xRight, nextYext, false, this)){
                    return;
                }
            }
            
            //Collision did not occur so we reset the standing state flags.
            _sliding  = false;
            _standing = false;
            _climbing = false;
            
            _y       += Math.round(_speedv);
        }
        
        
        /** 
         * Called when object has finished horizontal move.
         */
        protected function movedH():void{}
        
        /**
         * Called when object has finished vertical move. 
         */
        protected function movedV():void{}
        
        /** 
         * Y position of the object's bounding box
         */
        protected var _x            :Number;
        
        /** 
         * X position of the object's bounding box
         */
        protected var _y            :Number;
        
        /** 
         * Width of the bounding box of an object
         */
        protected var _width        :Number;
        
        /** 
         * Height of the bounding box of an object
         */
        protected var _height       :Number;
        
        /** 
         * Horizontal speed of an object
         */
        protected var _speedh       :Number  = 0;
        
        /** 
         * Vertical speed of an object
         */
        protected var _speedv       :Number  = 0;
        
        /** 
         * A flag indicating if object is moving down a slope or stands on one
         */
        protected var _sliding      :Boolean = false;
        
        /** 
         * A flag indicating if object is standing on a flat terrain
         */
        protected var _standing     :Boolean = false;
        
        /** 
         * A flag indicating if object is climbing a slope
         */
        protected var _climbing     :Boolean = false;
        
        /**
         * Direction of the slide
         */
        protected var _slopeAngle   :int     = 0;
        
        /**
         * Called when object lands, is standing on or is moving down a slope
         * @param angle Angle of the slope
         */
        public function slide(angle:int):void{
            _sliding    = true;
            _standing   = false;
            _climbing   = false;
            
            _slopeAngle = angle;
        }
        
        /**
         * Called when object is standing or lands on a flat terrain  
         */
        public function stomp()         :void{
            _sliding    = false;
            _standing   = true;
            _climbing   = false;
            
            _slopeAngle = 0;
        }
        
        /**
         * Called when object moves up a slope
         * @param angle Angle of the slope
         */
        public function climb(angle:int):void{
            _sliding    = false;
            _standing   = false;
            _climbing   = true;
            
            _slopeAngle = angle;
        }
        
        /**
         * Called when object hits wall from the bottom 
         */
        public function headButt()   :void{}
        
        /** 
         * Called when object hits wall from the left
         */
        public function hitLeft()    :void{}
        
        /** 
         * Called when object hits well from the right
         */
        public function hitRight()   :void{}
        
        /** 
         * Called when object attempts to push a crate
         */
        public function pushesCrate():void{}
    }
}