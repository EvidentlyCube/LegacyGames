package net.retrocade.tacticengine.monstro.global.core
{
	import net.retrocade.signal.SignalPromiseOnce;
	import flash.display.BitmapData;

	public class MonstroGraphicFilesLoader
	{
		public static const MAP_BACKGROUNDS:String = "map/map_backgrounds.png";
		public static const MAP_PARCHMENT:String = "map/map_parchment.png";

		public static var onLoadingFinished:SignalPromiseOnce = new SignalPromiseOnce();

		public static function loadGraphicFiles():void
		{
			MonstroGraphicFilesLoaderImpl.onLoadingFinished.add(function(result: Boolean): void {
				MonstroGraphicFilesLoader.onLoadingFinished.call(result)
			});

			MonstroGraphicFilesLoaderImpl.loadGraphicFiles();
		}

		public static function getBitmapData(name:String):BitmapData
		{
			return MonstroGraphicFilesLoaderImpl.getBitmapData(name);
		}

	}
}

CF::desktop
	{
		import flash.display.Bitmap;
		import flash.display.BitmapData;
		import flash.events.Event;
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		import flash.filesystem.FileStream;
		import flash.utils.ByteArray;
		import flash.utils.Dictionary;

		import net.retrocade.helpers.RetrocamelLoader;
		import net.retrocade.signal.SignalPromiseOnce;
		import net.retrocade.utils.UtilsDictionary;

		import starling.textures.Texture;

		class MonstroGraphicFilesLoaderImpl
		{
			private static var _requiredFiles:Vector.<String> = new <String>[
				"map/map_backgrounds.png",
				"map/map_parchment.png"
			];

			private static var _loaderToNameMap:Dictionary;
			private static var _nameToBitmapDataMap:Dictionary;
			private static var _loadFailed:Boolean;
			private static var _isLoading:Boolean;

			public static var onLoadingFinished:SignalPromiseOnce = new SignalPromiseOnce();

			public static function loadGraphicFiles():void
			{
				if (_isLoading)
				{
					return;
				}

				_isLoading = true;
				_loaderToNameMap = new Dictionary();
				_nameToBitmapDataMap = new Dictionary();
				_loadFailed = false;

				var tilesetDir:File = File.applicationDirectory;
				if (!tilesetDir.exists)
				{
					throw new Error("Game directory does not exist?");
				}

				checkFilesExist(tilesetDir);
				loadImages(tilesetDir);
			}

			public static function getBitmapData(name:String):BitmapData
			{
				return _nameToBitmapDataMap[name];
			}

			private static function checkFilesExist(tilesetDir:File):void
			{
				for each (var file:String in _requiredFiles)
				{
					var path:File = tilesetDir.resolvePath(file);
					if (!path.exists)
					{
						throw new Error("File '" + file + "' does not exist.");
					}
					else if (path.isDirectory)
					{
						throw new Error("'" + file + "' is a directory, not a file.");
					}
				}
			}

			private static function loadImages(imagesDirectory:File):void
			{
				for each (var fileName:String in _requiredFiles)
				{
					var path:File = imagesDirectory.resolvePath(fileName);
					loadImage(fileName, path);
				}
			}

			private static function loadImage(name:String, path:File):void
			{
				var stream:FileStream = new FileStream();
				stream.open(path, FileMode.READ);

				var fileData:ByteArray = new ByteArray();
				stream.readBytes(fileData);
				stream.close();

				_loaderToNameMap[new RetrocamelLoader(fileData, onImageLoaded, onImageFailed)] = name;
			}

			private static function onImageLoaded(event:Event):void
			{
				var loader:RetrocamelLoader = event.target.loader;
				var name:String = _loaderToNameMap[loader];
				delete _loaderToNameMap[loader];

				_nameToBitmapDataMap[name] = Bitmap(loader.content).bitmapData;

				checkIfLoadFinished();
			}

			private static function onImageFailed(event:Event):void
			{
				var loader:RetrocamelLoader = event.target.loader;
				delete _loaderToNameMap[loader];

				_loadFailed = true;

				checkIfLoadFinished();
			}

			private static function checkIfLoadFinished():void
			{
				if (UtilsDictionary.countKeys(_loaderToNameMap) > 0)
				{
					return;
				}

				onLoadingFinished.call(!_loadFailed);
			}
		}
	}

	CF::flash
	{
		import flash.display.BitmapData;
		import flash.utils.Dictionary;

		import net.retrocade.signal.SignalPromiseOnce;

		import starling.textures.Texture;

		class MonstroGraphicFilesLoaderImpl
		{
			[Embed(source="/../assets/gfx/map/map_backgrounds.png")] private static var _map_backgrounds_class:Class;
			[Embed(source="/../assets/gfx/map/map_parchment.png")] private static var _map_parchment_class:Class;

			private static var _nameToBitmapDataMap:Dictionary;

			public static var onLoadingFinished:SignalPromiseOnce = new SignalPromiseOnce();

			public static function loadGraphicFiles():void
			{
				_nameToBitmapDataMap = new Dictionary();

				_nameToBitmapDataMap["map/map_backgrounds.png"] = (new _map_backgrounds_class()).bitmapData;
				_nameToBitmapDataMap["map/map_parchment.png"] = (new _map_backgrounds_class()).bitmapData;

				onLoadingFinished.call(true);
			}

			public static function getBitmapData(name:String):BitmapData
			{
				return _nameToBitmapDataMap[name];
			}
		}
	}