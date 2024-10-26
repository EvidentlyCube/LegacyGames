package game.global.newTutorial{
    import game.global.Game;

    public class NewTutorial{
        private static var _box:TutorialBox;
        
        private static var _customBoxes:Vector.<TutorialBox>;
        
        public static function init():void{
            _customBoxes = new Vector.<TutorialBox>();
        }
        
        public static function clear():void{
            if (_customBoxes){
                for each(var box:TutorialBox in _customBoxes){
                    box.clear();
                }
            }
            
            if (_box){
                _box.clear();
            }
            
            _box = null;
            _customBoxes.length = 0;
        }
        
        public static function set(text:String, x:int, y:int, func:Function):void{
            var oldBox:TutorialBox;
            
            if (_box){
                oldBox = _box
            }
            
            _box = new TutorialBox();
            _box.text = "Tap Grabs\nColor";
            _box.textAlignCenter();
            
            Game.lMain.add(_box);
            
            _box.targetX = x;
            _box.targetY = y;
            _box.text = text;
            _box.func = func;
            
            if (oldBox){
                _box.x = oldBox.x;
                _box.y = oldBox.y;
                
                oldBox.clear();
            }
        }
        
        public static function addCustomBox(text:String, x:int, y:int, isOnStarlingLayer:Boolean, reposition:Boolean, func:Function = null, radius:Number = 0):Number{
            var box:TutorialBox = new TutorialBox();
            box.text = text;
            box.x = x;
            box.y = y;
            box.moveToX = x;
            box.moveToY = y;
            box.targetX = x;
            box.targetY = y;
            box.onStarlingLayer = isOnStarlingLayer;
            box.reposition = reposition;
            box.func = func;
            
            if (radius){
                box.circleRadius = radius;
            }
            
            _customBoxes.push(box);
            
            return box.circleRadius;
        }
        
        public static function update():void{
            if (_box){
                _box.update();
            }
            
            if (_customBoxes){
                for each(var box:TutorialBox in _customBoxes){
                    box.update();
                }
            }
        }
    }
}
import flash.display.BlendMode;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;

import game.data.TBase;
import game.data.TPath;
import game.global.Game;
import game.global.Level;
import game.global.Minimap;
import game.objects.TConnector;
import game.objects.TGameObject;

import net.retrocade.camel.global.rInput;
import net.retrocade.standalone.Text;
import net.retrocade.utils.UGraphic;
import net.retrocade.utils.UNumber;

class TutorialBox extends Text{
    public var circleRadius:Number;
    
    public var shape:Shape;
    
    public var targetX:int;
    public var targetY:int;
    
    public var moveToX:Number = 200;
    public var moveToY:Number = 200;
    
    public var onStarlingLayer:Boolean = true;
    
    public var reposition:Boolean = true;
    
    public var func:Function;
    
    public function TutorialBox(){
        super('', 'font', 24 * S().sizeScaler);
        
        textAlignCenter();
        
        shape = new Shape();
        
        addChildAt(shape, 0);
        
        targetX = 300;
        targetY = 300;
    }
    
    override public function set text(value:String):void{
        super.text = value;
        
        circleRadius = Math.max(textHeight * 0.75, textWidth * 0.75);
    }
    
    override public function get center():Number{
        return x + textWidth / 2 | 0;
    }
    
    override public function set center(value:Number):void{
        x = value - textWidth / 2 | 0;
    }
    
    override public function get middle():Number{
        return y + textHeight / 2 | 0;
    }
    
    override public function set middle(value:Number):void{
        y = value - textHeight / 2 | 0;
    }
    
    public function clear():void{
        if (parent)
            parent.removeChild(this);
        
        func = null;
    }
    
    public function update():void{
        if (!parent)
            Game.lMain.add(this);
        
        if (func != null)
            func.call(this);
        
        if (!reposition){
            x = moveToX;
            y = moveToY;
            
            const enlargedRadius:Number = circleRadius * 1.2;
            
            if (Main.isLandscape()){
                if (middle + enlargedRadius > S().gameHeight)
                    middle = S().gameHeight - enlargedRadius;
                
                if (middle - enlargedRadius < 0)
                    middle = enlargedRadius;
                
                if (center - enlargedRadius < Minimap.instance.minimapWidth)
                    center = Minimap.instance.minimapWidth + enlargedRadius;
                
                if (center + enlargedRadius > S().gameWidth)
                    center = S().gameWidth - enlargedRadius;
            } else {
                if (middle + enlargedRadius > S().gameHeight - S().portraitHudHeight)
                    middle = S().gameHeight - S().portraitHudHeight - enlargedRadius;
                
                if (middle - enlargedRadius < 0)
                    middle = enlargedRadius;
                
                if (center - enlargedRadius < 0)
                    center = enlargedRadius;
                
                if (center + enlargedRadius > S().gameWidth)
                    center = S().gameWidth - enlargedRadius;
            }
            
            UGraphic.clear(this).lineStyle(1, 0xFFFFFF).beginFill(0, 0.4).drawCircle(textWidth / 2, textHeight / 2, circleRadius).endFill();
            return;
        }
        
        const spacer:Number = circleRadius * 2;
        
        var globalX:int = targetX;
        var globalY:int = targetY;
        
        if (onStarlingLayer){
            var point:Point = Game.lStarling.starlingSprite.localToGlobal(new Point(targetX, targetY));
            
            globalX = point.x;
            globalY = point.y;
        }
        
        var distanceToTarget:Number = UNumber.distance(moveToX, moveToY, globalX, globalY);
        var angle:Number = Math.atan2(moveToY - globalY, moveToX - globalX);
        
        moveToX = globalX + Math.cos(angle) * spacer;
        moveToY = globalY + Math.sin(angle) * spacer;
        
        center = UNumber.approach(center, moveToX);
        middle = UNumber.approach(middle, moveToY);
        
        if (Main.isLandscape()){
            // Sanitize position :(
            if (center < S().playfieldOffsetX + spacer){
                if (center < globalX)
                    moveToX += 2 * (globalX - center);
                else
                    center = S().playfieldOffsetX  + spacer;
                
            } else if (center > S().gameWidth - spacer){
                if (center > globalX)
                    moveToX += 2 * (globalX - center);
                else
                    center = S().gameWidth - spacer;
            }
            
            if (middle < S().playfieldOffsetY + spacer){
                if (center < globalY)
                    moveToY += 2 * (globalY - middle);
                else
                    middle = S().playfieldOffsetY  + spacer;
            } else if (middle > S().gameHeight - spacer){
                if (middle > globalY)
                    moveToY += 2 * (globalY - middle);
                else
                    middle= S().gameHeight - spacer;
            }
        } else {
            if (center < S().playfieldOffsetX + spacer){
                if (center < globalX)
                    moveToX += 2 * (globalX - center);
                else
                    center = S().playfieldOffsetX  + spacer;
                
            } else if (center > S().gameWidth - spacer){
                if (center > globalX)
                    moveToX += 2 * (globalX - center);
                else
                    center = S().gameWidth - spacer;
            }
            
            if (middle < S().playfieldOffsetY + spacer){
                if (center < globalY)
                    moveToY += 2 * (globalY - middle);
                else
                    middle = S().playfieldOffsetY  + spacer;
            } else if (middle > S().gameHeight - spacer - S().portraitHudHeight){
                if (middle > globalY)
                    moveToY += 2 * (globalY - middle);
                else
                    middle = S().gameHeight - spacer - S().portraitHudHeight;
            }
        }
        
        angle = Math.atan2(globalY - middle, globalX - center);
        
        if (distanceToTarget > circleRadius){
            /*UGraphic.draw(this).lineStyle(1, 0xFFFFFF)
                .moveTo(center - x + Math.cos(angle) * circleRadius, middle- y + Math.sin(angle) * circleRadius)
                .lineTo(globalX - x, globalY - y);*/
        
            drawCloud(textWidth / 2, textHeight / 2, circleRadius, globalX - x, globalY - y);
        }
    }
    
    private function drawCloud(x:int, y:int, radius:int, toX:int, toY:int):void{
        var g:Graphics = shape.graphics;
        
        g.clear();
        
        g.lineStyle(2, 0xFFFFFF);
        g.beginFill(0, 1);
        
        g.drawCircle(x, y, radius);
        
        if (UNumber.distance(x, y, toX, toY) <= radius * radius){
            return;
        }
        
        var dist:Number = Math.sqrt(UNumber.distance(x, y, toX, toY));
        var angle:Number = Math.atan2(toY - y, toX - x);
        angle += dist / 600;
        
        var angleDelta:Number = 0.2;
        //radius -= 1;
        
        var cx1:Number = x + Math.cos(angle + Math.PI * angleDelta) * radius;
        var cy1:Number = y + Math.sin(angle + Math.PI * angleDelta) * radius;
        var cx2:Number = x + Math.cos(angle - Math.PI * angleDelta * dist / 200) * radius;
        var cy2:Number = y + Math.sin(angle - Math.PI * angleDelta * dist / 200) * radius;
        
        
        var curx1:Number = x + Math.cos(angle) * ((dist - radius) / 2 + radius);
        var cury1:Number = y + Math.sin(angle) * ((dist - radius) / 2 + radius);
        var curx2:Number = x + Math.cos(angle) * ((dist - radius) / 2 + radius);
        var cury2:Number = y + Math.sin(angle ) * ((dist - radius) / 2 + radius);
        
        g.beginFill(0, 1);
        g.moveTo(cx2, cy2);
        
        g.curveTo(curx1, cury1, toX, toY);
        g.curveTo(curx2, cury2, cx1, cy1);
        g.lineStyle();
        g.lineTo(cx2, cy2);
        
        shape.blendMode = BlendMode.LAYER;
        //shape.alpha = 0.5;
    }
    
    
    public function stepUpRightDownLeft():void{
        var path:TPath = Level.groupPaths.getAt(Level.groupPaths.length - 1) as TPath;
        
        if (path){
            var path2:TGameObject = Level.level.get(path.x, path.y - S().tileHeight) as TGameObject;
            if (!path2){
                targetX = path.x + S().tileWidth / 2;
                targetY = path.y - S().tileHeight / 2;
                return;
            }
            
            path2 = Level.level.get(path.x + S().tileWidth, path.y) as TGameObject;
            if (!path2){
                targetX = path.x + S().tileWidth * 3 / 2;
                targetY = path.y + S().tileHeight / 2;
                return;
            }
            
            path2 = Level.level.get(path.x, path.y + S().tileHeight) as TGameObject;
            if (!path2){
                targetX = path.x + S().tileWidth / 2;
                targetY = path.y + S().tileHeight * 3 / 2;
                return;
            }
            
            path2 = Level.level.get(path.x - S().tileWidth, path.y) as TGameObject;
            if (!path2){
                targetX = path.x - S().tileWidth / 2;
                targetY = path.y + S().tileHeight / 2;
                return;
            }
        }
    }
    
    public function swapToLastPath():void{
        var path:TPath = Level.groupPaths.getAt(Level.groupPaths.length - 1) as TPath;
        
        if (path){
            targetX = path.x + S().tileWidth / 2;
            targetY = path.y + S().tileHeight / 2;
        }
    }
    
    public function swapToNextUnconnectedBase():void{
        for each(var base:TBase in Level.groupBases.getAllOriginal()){
            if (!base.allConnected){
                targetX = base.x + S().tileWidth / 2;
                targetY = base.y + S().tileHeight / 2;
                return;
            }
        }
    }
 
    public function pointToPaths():void{
        if (Main.isLandscape()){
            targetX = Minimap.instance.minimapWidth / 2;
            targetY = Minimap.instance.minimapWidth + 20;
        } else {
            targetX = Minimap.instance.minimapWidth / 2;
            targetY = S().gameHeight - S().portraitHudHeight - 20;
        }
    }
}