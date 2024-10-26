package net.retrocade.camel.engines.pixelball{
    import flash.display.DisplayObject;
    public class rPixelBallEngine {
        private static const DEGtoRAD   :Number = 0.0174532925;
        
        public var terrain    :DisplayObject;
        
        public function updateObject(ball:rIPixelBall, gravityX:Number, gravityY:Number):void {
            for (var j:int = 1; j <= ball.steps; j++) {
                var numberOfCollisions:int    = 0;
                var sumX     :Number = 0;
                var sumY     :Number = 0;
                
                if (ball.speedH > ball.maxSpeedH) {
                    ball.speedH = ball.maxSpeedH;
                    
                } else if (ball.speedH < -ball.maxSpeedH) {
                    ball.speedH = -ball.maxSpeedH;
                }
                
                if (ball.speedV > ball.maxSpeedV){
                    ball.speedV = ball.maxSpeedV;
                    
                } else if (ball.speedV < -ball.maxSpeedV) {
                    ball.speedV = -ball.maxSpeedV;
                }
                
                ball.x += ball.speedH / ball.steps;
                ball.y += ball.speedV / ball.steps;
                
                ball.speedH += gravityX / ball.steps;
                ball.speedV += gravityY / ball.steps;
                
                
                for (var i:int = ball.precision; i > 0 ; i--) {
                    var testX:Number = ball.x + ball.radius * Math.sin(i * 360 / ball.precision * DEGtoRAD);
                    var testY:Number = ball.y - ball.radius * Math.cos(i * 360 / ball.precision * DEGtoRAD);
                    
                    if (terrain.hitTestPoint(testX, testY, true)) {
                        numberOfCollisions++;
                        
                        sumX += testX;
                        sumY += testY;
                    }
                }
                
                var averageX:Number = sumX / numberOfCollisions;
                var averageY:Number = sumY / numberOfCollisions;
                
                if (numberOfCollisions > 0) {
                    var collisionAngle:Number = Math.atan2(ball.x - averageX, ball.y - averageY) / -DEGtoRAD + 90;
                    var collisionX    :Number = ball.x - ball.radius * Math.sin((collisionAngle + 90) * DEGtoRAD);
                    var collisionY    :Number = ball.y + ball.radius * Math.cos((collisionAngle + 90) * DEGtoRAD);
                    var deltaX        :Number = (collisionX - ball.x) / ball.radius * -1;
                    var deltaY        :Number = (collisionY - ball.y) / ball.radius * -1;
                    var speed         :Number = Math.sqrt(ball.speedH * ball.speedH + ball.speedV * ball.speedV) * ball.friction;
                    var bounce        :Number = Math.atan2(ball.speedH, ball.speedV) / -DEGtoRAD;
                    var ricochet      :Number = 2 * collisionAngle - bounce - 180;
                    
                    ball.speedH =   Math.sin(ricochet * DEGtoRAD) * speed;
                    ball.speedV = - Math.cos(ricochet * DEGtoRAD) * speed;
                    while (terrain.hitTestPoint(collisionX, collisionY,true)) {
                        ball.x += deltaX;
                        ball.y += deltaY;
                        collisionX = ball.x - deltaX * ball.radius;
                        collisionY = ball.y - deltaY * ball.radius;
                    }
                }
            }
        }
    }
}