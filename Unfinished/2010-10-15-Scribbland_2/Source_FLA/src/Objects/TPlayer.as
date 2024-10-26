package src.Objects{
    import flash.display.MovieClip;
    
    import src.IResetable;
    import src.IUpdatable;
    import src.PlatformerEngine.Controls;
    import src.PlatformerEngine.Gfx;
    import src.PlatformerEngine.Level;
    import src.PlatformerEngine.ObjInteractive;
    import src.PlatformerEngine.Obs;
    import src.PlatformerEngine.Scrolling;
    import src.PlatformerEngine.Settings;

    public class TPlayer extends ObjInteractive implements IUpdatable, IResetable{
        override public function get modX()        :Number{ return xMid - _gfx.rotation * 0.23; }
        override public function get modY()        :Number{ return yRight;                      }
        
        override public function get maxHSpeed()   :Number{ return 3;               }
                 public function get acceleration():Number{ return 0.3;             }
                 public function get brakes()      :Number{ return 0.5;             }
                 public function get direction()   :int   { return _direction;      }
                 
                 public function set direction(val:int):void{ _direction = val;     }
        
         override public function get      xCollision():Number{ return _x + Math.sin(_gfx.rotation * Math.PI / 180) * 10; }
         override public function get      yCollision():Number{ return _y - Math.cos(_gfx.rotation * Math.PI / 180) * 40 + 40; }
         override public function get  widthCollision():Number{ return _width; }
         override public function get heightCollision():Number{ return _height; }
        
        /**
         * Direction in which player is currently moving sk
         */
        private var _direction:int = 1;
        
        /**
         * Starting X position 
         */
        private var _stateStartX       :int;
        
        /**
         * Starting Y position 
         */
        private var _stateStartY       :int;
        
        /**
         * X position in last checkpoint
         */
        private var _stateLastX        :int;
        
        /**
         * Y position in last checkpoint
         */
        private var _stateLastY        :int;
        
        /**
         * Horizontal Speed in last checkpoint
         */
        private var _stateLastSpeedH   :int;
        
        /**
         * Vertical Speed in last checkpoint
         */
        private var _stateLastSpeedV   :int;
        
        /**
         * Direction in last checkpoint
         */
        private var _stateLastDirection:int;
        
        /**
         * Graphics-flag which indicates if pushing animation should be played. 
         */
        private var _gfxPushes:Boolean = false;
        
        private var _gfxRotateTo:Number = 0;
        
        private var _colliderLeft :TGraphicCollider = new TGraphicCollider;
        private var _colliderRight:TGraphicCollider = new TGraphicCollider;
        
        public function TPlayer(_x:Number, _y:Number, gfx:MovieClip){
            Obs.player  = this;
            
            x            = _x;
            y            = _y;
            _stateStartX = _x;
            _stateStartY = _y;
            _width       = 24;
            _height      = 23;
            
            _gfx         = gfx
            
            _gfx.x       = modX;
            _gfx.y       = modY;
            
            Scrolling.follow(this);
            
            Scrolling.setScroll(xMid, yMid);
            
            Gfx.frontAdd(_gfx);
            
            Obs.blockObjectAdd(this);
        }
        
        override public function update():void{
//-----------------------------------------------------------------------------
//                                                               :::CONTROLS:::
//-----------------------------------------------------------------------------
            var moveJump:Boolean = false;
            if (Controls.moveType == Controls.TYPE_ONE_BUTTON){
                moveJump          = Controls.moveJump;
                Controls.moveJump = false;
                
            } else if (Controls.moveType == Controls.TYPE_TWO_BUTTON){
                moveJump          = Controls.moveUp;
                
            } else {
                if (Controls.moveLeft){
                    direction = -1
                    
                } else if (Controls.moveRight){
                    direction =  1;
                }
                
                moveJump = Controls.moveUp;
            }
            
//-----------------------------------------------------------------------------
//                                                               :::MOVEMENT:::
//-----------------------------------------------------------------------------
            
            if (direction == -1 && Controls.moveForward){
                if (_speedh > -maxHSpeed){
                    _speedh = Math.max(_speedh - acceleration, -maxHSpeed);
                } else {
                    _speedh = Math.min(_speedh + brakes,       -maxHSpeed);
                }
            } else if (direction == 1 && Controls.moveForward){
                if (_speedh < maxHSpeed){
                    _speedh = Math.min(_speedh + acceleration, maxHSpeed);
                } else {
                    _speedh = Math.max(_speedh - brakes,       maxHSpeed);
                }
                
            } else {
                if (_speedh > 0){
                    _speedh = Math.max(_speedh - brakes, 0);
                } else {
                    _speedh = Math.min(_speedh + brakes, 0);
                }
            }
            
            _speedv += Settings.GRAVITY;
            
            _gfxPushes = false;
            //_standing  = false;
            
            push();
            
//-----------------------------------------------------------------------------
//                                                                :::JUMPING:::
//-----------------------------------------------------------------------------

            if (isOnFloor && moveJump){
                _speedv   = _climbing || _sliding? -4 : -6;
                _standing = false;
                _sliding  = false;
                _climbing = false;
            }
            
//-----------------------------------------------------------------------------
//                                                      :::ANIMATION SETTING:::
//-----------------------------------------------------------------------------
            
            if (_speedh < 0){
                _gfx.scaleX = -1;
            } else if (_speedh > 0){
                _gfx.scaleX =  1;
            }
            
            if (!isOnFloor){
                _gfx.gotoAndStop(2);
                Object(_gfx.getChildAt(0)).jumping = true;
                
            } else if (_gfxPushes){
                _gfx.gotoAndStop(3);
                
            } else if (Math.abs(_speedh) < 1){
                _gfx.gotoAndStop(1);
                
            } else {
                _gfx.gotoAndStop(2);
                Object(_gfx.getChildAt(0)).jumping = false;
            }
            
//-----------------------------------------------------------------------------
//                                          :::GRAPHIC ROTATION AND POSITION:::
//-----------------------------------------------------------------------------
            
            _colliderLeft .set(x,      yRight, isOnFloor ? 25 : 0, this);
            _colliderRight.set(xRight, yRight, isOnFloor ? 25 : 0, this);
            
            _gfxRotateTo = Math.atan2(_colliderRight.y - _colliderLeft.y, _colliderRight.x - _colliderLeft.x) * 180 / Math.PI;
            
            
            if (_colliderLeft.forceHigher && _colliderLeft.y < _colliderRight.y){
                if (_gfxRotateTo > 0){
                    _gfxRotateTo = 0;
                }
            } else if (_colliderRight.forceHigher && _colliderLeft.y > _colliderRight.y){
                if (_gfxRotateTo < 0){
                    _gfxRotateTo = 0;
                }
            }

            _gfx.rotation += (_gfxRotateTo - _gfx.rotation) * 0.4;
            _gfx.x = xMid + (_gfxPushes ? - _gfx.scaleX * 4 : 0);
            _gfx.y = yRight - Math.cos(_gfx.rotation * Math.PI / 180) * 40 + 40;
            
            
            //if (_gfx.rotation > 50 || _gfx.rotation < -50){
            //    _gfx.rotation = 0;
            //}
            
            
            Debug.circle(xCollision, yCollision, 2);
            Debug.circle(xCollision + widthCollision, yCollision, 2);
            Debug.circle(xCollision, yCollision + heightCollision, 2);
            Debug.circle(xCollision + widthCollision, yCollision + heightCollision, 2);
            
            
            if (y > Scrolling.edgeBottom + Settings.SCREEN_HEIGHT + 30){
                Death();
            }
        }
        
        override public function slide(angle:int):void{ 
            super.slide(angle);
            if (_speedv > 0){
                  _speedv = 0;
            }
        }
        
        override public function stomp():void{
            super.stomp()
            _speedv = 0;
        }
        
        // --------------------------------------------------------------------
        // ::::::::                                         CHECK POINT STUFF
        // --------------------------------------------------------------------
        
        public function stateCheckpoint():void{
            _stateLastX          = x;
            _stateLastY          = y;
            _stateLastDirection  = direction;
            _stateLastSpeedH     = _speedh;
            _stateLastSpeedV     = _speedv;
        }
        
        public function stateDeath():void{
            x           = _stateLastX;
            y           = _stateLastY;
            direction   = _stateLastDirection;
            _speedh     = _stateLastSpeedH;
            _speedv     = _stateLastSpeedV;
            
            _gfx.x      = modX;
            _gfx.y      = modY;
            
            _gfx.scaleX = direction;
        }
        
        public function stateRestart():void{
            x           = _stateStartX;
            y           = _stateStartY;
            
            _gfx.x      = modX;
            _gfx.y      = modY;
            _gfx.scaleX = direction;
            
            _speedh     = 0;
            _speedv     = 0;
            
            direction   = 1;
        }
        
        
        
        override public function pushesCrate():void{
            _gfxPushes = true;
        }
        
        public function Death():void{
            //new TEffectPlayerDeath(x, y, -speedh);
            Level.stateDeath();
        }
    }
}