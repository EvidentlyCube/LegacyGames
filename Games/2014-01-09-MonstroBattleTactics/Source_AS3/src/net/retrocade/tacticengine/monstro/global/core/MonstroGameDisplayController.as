package net.retrocade.tacticengine.monstro.global.core {
	CF::desktop {
		import flash.desktop.NativeApplication;
		import flash.events.NativeWindowDisplayStateEvent;
		import flash.display.NativeWindow;
		import flash.display.NativeWindowDisplayState;
	}
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;

	import net.retrocade.constants.KeyConst;
	import net.retrocade.retrocamel.core.RetrocamelDisplayManager;

	public class MonstroGameDisplayController {
		public static function initialize(root:DisplayObject):void {
			RetrocamelDisplayManager.onFullScreenToggled.add(saveFullScreenSettings);
			RetrocamelDisplayManager.onStageResized.add(saveWindowOptions);

			CF::desktop {
				NativeApplication.nativeApplication.activeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, onDisplayStateChanged);
			}
			root.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}

		private static function keyDownHandler(event:KeyboardEvent):void {
			if (event.keyCode === KeyConst.F10 || (event.altKey && event.keyCode === KeyConst.ENTER)) {
				RetrocamelDisplayManager.isFullscreen = !RetrocamelDisplayManager.isFullscreen;
				event.stopImmediatePropagation();
				event.preventDefault();
			}
		}

		private static function saveFullScreenSettings():void {
			MonstroData.setIsFullscreen(RetrocamelDisplayManager.isFullscreen);
			MonstroData.commitData();
		}

		CF::desktop {
			private static function onDisplayStateChanged(event:NativeWindowDisplayStateEvent):void {
				if (MonstroData.isInitialized){
					MonstroData.setWindowMaximized(event.afterDisplayState === NativeWindowDisplayState.MAXIMIZED);
				}
			}
		}

 		private static function saveWindowOptions():void {
			CF::desktop {
				if (!RetrocamelDisplayManager.isFullscreen && MonstroData.isInitialized && !MonstroData.getWindowMaximized()) {
					var activeWindow:NativeWindow = NativeApplication.nativeApplication.activeWindow;

					if (activeWindow) {
						MonstroData.setWindowWidth(activeWindow.width);
						MonstroData.setWindowHeight(activeWindow.height);
					}
				}

				MonstroData.commitData();
			}
		}
	}
}
