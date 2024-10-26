package game.objects{
    import game.global.Game;
    import game.global.Level;
    import game.tiles.TTile;
    
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.objects.rObjectDisplay;
    import net.retrocade.camel.rCollide;
    
    public class TGameObject extends rObjectDisplay{
        public static var gameSpeed:uint = 6;
        
        public var mx:Number = 0;
        public var my:Number = 0;
        
        public var lastX:int;
        public var lastY:int;
        
        public var movementWait:uint = 0;
        public var crossingEdge:Boolean = false;
        
        public var isAlternate :Boolean = false;
        
        public var isMoving    :Boolean = false;
        
        public var stopNow     :Boolean = false;
        
        public var isAlive     :Boolean = true;
        
        override public function get defaultGroup():rGroup{
            return Level.active;
        }
        
        public function get preciseX():Number{
            return _x - mx * 24 * (movementWait / gameSpeed)
        }
        
        public function get preciseY():Number{
            return _y - my * 24 * (movementWait / gameSpeed)
        }
        
        public function getAt(x:int, y:int):TTile{
            return Level.level.get(x, y);
        }
        
        public function getAtDelta(dx:int, dy:int):TTile{
            dx += x / 24 | 0;
            dy += y / 24 | 0;
            
            if (dx <  0)            dx += Level.widthTiles;
            if (dy <  0)            dy += Level.heightTiles;
            if (dx >= Level.widthTiles)  dx -= Level.widthTiles;
            if (dy >= Level.heightTiles) dy -= Level.heightTiles;
            
            return Level.level.get(dx * 24, dy * 24);
        }
        
        public function enters(object:TGameObject, tx:int, ty:int):Boolean{
            return true;
        }
        
        public function leaves(object:TGameObject, tx:int, ty:int):Boolean{
            return true;
        }
        
        public function movedInto(object:TGameObject, tx:int, ty:int):void{}
        
        public function touched(object:TGameObject):void{}
        
        public function move(tx:int, ty:int, force:Boolean = false):Boolean{
            if (movementWait || !isAlive)
                return false;
            
            mx = tx;
            my = ty;
            
            var currTile:TTile = getAtDelta(0, 0);
            if (!currTile.leaves(this, mx, my) && !force){
                mx = my = 0;
                isMoving = false;
                return false;
            }
            
            var newTile:TTile = getAtDelta(mx, my);
            if (!newTile.enters(this, mx, my) && !force){
                mx = my = 0;
                isMoving = false;
                return false;
            }
            
            newTile = getAtDelta(mx, my);
            
            isMoving     = true;
            movementWait = gameSpeed;
            
            lastX = x;
            lastY = y;
            
            x += mx * 24;
            y += my * 24;
            
            if (x <  0)                  { x += Level.widthPixels;  crossingEdge = true; }
            if (y <  0)                  { y += Level.heightPixels; crossingEdge = true; }
            if (x >= Level.widthPixels)  { x -= Level.widthPixels;  crossingEdge = true; }
            if (y >= Level.heightPixels) { y -= Level.heightPixels; crossingEdge = true; }
            
            newTile.addObject(this);
            
            return true;
        }
        
        /* Only callable as a subsidiary of move(), return the value returned by this function! */
        public function redirect(newMX:int, newMY:int):Boolean{
            mx = newMX;
            my = newMY;
            
            var currTile:TTile = getAtDelta(0, 0);
            if (!currTile.leaves(this, mx, my))
                return false;
            
            var newTile:TTile = getAtDelta(mx, my);
            if (!newTile.enters(this, mx, my))
                return false;
            
            return true;
        }
        
        override public function update():void{
            if (movementWait){
                movementWait--;
                
                if (movementWait == 0){
                    var lastTile:TTile = getAt(lastX, lastY);
                    lastTile.removeObject(this);
                    lastX = x;
                    lastY = y;
                    crossingEdge = false;
                    
                    getAt(x, y).movedInto(this, mx, my);
                    
                    if (stopNow){
                        mx = my = 0;
                        stopNow = false;
                    }
                }
            }
        }
        
        override public function draw():void{
            Game.lGame.draw(_gfx, preciseX, preciseY);
            
            if (crossingEdge){
                Game.lGame.draw(_gfx, preciseX + Level.widthPixels, preciseY);
                Game.lGame.draw(_gfx, preciseX - Level.widthPixels, preciseY);
                Game.lGame.draw(_gfx, preciseX,                    preciseY + Level.heightPixels);
                Game.lGame.draw(_gfx, preciseX,                    preciseY - Level.widthPixels);
            }
        }
        
        public function stop():void{
            if (movementWait){
                stopNow = true;
                return;
            }
            
            mx = my = 0;
            isMoving = false;
        }
        
        public function toggle():void{
            
        }
        
        public function kill():void{
            getAt(x, y).removeObject(this);
            getAt(lastX, lastY).removeObject(this);
            nullifyDefault();
            
            isAlive = false;
        }
        
        public function bitmapCollision(object:TGameObject):Boolean{
            var x1:uint = preciseX;
            var y1:uint = preciseY;
            var x2:uint = object.preciseX;
            var y2:uint = object.preciseY;
            
            if (Math.abs(x1 - x2) > 24){
                if (Math.abs(x1 - Level.widthPixels - x2) <= 24){
                    x1 -= Level.widthPixels;
                } else {
                    x2 -= Level.widthPixels;
                }
            }
            
            if (Math.abs(y1 - y2) > 24){
                if (Math.abs(y1 - Level.heightPixels - y2) <= 24){
                    y1 -= Level.heightPixels;
                } else {
                    y2 -= Level.heightPixels;
                }
            }
            
            return rCollide.bitmap(_gfx, x1, y1, 1, 1, 0, object._gfx, x2, y2, 1, 1, 0);
        }
        
        public function setPosition(toX:uint, toY:uint):void{
            getAt(x, y).removeObject(this);
            x = toX;
            y = toY;
            lastX = toX;
            lastY = toY;
            getAt(x, y).addObject(this);
        }
        
        public function frameFromDelta(mx:int, my:int):uint{
            if (mx == 1)
                return 0;
            else if (mx == -1)
                return 2;
            else if (my == 1)
                return 1;
            else
                return 3;
        }
        
        public function mouseOver():void{
            
        }
    }
}