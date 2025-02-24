


package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.signal.Signal;
	import net.retrocade.tacticengine.core.injector.injectCreate;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroEscapeBlocker;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.gui.helpers.WindowSliderCounter;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroPrettyWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;

	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.VAlign;

	public class MonstroWindowMessage extends RetrocamelWindowStarling {
		public static function show(header:String, text:String, width:uint = 500, pauseGame:Boolean = true):MonstroWindowMessage {
			var instance:MonstroWindowMessage = injectCreate(MonstroWindowMessage);

			instance.windowWidth = width;
			instance.headerToShow = header;
			instance.textToShow = text;
			instance.pauseGame = pauseGame;

			instance.show();

			return instance;
		}

		private var _background:MonstroPrettyWindowGrid9;
		private var _parchment:MonstroGrid9;
		private var _text:TextField;
		private var _close:MonstroTextButton;

		private var _isHiding:Boolean;
		private var _sliderCounter:WindowSliderCounter;

		public var headerToShow:String;
		public var textToShow:String;
		public var windowWidth:uint;
		public var onClosing:Signal;


		override public function show():void {
			MonstroWindowModal.show();

			initCreateObjects();
			initializeObjectProperties();

			var displayGroup:MonstroDisplayGroup = new MonstroDisplayGroup();

			displayGroup.addElement(_text);
			_parchment.wrapAround(_text);

			_close.forcedWidth = _parchment.innerWidth;
			_close.alignCenterParent(0, _parchment.width);
			_close.y = _parchment.bottom;

			displayGroup.addElement(_parchment);
			displayGroup.addElement(_close);
			_background.wrapAround(displayGroup);

			addChildren([_background, _parchment, _text, _close]);

			super.show();
			resize();

			displayGroup.dispose();
		}

		override public function hide():void {
			removeChildren();

			onClosing.clear();
			_sliderCounter.dispose();
			_background.dispose();
			_text.dispose();
			_close.dispose();

			onClosing = null;
			_sliderCounter = null;
			_background = null;
			_text = null;
			_close = null;

			super.hide();
		}

		override public function update():void {
			if (MonstroEscapeBlocker.isEscapeDown) {
				MonstroEscapeBlocker.flush();
				startHiding();
			}

			if (_sliderCounter.update()){
				refreshPosition();
			}

			if (_sliderCounter.isFullyHidden){
				hide();
			}
		}

		private function refreshPosition():void {
			var calculatedPosition:Number = _sliderCounter.positionFactor;

			middle = MonstroConsts.gameHeight / 2 + calculatedPosition * (MonstroConsts.gameHeight / 2 + height);
			alignCenter();
		}

		private function startHiding():void {
			if (_isHiding) {
				return;
			}

			_isHiding = true;

			_sliderCounter.hide();
			onClosing.call();
		}

		private function initializeObjectProperties():void {
			_background.header = headerToShow;

			_text.htmlText = true;
			_text.autoSize = TextFieldAutoSize.VERTICAL;
			_text.vAlign = VAlign.TOP;

			_blockUnder = false;
		}

		private function initCreateObjects():void {
			_background = new MonstroPrettyWindowGrid9();
			_parchment = MonstroGfx.getGrid9Parchment();
			_text = new TextField(windowWidth - 180, 500, textToShow, MonstroConsts.FONT_EBORACUM_48, 24, 0x382010);
			_close = new MonstroTextButton(_("title_close"), onClose);

			_sliderCounter = new WindowSliderCounter(1.2);
			onClosing = new Signal();
		}

		private function onClose():void {
			startHiding();
		}


		override public function resize():void {
			super.resize();

			refreshPosition();
		}
	}
}