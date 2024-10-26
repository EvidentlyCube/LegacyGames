package submuncher.ingame.renderers.general {
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import starling.core.RenderSupport;
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.TextureSmoothing;
    import starling.utils.MatrixUtil;

    import S;
    import submuncher.ingame.core.LevelTilesArray;
    import submuncher.ingame.core.Tiles;

    public class TilemapRenderer extends DisplayObjectContainer {

        private static var sHelperMatrix:Matrix = new Matrix();
        private static var sHelperPoint:Point = new Point();
        private static const MAX_LEVEL_WIDTH_TILES:uint = 100;

        private var _isInitialized:Boolean;

        private var _tiles:Vector.<uint>;
        private var _tileGroups:Vector.<Sprite>;
        private var _tileImages:Vector.<Image>;

        private var _tilemapWidthTILE:uint;
        private var _tilemapHeightTILE:uint;

        private var _groupsWidth:uint;
        private var _groupsHeight:uint;

        private var _groupByX:uint;
        private var _groupByY:uint;

        private var _getTileCallback:Function;

        private var _isVisibilityDirty:Boolean;

        public function TilemapRenderer(getTileCallback:Function) {
            _getTileCallback = getTileCallback;

            usesEvents = false;

            touchable = false;

            _tileImages = new Vector.<Image>();
            _tileGroups = new Vector.<Sprite>();
        }

        public function setForLevel(tilemapWidthTILE:uint, tilemapHeightTILE:uint, groupByX:uint, groupByY:uint):void {
            A::SSERT{ASSERT(tilemapWidthTILE <= MAX_LEVEL_WIDTH_TILES);}

            cleanUp();

            _tilemapWidthTILE = tilemapWidthTILE;
            _tilemapHeightTILE = tilemapHeightTILE;
            _groupByX = groupByX;
            _groupByY = groupByY;
            _groupsWidth = Math.ceil(_tilemapWidthTILE / _groupByX);
            _groupsHeight = Math.ceil(_tilemapHeightTILE / _groupByY);

            _tileImages.length = Math.max(tilemapHeightTILE * MAX_LEVEL_WIDTH_TILES, _tileImages.length);

            removeChildren();
            createTileVector();
            createTileGroups();

            _isInitialized = true;
            _isVisibilityDirty = true;
        }

        private function createTileVector():void {
            _tiles = new Vector.<uint>(_tilemapWidthTILE * _tilemapHeightTILE, true);
            for (var i:int = 0; i < _tiles.length; i++) {
                _tiles[i] = Tiles.EMPTY;
            }
        }

        private function createTileGroups():void {
            _tileGroups.length = Math.max(_groupsWidth * _groupsHeight, _tileGroups.length);

            for (var x:int = 0; x < _groupsWidth; x++) {
                for (var y:int = 0; y < _groupsHeight; y++) {
                    var group:Sprite = _tileGroups[x + y * _groupsWidth];

                    if (!group){
                        group = new Sprite();
                    }

                    group.x = x * _groupByX * 16;
                    group.y = y * _groupByY * 16;
                    group.usesEvents = false;
                    _tileGroups[x + y * _groupsWidth] = group;
                }
            }
        }

        override public function dispose():void {
            if (_isInitialized) {
                cleanUp();

                super.dispose();
            }
        }

        private function cleanUp():void {
            if (_isInitialized) {
                _tiles = null;

                _isInitialized = false;
            }
        }

        public function renderFromTileArray(tileArray:LevelTilesArray):void {
            _tiles = tileArray.originalArray;

            refreshAllGroups();
        }

        public function refreshTiles(positionVector:Vector.<int>):void {
            for (var i:int = 0, l:int = positionVector.length; i < l; i += 2) {
                var groupX:int = positionVector[i] / _groupByX | 0;
                var groupY:int = positionVector[i + 1] / _groupByY | 0;

                refreshGroup(groupX, groupY);
            }
        }

        private function refreshAllGroups():void {
            for (var x:int = 0; x < _groupsWidth; x++) {
                for (var y:int = 0; y < _groupsHeight; y++) {
                    refreshGroup(x, y);
                }
            }

            _isVisibilityDirty = true;
        }

        private function refreshGroup(groupX:uint, groupY:uint):void {
            var groupIndex:uint = groupX + groupY * _groupsWidth;

            var group:Sprite = _tileGroups[groupIndex];
            group.removeChildren();
            addChild(group);

            var tileX:int;
            var tileY:int;
            xFor: for (var x:int = 0; x < _groupByX; x++) {
                yFor: for (var y:int = 0; y < _groupByY; y++) {
                    tileX = groupX * _groupByX + x;
                    tileY = groupY * _groupByY + y;

                    if (tileX >= _tilemapWidthTILE) {
                        break xFor;
                    } else if (tileY >= _tilemapHeightTILE) {
                        break yFor;
                    }

                    var tileIndex:uint = tileX + tileY * _tilemapWidthTILE;
                    var image:Image = _tileImages[tileX + tileY * MAX_LEVEL_WIDTH_TILES];

                    if (_tiles[tileIndex] === Tiles.EMPTY) {
                        continue;
                    }

                    if (!image){
                        image = new Image(_getTileCallback(_tiles[tileIndex]));
                        image.x = x * 16;
                        image.y = y * 16;
                        image.smoothing = TextureSmoothing.NONE;

                        group.addChild(image);
                        _tileImages[tileX + tileY * MAX_LEVEL_WIDTH_TILES] = image;
                    } else {
                        image.texture = _getTileCallback(_tiles[tileIndex]);
                        group.addChild(image);
                    }
                }
            }

            group.flatten();
        }

        public function refreshVisiblity():void {
            for (var x:int = 0; x < _groupsWidth; x++) {
                for (var y:int = 0; y < _groupsHeight; y++) {
                    var groupIndex:uint = x + y * _groupsWidth;
                    var group:Sprite = _tileGroups[groupIndex];

                    group.visible = group.x + this.x < S.gameWidth
                        && group.x + this.x + _groupByX * 16 > 0
                        && group.y + this.y < S.gameHeight
                        && group.y + this.y + _groupByY * 16 > 0;
                }
            }
        }

        override public function render(support:RenderSupport, parentAlpha:Number):void {
            if (_isVisibilityDirty){
                refreshVisiblity();
                _isVisibilityDirty = false;
            }

            super.render(support, parentAlpha);
//            var i:Image = new Image(getTextureForTile(0));
//
//            _quadBatch = new QuadBatch();
//            _quadBatch.addImage(i, 1, null, BlendMode.NORMAL);
//            _quadBatch.addTilemap(this);
//
//            support.addQuadBatch(_quadBatch);
        }


        override public function getChildEventListeners(object:DisplayObject, eventType:String, listeners:Vector.<DisplayObject>):void {
        }

        override public function broadcastEvent(event:Event):void {
        }

        override public function set y(value:Number):void {
            super.y = value;

            _isVisibilityDirty = true;
        }

        override public function set x(value:Number):void {
            super.x = value;

            _isVisibilityDirty = true;
        }

        override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null):Rectangle {
            if (resultRect == null) resultRect = new Rectangle();

            getTransformationMatrix(targetSpace, sHelperMatrix);
            MatrixUtil.transformCoords(sHelperMatrix, 0.0, 0.0, sHelperPoint);
            resultRect.x = sHelperPoint.x;
            resultRect.y = sHelperPoint.y;
            MatrixUtil.transformCoords(sHelperMatrix, width, height, sHelperPoint);
            resultRect.width = sHelperPoint.x;
            resultRect.height = sHelperPoint.y;

            return resultRect;
        }

        override public function get width():Number {
            return _tilemapWidthTILE * 16 * scaleX;
        }

        override public function get height():Number {
            return _tilemapHeightTILE * 16 * scaleY;
        }
    }
}
