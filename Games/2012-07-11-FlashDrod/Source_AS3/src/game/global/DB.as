package game.global {
    import game.managers.VODBLoader;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.utils.Base64;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.media.Sound;
    import flash.utils.ByteArray;

    import game.managers.VOSpeech;

    import org.audiofx.mp3.MP3SWFMaker;

	/**
     * ...
     * @author
     */
    public class DB {
        private static var _speech :Array = [];
        private static var _assets :Array = [];
        private static var _loaders:Array = [];

        private static var _mp3:MP3SWFMaker = new MP3SWFMaker();

        private static var _queue:Array = [];

        private static var _queueTotal :uint = 0;
        private static var _queueLoaded:uint = 0;

        public static function getSpeech(id:uint):VOSpeech{
            return _speech[id];
        }

        public static function getSound(id:uint):Sound{
            return _assets[id] as Sound;
        }

        public static function getBitmapData(id:uint):BitmapData{
            return _assets[id] as BitmapData;
        }

        public static function get queueTotal():uint {
            return _queueTotal;
        }

        public static function get queueLoaded():uint {
            return _queueLoaded;
        }


        /******************************************************************************************************/
        /**                                                                                            QUEUE  */
        /******************************************************************************************************/

        /**
         * @return True if anything was run
         */
        public static function advanceQueue():Boolean {
            for (var index:String in _queue) {
                var element:VODBLoader = _queue[index] as VODBLoader;

                if (element) {
                    element.run();

                    delete _queue[index];

                    return true;
                }
            }

            return false;
        }


        /******************************************************************************************************/
        /**                                                                                    SPEECH LOADER  */
        /******************************************************************************************************/

        public static function queueSpeech(id:uint, xml:XML):void {
            _queue.push(new VODBLoader(id, xml, loadSpeech));
            _queueTotal++;
        }

        private static function loadSpeech(id:uint, xml:XML):void{
            _speech[id] = new VOSpeech(xml);
            _queueLoaded++;
        }



        /******************************************************************************************************/
        /**                                                                                     SOUND LOADER  */
        /******************************************************************************************************/

        public static function queueSound(id:uint, packedData:String):void {
            _queue.push(new VODBLoader(id, packedData, loadSound));

            _queueTotal++;
        }

        private static function loadSound(id:uint, packedData:String):void {
            var data:ByteArray = Base64.decodeByteArray(packedData);
            var swf :ByteArray = _mp3.getSound(data);

            var loader:Loader = new Loader();

            _loaders[id] = loader;

            loader.contentLoaderInfo.addEventListener(Event.INIT, removeSoundLoader);
            loader.loadBytes(swf);
        }

        private static function removeSoundLoader(e:Event):void{
            var loaderInfo:LoaderInfo = LoaderInfo(e.target);
            var loader    :Loader     = loaderInfo.loader;
            var index     :uint       = _loaders.indexOf(loader);

            var soundClass:Class = loaderInfo.applicationDomain.getDefinition("SoundClass") as Class;
            var sound     :Sound = new soundClass();

            _loaders[index] = null;
            delete _loaders[index];

            _assets[index] = sound;

            loader.contentLoaderInfo.removeEventListener(Event.INIT, removeSoundLoader);

            _queueLoaded++;
        }



        /******************************************************************************************************/
        /**                                                                                     IMAGE LOADER  */
        /******************************************************************************************************/

        public static function queueImage(id:uint, packedData:String):void {
            _queue.push(new VODBLoader(id, packedData, loadImage));

            _queueTotal++;
        }

        private static function loadImage(id:uint, packedData:String):void {
            var data:ByteArray = Base64.decodeByteArray(packedData);
            var loader:Loader = new Loader();

            _loaders[id] = loader;

            loader.contentLoaderInfo.addEventListener(Event.INIT, removeBitmapLoader);
            loader.loadBytes(data);
        }

        private static function removeBitmapLoader(e:Event):void {
            var loader:Loader     = LoaderInfo(e.target).loader;
            var data  :BitmapData = Bitmap(loader.content).bitmapData;
            var index :uint       = _loaders.indexOf(loader);

            _loaders[index] = null;

            _assets[index] = data;

            loader.contentLoaderInfo.removeEventListener(Event.INIT, removeBitmapLoader);

            _queueLoaded++;
        }



        /******************************************************************************************************/
        /**                                                                               EMBED IMAGE LOADER  */
        /******************************************************************************************************/

        public static function queueEmbedImage(id:uint, data:Class):void {
            _queue.push(new VODBLoader(id, data, loadEmbedImage));
            _queueTotal++;
        }

        private static function loadEmbedImage(id:*, data:Class):void {
            var loader:Loader = rGfx.load(data);
            loader.contentLoaderInfo.addEventListener(Event.INIT, removeEmbedBitmapLoader)

            _loaders[id] = loader;
        }

        private static function removeEmbedBitmapLoader(e:Event):void {
            var loader:Loader     = LoaderInfo(e.target).loader;
            var index :uint       = _loaders.indexOf(loader);

            _loaders[index] = null;

            loader.contentLoaderInfo.removeEventListener(Event.INIT, removeBitmapLoader);

            _queueLoaded++;
        }
    }

}