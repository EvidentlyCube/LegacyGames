package submuncher.ingame.renderers.gameObjects {
    import net.retrocade.enums.Direction4;
    import net.retrocade.utils.UtilsAngle;

    import starling.display.Image;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;
    import submuncher.ingame.gameObjects.EnemyEelSegment;
    import submuncher.ingame.gameObjects.ObjectPlayer;
    import submuncher.ingame.gameObjects.helpers.IEelSegment;

    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererEelSegment extends GameObjectRendererBase{
        private static var _counter:Number = 0;
        private var _secondSegment:Image;
        private var _thirdSegmnet:Image;
        private var _fourthSegment:Image;
        private var _fifthSegment:Image;
        private var _sixthSegment:Image;

        private function get eel():EnemyEelSegment{
            return gameObject as EnemyEelSegment;
        }

        public function GameObjectRendererEelSegment(gameObject:EnemyEelSegment, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            x = gameObject.x;
            y = gameObject.y;

            texture = Gfx.spritesAtlas.getTexture(SpriteNames.EEL_BODY);
            readjustSize();
            pivotX = 8;
            pivotY = 8;
            _secondSegment = new Image(texture);
            _secondSegment.pivotX = 8;
            _secondSegment.pivotY = 8;

            _secondSegment.x = 8;
            _secondSegment.y = 8;

            _thirdSegmnet = new Image(texture);
            _thirdSegmnet.pivotX = 8;
            _thirdSegmnet.pivotY = 8;

            _thirdSegmnet.x = 8;
            _thirdSegmnet.y = 8;

            _fourthSegment = new Image(texture);
            _fourthSegment.pivotX = 8;
            _fourthSegment.pivotY = 8;

            _fourthSegment.x = 8;
            _fourthSegment.y = 8;

            _fifthSegment = new Image(texture);
            _fifthSegment.pivotX = 8;
            _fifthSegment.pivotY = 8;

            _fifthSegment.x = 8;
            _fifthSegment.y = 8;

            _sixthSegment = new Image(texture);
            _sixthSegment.pivotX = 8;
            _sixthSegment.pivotY = 8;

            _sixthSegment.x = 8;
            _sixthSegment.y = 8;


            _counter += 0.006;
            z -= _counter;
            _secondSegment.z = z + 0.001;
            _thirdSegmnet.z = z + 0.002;
            _fourthSegment.z = z + 0.003;
            _fifthSegment.z = z + 0.004;
            _sixthSegment.z = z + 0.005;
//            _counter += 0.001;
            update();

            gameCommunication.onGameObjectImageCreated.call(_secondSegment);
            gameCommunication.onGameObjectImageCreated.call(_thirdSegmnet);
            gameCommunication.onGameObjectImageCreated.call(_fourthSegment);
            gameCommunication.onGameObjectImageCreated.call(_fifthSegment);
            gameCommunication.onGameObjectImageCreated.call(_sixthSegment);
        }

        override public function dispose():void {
            gameCommunication.onGameObjectImageRemoved.call(_secondSegment);
            gameCommunication.onGameObjectImageRemoved.call(_thirdSegmnet);
            gameCommunication.onGameObjectImageRemoved.call(_fourthSegment);
            gameCommunication.onGameObjectImageRemoved.call(_fifthSegment);
            gameCommunication.onGameObjectImageRemoved.call(_sixthSegment);
            _secondSegment.dispose();

            _secondSegment = null;

            super.dispose();
        }

        override public function update():void{
            var movementPosition:Number = eel.getMovementCounterPosition();
            rotation = getRotationForSegment(eel, movementPosition);

            setSubSegmentPosition(_secondSegment, movementPosition, 1/5);
            setSubSegmentPosition(_thirdSegmnet, movementPosition, 2/5);
            setSubSegmentPosition(_fourthSegment, movementPosition, 3/5);
            setSubSegmentPosition(_fifthSegment, movementPosition, 4/5);
//            setSubSegmentPosition(_sixthSegment, movementPosition, 5/6);


            this.x = gameObject.preciseX + 8;
            this.y = gameObject.preciseY + 8;
        }

        private function setSubSegmentPosition(segment:Image, movementPosition:Number, offset:Number):void {
            if (movementPosition + offset < 1){
                segment.rotation = getRotationForSegment(eel, movementPosition + offset);
                segment.x = eel.prevX + eel.direction.dX * (movementPosition + offset) + 8;
                segment.y = eel.prevY + eel.direction.dY * (movementPosition + offset) + 8;
            } else {
                var prevSegment:IEelSegment = eel.previousSegment ? eel.previousSegment : eel.head;
                segment.rotation = getRotationForSegment(prevSegment, movementPosition - 1 + offset);
                segment.x = prevSegment.prevX + prevSegment.direction.dX * (movementPosition - 1 + offset) + 8;
                segment.y = prevSegment.prevY + prevSegment.direction.dY * (movementPosition - 1 + offset) + 8;
            }
        }

        private function getRotationForSegment(segment:IEelSegment, counterPosition:Number):Number {
//            if (segment.isMoving) {
//            return segment.direction.radians;
                if (segment.nextSegment && segment.nextSegment.getAngle() === segment.getAngle()) {
                    var midAngle:Number = Direction4.byDeltas(segment.x - segment.nextSegment.x, segment.y - segment.nextSegment.y).radians;
                    if (counterPosition < 0.5) {
                        return UtilsAngle.easeTwoRadians(
                            segment.nextSegment ? segment.nextSegment.getAngle() : segment.lastAngle,
                            midAngle,
                            counterPosition * 2
                        );
                    } else {
                        return UtilsAngle.easeTwoRadians(
                            midAngle,
                            segment.getAngle(),
                            (counterPosition - 0.5) * 2
                        );
                    }
                } else {
//                    return UtilsAngle.easeTwoRadians(
//                        segment.nextSegment ? segment.nextSegment.getAngle() : segment.lastAngle,
//                        segment.getAngle(),
//                        counterPosition
//                    );
                    if (segment.isTurnSegment){
                        return UtilsAngle.easeTwoRadians(
                            segment.nextSegment ? segment.nextSegment.getAngle() : segment.lastAngle,
                            segment.getAngle(),
                            counterPosition < 0.75 ? 0 : (counterPosition - 0.75) * 4
                        );

                    } else {
                        return UtilsAngle.easeTwoRadians(
                            segment.nextSegment ? segment.nextSegment.getAngle() : segment.lastAngle,
                            segment.getAngle(),
                            counterPosition > 0.25 ? 1 : counterPosition * 4
                        );
                    }
                }
//            } else {
//                return segment.getAngle();
//            }
        }

        private function get player():ObjectPlayer{
            return eel.player;
        }
    }
}
